import 'dart:convert';

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../models/reminder.dart';

class ReminderRepository {
  ReminderRepository({Database? database}) : _database = database;

  static const _dbName = 'reminders.db';
  static const _tableName = 'reminders';
  static const _dbVersion = 2;

  Database? _database;

  Future<Database> get _db async {
    if (_database != null) return _database!;

    final databasesPath = await getDatabasesPath();
    final path = p.join(databasesPath, _dbName);

    _database = await openDatabase(
      path,
      version: _dbVersion,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
      onCreate: (db, version) async => await db.execute('''
        CREATE TABLE $_tableName (
          id TEXT PRIMARY KEY,
          title TEXT NOT NULL,
          date INTEGER NOT NULL,
          times TEXT NOT NULL,
          repeat TEXT NOT NULL,
          category TEXT NOT NULL,
          priority TEXT NOT NULL,
          location TEXT,
          location_based INTEGER NOT NULL,
          latitude REAL,
          longitude REAL,
          description TEXT
        )
      '''),
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE $_tableName ADD COLUMN description TEXT');
        }
      },
    );
    return _database!;
  }

  Future<List<Reminder>> fetchReminders() async {
    final database = await _db;
    final rows = await database.query(
      _tableName,
      orderBy: 'date ASC, title COLLATE NOCASE',
    );
    return rows.map(_mapToReminder).toList();
  }

  Future<void> saveReminder(Reminder reminder) async {
    final database = await _db;
    await database.insert(
      _tableName,
      _mapFromReminder(reminder),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteReminder(String id) async {
    final database = await _db;
    await database.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clear() async {
    final database = await _db;
    await database.delete(_tableName);
  }

  Reminder _mapToReminder(Map<String, Object?> map) {
    final repeatName = map['repeat'] as String?;
    final categoryName = map['category'] as String?;
    final priorityName = map['priority'] as String?;

    return Reminder(
      id: map['id'] as String,
      title: map['title'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      times: _decodeTimes(map['times']),
      repeat: _parseEnum(
        ReminderRepeat.values,
        repeatName,
        ReminderRepeat.once,
      ),
      category: _parseEnum(
        ReminderCategory.values,
        categoryName,
        ReminderCategory.work,
      ),
      priority: _parseEnum(
        ReminderPriority.values,
        priorityName,
        ReminderPriority.medium,
      ),
      location: map['location'] as String?,
      locationBased: (map['location_based'] as int) == 1,
      latitude: _toDouble(map['latitude']),
      longitude: _toDouble(map['longitude']),
      description: map['description'] as String?,
    );
  }

  Map<String, Object?> _mapFromReminder(Reminder reminder) => {
        'id': reminder.id,
        'title': reminder.title,
        'date': reminder.date.millisecondsSinceEpoch,
        'times': jsonEncode(reminder.times),
        'repeat': reminder.repeat.name,
        'category': reminder.category.name,
        'priority': reminder.priority.name,
        'location': reminder.location,
        'location_based': reminder.locationBased ? 1 : 0,
        'latitude': reminder.latitude,
        'longitude': reminder.longitude,
        'description': reminder.description,
      };

  List<String> _decodeTimes(Object? value) {
    if (value is String) {
      final decoded = jsonDecode(value);
      if (decoded is List) return decoded.map((e) => e.toString()).toList();
    }
    return const ['9:00 AM'];
  }

  T _parseEnum<T>(List<T> values, String? name, T fallback) {
    if (name == null) return fallback;
    for (final value in values) {
      if (value is Enum && value.name == name) {
        return value;
      }
    }
    return fallback;
  }

  double? _toDouble(Object? value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }
}
