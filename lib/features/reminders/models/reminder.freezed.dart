// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Reminder {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  List<String> get times => throw _privateConstructorUsedError;
  ReminderRepeat get repeat => throw _privateConstructorUsedError;
  ReminderCategory get category => throw _privateConstructorUsedError;
  ReminderPriority get priority => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  bool get locationBased => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReminderCopyWith<Reminder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReminderCopyWith<$Res> {
  factory $ReminderCopyWith(Reminder value, $Res Function(Reminder) then) =
      _$ReminderCopyWithImpl<$Res, Reminder>;
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime date,
      List<String> times,
      ReminderRepeat repeat,
      ReminderCategory category,
      ReminderPriority priority,
      String? location,
      bool locationBased,
      double? latitude,
      double? longitude,
      String? note});
}

/// @nodoc
class _$ReminderCopyWithImpl<$Res, $Val extends Reminder>
    implements $ReminderCopyWith<$Res> {
  _$ReminderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? date = null,
    Object? times = null,
    Object? repeat = null,
    Object? category = null,
    Object? priority = null,
    Object? location = freezed,
    Object? locationBased = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      times: null == times
          ? _value.times
          : times // ignore: cast_nullable_to_non_nullable
              as List<String>,
      repeat: null == repeat
          ? _value.repeat
          : repeat // ignore: cast_nullable_to_non_nullable
              as ReminderRepeat,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ReminderCategory,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as ReminderPriority,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      locationBased: null == locationBased
          ? _value.locationBased
          : locationBased // ignore: cast_nullable_to_non_nullable
              as bool,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReminderImplCopyWith<$Res>
    implements $ReminderCopyWith<$Res> {
  factory _$$ReminderImplCopyWith(
          _$ReminderImpl value, $Res Function(_$ReminderImpl) then) =
      __$$ReminderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime date,
      List<String> times,
      ReminderRepeat repeat,
      ReminderCategory category,
      ReminderPriority priority,
      String? location,
      bool locationBased,
      double? latitude,
      double? longitude,
      String? note});
}

/// @nodoc
class __$$ReminderImplCopyWithImpl<$Res>
    extends _$ReminderCopyWithImpl<$Res, _$ReminderImpl>
    implements _$$ReminderImplCopyWith<$Res> {
  __$$ReminderImplCopyWithImpl(
      _$ReminderImpl _value, $Res Function(_$ReminderImpl) _then)
      : super(_value, _then);

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? date = null,
    Object? times = null,
    Object? repeat = null,
    Object? category = null,
    Object? priority = null,
    Object? location = freezed,
    Object? locationBased = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? note = freezed,
  }) {
    return _then(_$ReminderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      times: null == times
          ? _value._times
          : times // ignore: cast_nullable_to_non_nullable
              as List<String>,
      repeat: null == repeat
          ? _value.repeat
          : repeat // ignore: cast_nullable_to_non_nullable
              as ReminderRepeat,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ReminderCategory,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as ReminderPriority,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      locationBased: null == locationBased
          ? _value.locationBased
          : locationBased // ignore: cast_nullable_to_non_nullable
              as bool,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ReminderImpl implements _Reminder {
  const _$ReminderImpl(
      {required this.id,
      required this.title,
      required this.date,
      required final List<String> times,
      this.repeat = ReminderRepeat.once,
      this.category = ReminderCategory.work,
      this.priority = ReminderPriority.medium,
      this.location,
      this.locationBased = false,
      this.latitude,
      this.longitude,
      this.note})
      : _times = times;

  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime date;
  final List<String> _times;
  @override
  List<String> get times {
    if (_times is EqualUnmodifiableListView) return _times;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_times);
  }

  @override
  @JsonKey()
  final ReminderRepeat repeat;
  @override
  @JsonKey()
  final ReminderCategory category;
  @override
  @JsonKey()
  final ReminderPriority priority;
  @override
  final String? location;
  @override
  @JsonKey()
  final bool locationBased;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? note;

  @override
  String toString() {
    return 'Reminder(id: $id, title: $title, date: $date, times: $times, repeat: $repeat, category: $category, priority: $priority, location: $location, locationBased: $locationBased, latitude: $latitude, longitude: $longitude, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReminderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._times, _times) &&
            (identical(other.repeat, repeat) || other.repeat == repeat) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.locationBased, locationBased) ||
                other.locationBased == locationBased) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.note, note) || other.note == note));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      date,
      const DeepCollectionEquality().hash(_times),
      repeat,
      category,
      priority,
      location,
      locationBased,
      latitude,
      longitude,
      note);

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReminderImplCopyWith<_$ReminderImpl> get copyWith =>
      __$$ReminderImplCopyWithImpl<_$ReminderImpl>(this, _$identity);
}

abstract class _Reminder implements Reminder {
  const factory _Reminder(
      {required final String id,
      required final String title,
      required final DateTime date,
      required final List<String> times,
      final ReminderRepeat repeat,
      final ReminderCategory category,
      final ReminderPriority priority,
      final String? location,
      final bool locationBased,
      final double? latitude,
      final double? longitude,
      final String? note}) = _$ReminderImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  DateTime get date;
  @override
  List<String> get times;
  @override
  ReminderRepeat get repeat;
  @override
  ReminderCategory get category;
  @override
  ReminderPriority get priority;
  @override
  String? get location;
  @override
  bool get locationBased;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String? get note;

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReminderImplCopyWith<_$ReminderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
