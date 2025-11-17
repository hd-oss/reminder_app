// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReminderFormState {
  Reminder? get editing => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  List<String> get times => throw _privateConstructorUsedError;
  ReminderRepeat get repeat => throw _privateConstructorUsedError;
  ReminderCategory get category => throw _privateConstructorUsedError;
  ReminderPriority get priority => throw _privateConstructorUsedError;
  bool get locationBased => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  double? get radiusMeters => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;

  /// Create a copy of ReminderFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReminderFormStateCopyWith<ReminderFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReminderFormStateCopyWith<$Res> {
  factory $ReminderFormStateCopyWith(
          ReminderFormState value, $Res Function(ReminderFormState) then) =
      _$ReminderFormStateCopyWithImpl<$Res, ReminderFormState>;
  @useResult
  $Res call(
      {Reminder? editing,
      String title,
      DateTime date,
      List<String> times,
      ReminderRepeat repeat,
      ReminderCategory category,
      ReminderPriority priority,
      bool locationBased,
      String location,
      double? radiusMeters,
      String description,
      double? latitude,
      double? longitude});

  $ReminderCopyWith<$Res>? get editing;
}

/// @nodoc
class _$ReminderFormStateCopyWithImpl<$Res, $Val extends ReminderFormState>
    implements $ReminderFormStateCopyWith<$Res> {
  _$ReminderFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReminderFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? editing = freezed,
    Object? title = null,
    Object? date = null,
    Object? times = null,
    Object? repeat = null,
    Object? category = null,
    Object? priority = null,
    Object? locationBased = null,
    Object? location = null,
    Object? radiusMeters = freezed,
    Object? description = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_value.copyWith(
      editing: freezed == editing
          ? _value.editing
          : editing // ignore: cast_nullable_to_non_nullable
              as Reminder?,
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
      locationBased: null == locationBased
          ? _value.locationBased
          : locationBased // ignore: cast_nullable_to_non_nullable
              as bool,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      radiusMeters: freezed == radiusMeters
          ? _value.radiusMeters
          : radiusMeters // ignore: cast_nullable_to_non_nullable
              as double?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  /// Create a copy of ReminderFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReminderCopyWith<$Res>? get editing {
    if (_value.editing == null) {
      return null;
    }

    return $ReminderCopyWith<$Res>(_value.editing!, (value) {
      return _then(_value.copyWith(editing: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReminderFormStateImplCopyWith<$Res>
    implements $ReminderFormStateCopyWith<$Res> {
  factory _$$ReminderFormStateImplCopyWith(_$ReminderFormStateImpl value,
          $Res Function(_$ReminderFormStateImpl) then) =
      __$$ReminderFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Reminder? editing,
      String title,
      DateTime date,
      List<String> times,
      ReminderRepeat repeat,
      ReminderCategory category,
      ReminderPriority priority,
      bool locationBased,
      String location,
      double? radiusMeters,
      String description,
      double? latitude,
      double? longitude});

  @override
  $ReminderCopyWith<$Res>? get editing;
}

/// @nodoc
class __$$ReminderFormStateImplCopyWithImpl<$Res>
    extends _$ReminderFormStateCopyWithImpl<$Res, _$ReminderFormStateImpl>
    implements _$$ReminderFormStateImplCopyWith<$Res> {
  __$$ReminderFormStateImplCopyWithImpl(_$ReminderFormStateImpl _value,
      $Res Function(_$ReminderFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? editing = freezed,
    Object? title = null,
    Object? date = null,
    Object? times = null,
    Object? repeat = null,
    Object? category = null,
    Object? priority = null,
    Object? locationBased = null,
    Object? location = null,
    Object? radiusMeters = freezed,
    Object? description = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_$ReminderFormStateImpl(
      editing: freezed == editing
          ? _value.editing
          : editing // ignore: cast_nullable_to_non_nullable
              as Reminder?,
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
      locationBased: null == locationBased
          ? _value.locationBased
          : locationBased // ignore: cast_nullable_to_non_nullable
              as bool,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      radiusMeters: freezed == radiusMeters
          ? _value.radiusMeters
          : radiusMeters // ignore: cast_nullable_to_non_nullable
              as double?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$ReminderFormStateImpl implements _ReminderFormState {
  const _$ReminderFormStateImpl(
      {this.editing,
      required this.title,
      required this.date,
      required final List<String> times,
      required this.repeat,
      required this.category,
      required this.priority,
      required this.locationBased,
      required this.location,
      this.radiusMeters,
      required this.description,
      this.latitude,
      this.longitude})
      : _times = times;

  @override
  final Reminder? editing;
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
  final ReminderRepeat repeat;
  @override
  final ReminderCategory category;
  @override
  final ReminderPriority priority;
  @override
  final bool locationBased;
  @override
  final String location;
  @override
  final double? radiusMeters;
  @override
  final String description;
  @override
  final double? latitude;
  @override
  final double? longitude;

  @override
  String toString() {
    return 'ReminderFormState(editing: $editing, title: $title, date: $date, times: $times, repeat: $repeat, category: $category, priority: $priority, locationBased: $locationBased, location: $location, radiusMeters: $radiusMeters, description: $description, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReminderFormStateImpl &&
            (identical(other.editing, editing) || other.editing == editing) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._times, _times) &&
            (identical(other.repeat, repeat) || other.repeat == repeat) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.locationBased, locationBased) ||
                other.locationBased == locationBased) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.radiusMeters, radiusMeters) ||
                other.radiusMeters == radiusMeters) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      editing,
      title,
      date,
      const DeepCollectionEquality().hash(_times),
      repeat,
      category,
      priority,
      locationBased,
      location,
      radiusMeters,
      description,
      latitude,
      longitude);

  /// Create a copy of ReminderFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReminderFormStateImplCopyWith<_$ReminderFormStateImpl> get copyWith =>
      __$$ReminderFormStateImplCopyWithImpl<_$ReminderFormStateImpl>(
          this, _$identity);
}

abstract class _ReminderFormState implements ReminderFormState {
  const factory _ReminderFormState(
      {final Reminder? editing,
      required final String title,
      required final DateTime date,
      required final List<String> times,
      required final ReminderRepeat repeat,
      required final ReminderCategory category,
      required final ReminderPriority priority,
      required final bool locationBased,
      required final String location,
      final double? radiusMeters,
      required final String description,
      final double? latitude,
      final double? longitude}) = _$ReminderFormStateImpl;

  @override
  Reminder? get editing;
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
  bool get locationBased;
  @override
  String get location;
  @override
  double? get radiusMeters;
  @override
  String get description;
  @override
  double? get latitude;
  @override
  double? get longitude;

  /// Create a copy of ReminderFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReminderFormStateImplCopyWith<_$ReminderFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
