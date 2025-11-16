// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReminderListEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ReminderFilter filter) filterChanged,
    required TResult Function(Reminder reminder) reminderAdded,
    required TResult Function(Reminder reminder) reminderUpdated,
    required TResult Function(String id) reminderDeleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ReminderFilter filter)? filterChanged,
    TResult? Function(Reminder reminder)? reminderAdded,
    TResult? Function(Reminder reminder)? reminderUpdated,
    TResult? Function(String id)? reminderDeleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ReminderFilter filter)? filterChanged,
    TResult Function(Reminder reminder)? reminderAdded,
    TResult Function(Reminder reminder)? reminderUpdated,
    TResult Function(String id)? reminderDeleted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FilterChanged value) filterChanged,
    required TResult Function(_ReminderAdded value) reminderAdded,
    required TResult Function(_ReminderUpdated value) reminderUpdated,
    required TResult Function(_ReminderDeleted value) reminderDeleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FilterChanged value)? filterChanged,
    TResult? Function(_ReminderAdded value)? reminderAdded,
    TResult? Function(_ReminderUpdated value)? reminderUpdated,
    TResult? Function(_ReminderDeleted value)? reminderDeleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FilterChanged value)? filterChanged,
    TResult Function(_ReminderAdded value)? reminderAdded,
    TResult Function(_ReminderUpdated value)? reminderUpdated,
    TResult Function(_ReminderDeleted value)? reminderDeleted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReminderListEventCopyWith<$Res> {
  factory $ReminderListEventCopyWith(
          ReminderListEvent value, $Res Function(ReminderListEvent) then) =
      _$ReminderListEventCopyWithImpl<$Res, ReminderListEvent>;
}

/// @nodoc
class _$ReminderListEventCopyWithImpl<$Res, $Val extends ReminderListEvent>
    implements $ReminderListEventCopyWith<$Res> {
  _$ReminderListEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReminderListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FilterChangedImplCopyWith<$Res> {
  factory _$$FilterChangedImplCopyWith(
          _$FilterChangedImpl value, $Res Function(_$FilterChangedImpl) then) =
      __$$FilterChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ReminderFilter filter});
}

/// @nodoc
class __$$FilterChangedImplCopyWithImpl<$Res>
    extends _$ReminderListEventCopyWithImpl<$Res, _$FilterChangedImpl>
    implements _$$FilterChangedImplCopyWith<$Res> {
  __$$FilterChangedImplCopyWithImpl(
      _$FilterChangedImpl _value, $Res Function(_$FilterChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filter = null,
  }) {
    return _then(_$FilterChangedImpl(
      null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as ReminderFilter,
    ));
  }
}

/// @nodoc

class _$FilterChangedImpl implements _FilterChanged {
  const _$FilterChangedImpl(this.filter);

  @override
  final ReminderFilter filter;

  @override
  String toString() {
    return 'ReminderListEvent.filterChanged(filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterChangedImpl &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filter);

  /// Create a copy of ReminderListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterChangedImplCopyWith<_$FilterChangedImpl> get copyWith =>
      __$$FilterChangedImplCopyWithImpl<_$FilterChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ReminderFilter filter) filterChanged,
    required TResult Function(Reminder reminder) reminderAdded,
    required TResult Function(Reminder reminder) reminderUpdated,
    required TResult Function(String id) reminderDeleted,
  }) {
    return filterChanged(filter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ReminderFilter filter)? filterChanged,
    TResult? Function(Reminder reminder)? reminderAdded,
    TResult? Function(Reminder reminder)? reminderUpdated,
    TResult? Function(String id)? reminderDeleted,
  }) {
    return filterChanged?.call(filter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ReminderFilter filter)? filterChanged,
    TResult Function(Reminder reminder)? reminderAdded,
    TResult Function(Reminder reminder)? reminderUpdated,
    TResult Function(String id)? reminderDeleted,
    required TResult orElse(),
  }) {
    if (filterChanged != null) {
      return filterChanged(filter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FilterChanged value) filterChanged,
    required TResult Function(_ReminderAdded value) reminderAdded,
    required TResult Function(_ReminderUpdated value) reminderUpdated,
    required TResult Function(_ReminderDeleted value) reminderDeleted,
  }) {
    return filterChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FilterChanged value)? filterChanged,
    TResult? Function(_ReminderAdded value)? reminderAdded,
    TResult? Function(_ReminderUpdated value)? reminderUpdated,
    TResult? Function(_ReminderDeleted value)? reminderDeleted,
  }) {
    return filterChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FilterChanged value)? filterChanged,
    TResult Function(_ReminderAdded value)? reminderAdded,
    TResult Function(_ReminderUpdated value)? reminderUpdated,
    TResult Function(_ReminderDeleted value)? reminderDeleted,
    required TResult orElse(),
  }) {
    if (filterChanged != null) {
      return filterChanged(this);
    }
    return orElse();
  }
}

abstract class _FilterChanged implements ReminderListEvent {
  const factory _FilterChanged(final ReminderFilter filter) =
      _$FilterChangedImpl;

  ReminderFilter get filter;

  /// Create a copy of ReminderListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterChangedImplCopyWith<_$FilterChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReminderAddedImplCopyWith<$Res> {
  factory _$$ReminderAddedImplCopyWith(
          _$ReminderAddedImpl value, $Res Function(_$ReminderAddedImpl) then) =
      __$$ReminderAddedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Reminder reminder});

  $ReminderCopyWith<$Res> get reminder;
}

/// @nodoc
class __$$ReminderAddedImplCopyWithImpl<$Res>
    extends _$ReminderListEventCopyWithImpl<$Res, _$ReminderAddedImpl>
    implements _$$ReminderAddedImplCopyWith<$Res> {
  __$$ReminderAddedImplCopyWithImpl(
      _$ReminderAddedImpl _value, $Res Function(_$ReminderAddedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reminder = null,
  }) {
    return _then(_$ReminderAddedImpl(
      null == reminder
          ? _value.reminder
          : reminder // ignore: cast_nullable_to_non_nullable
              as Reminder,
    ));
  }

  /// Create a copy of ReminderListEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReminderCopyWith<$Res> get reminder {
    return $ReminderCopyWith<$Res>(_value.reminder, (value) {
      return _then(_value.copyWith(reminder: value));
    });
  }
}

/// @nodoc

class _$ReminderAddedImpl implements _ReminderAdded {
  const _$ReminderAddedImpl(this.reminder);

  @override
  final Reminder reminder;

  @override
  String toString() {
    return 'ReminderListEvent.reminderAdded(reminder: $reminder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReminderAddedImpl &&
            (identical(other.reminder, reminder) ||
                other.reminder == reminder));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reminder);

  /// Create a copy of ReminderListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReminderAddedImplCopyWith<_$ReminderAddedImpl> get copyWith =>
      __$$ReminderAddedImplCopyWithImpl<_$ReminderAddedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ReminderFilter filter) filterChanged,
    required TResult Function(Reminder reminder) reminderAdded,
    required TResult Function(Reminder reminder) reminderUpdated,
    required TResult Function(String id) reminderDeleted,
  }) {
    return reminderAdded(reminder);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ReminderFilter filter)? filterChanged,
    TResult? Function(Reminder reminder)? reminderAdded,
    TResult? Function(Reminder reminder)? reminderUpdated,
    TResult? Function(String id)? reminderDeleted,
  }) {
    return reminderAdded?.call(reminder);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ReminderFilter filter)? filterChanged,
    TResult Function(Reminder reminder)? reminderAdded,
    TResult Function(Reminder reminder)? reminderUpdated,
    TResult Function(String id)? reminderDeleted,
    required TResult orElse(),
  }) {
    if (reminderAdded != null) {
      return reminderAdded(reminder);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FilterChanged value) filterChanged,
    required TResult Function(_ReminderAdded value) reminderAdded,
    required TResult Function(_ReminderUpdated value) reminderUpdated,
    required TResult Function(_ReminderDeleted value) reminderDeleted,
  }) {
    return reminderAdded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FilterChanged value)? filterChanged,
    TResult? Function(_ReminderAdded value)? reminderAdded,
    TResult? Function(_ReminderUpdated value)? reminderUpdated,
    TResult? Function(_ReminderDeleted value)? reminderDeleted,
  }) {
    return reminderAdded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FilterChanged value)? filterChanged,
    TResult Function(_ReminderAdded value)? reminderAdded,
    TResult Function(_ReminderUpdated value)? reminderUpdated,
    TResult Function(_ReminderDeleted value)? reminderDeleted,
    required TResult orElse(),
  }) {
    if (reminderAdded != null) {
      return reminderAdded(this);
    }
    return orElse();
  }
}

abstract class _ReminderAdded implements ReminderListEvent {
  const factory _ReminderAdded(final Reminder reminder) = _$ReminderAddedImpl;

  Reminder get reminder;

  /// Create a copy of ReminderListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReminderAddedImplCopyWith<_$ReminderAddedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReminderUpdatedImplCopyWith<$Res> {
  factory _$$ReminderUpdatedImplCopyWith(_$ReminderUpdatedImpl value,
          $Res Function(_$ReminderUpdatedImpl) then) =
      __$$ReminderUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Reminder reminder});

  $ReminderCopyWith<$Res> get reminder;
}

/// @nodoc
class __$$ReminderUpdatedImplCopyWithImpl<$Res>
    extends _$ReminderListEventCopyWithImpl<$Res, _$ReminderUpdatedImpl>
    implements _$$ReminderUpdatedImplCopyWith<$Res> {
  __$$ReminderUpdatedImplCopyWithImpl(
      _$ReminderUpdatedImpl _value, $Res Function(_$ReminderUpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reminder = null,
  }) {
    return _then(_$ReminderUpdatedImpl(
      null == reminder
          ? _value.reminder
          : reminder // ignore: cast_nullable_to_non_nullable
              as Reminder,
    ));
  }

  /// Create a copy of ReminderListEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReminderCopyWith<$Res> get reminder {
    return $ReminderCopyWith<$Res>(_value.reminder, (value) {
      return _then(_value.copyWith(reminder: value));
    });
  }
}

/// @nodoc

class _$ReminderUpdatedImpl implements _ReminderUpdated {
  const _$ReminderUpdatedImpl(this.reminder);

  @override
  final Reminder reminder;

  @override
  String toString() {
    return 'ReminderListEvent.reminderUpdated(reminder: $reminder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReminderUpdatedImpl &&
            (identical(other.reminder, reminder) ||
                other.reminder == reminder));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reminder);

  /// Create a copy of ReminderListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReminderUpdatedImplCopyWith<_$ReminderUpdatedImpl> get copyWith =>
      __$$ReminderUpdatedImplCopyWithImpl<_$ReminderUpdatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ReminderFilter filter) filterChanged,
    required TResult Function(Reminder reminder) reminderAdded,
    required TResult Function(Reminder reminder) reminderUpdated,
    required TResult Function(String id) reminderDeleted,
  }) {
    return reminderUpdated(reminder);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ReminderFilter filter)? filterChanged,
    TResult? Function(Reminder reminder)? reminderAdded,
    TResult? Function(Reminder reminder)? reminderUpdated,
    TResult? Function(String id)? reminderDeleted,
  }) {
    return reminderUpdated?.call(reminder);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ReminderFilter filter)? filterChanged,
    TResult Function(Reminder reminder)? reminderAdded,
    TResult Function(Reminder reminder)? reminderUpdated,
    TResult Function(String id)? reminderDeleted,
    required TResult orElse(),
  }) {
    if (reminderUpdated != null) {
      return reminderUpdated(reminder);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FilterChanged value) filterChanged,
    required TResult Function(_ReminderAdded value) reminderAdded,
    required TResult Function(_ReminderUpdated value) reminderUpdated,
    required TResult Function(_ReminderDeleted value) reminderDeleted,
  }) {
    return reminderUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FilterChanged value)? filterChanged,
    TResult? Function(_ReminderAdded value)? reminderAdded,
    TResult? Function(_ReminderUpdated value)? reminderUpdated,
    TResult? Function(_ReminderDeleted value)? reminderDeleted,
  }) {
    return reminderUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FilterChanged value)? filterChanged,
    TResult Function(_ReminderAdded value)? reminderAdded,
    TResult Function(_ReminderUpdated value)? reminderUpdated,
    TResult Function(_ReminderDeleted value)? reminderDeleted,
    required TResult orElse(),
  }) {
    if (reminderUpdated != null) {
      return reminderUpdated(this);
    }
    return orElse();
  }
}

abstract class _ReminderUpdated implements ReminderListEvent {
  const factory _ReminderUpdated(final Reminder reminder) =
      _$ReminderUpdatedImpl;

  Reminder get reminder;

  /// Create a copy of ReminderListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReminderUpdatedImplCopyWith<_$ReminderUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReminderDeletedImplCopyWith<$Res> {
  factory _$$ReminderDeletedImplCopyWith(_$ReminderDeletedImpl value,
          $Res Function(_$ReminderDeletedImpl) then) =
      __$$ReminderDeletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$ReminderDeletedImplCopyWithImpl<$Res>
    extends _$ReminderListEventCopyWithImpl<$Res, _$ReminderDeletedImpl>
    implements _$$ReminderDeletedImplCopyWith<$Res> {
  __$$ReminderDeletedImplCopyWithImpl(
      _$ReminderDeletedImpl _value, $Res Function(_$ReminderDeletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$ReminderDeletedImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ReminderDeletedImpl implements _ReminderDeleted {
  const _$ReminderDeletedImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'ReminderListEvent.reminderDeleted(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReminderDeletedImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of ReminderListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReminderDeletedImplCopyWith<_$ReminderDeletedImpl> get copyWith =>
      __$$ReminderDeletedImplCopyWithImpl<_$ReminderDeletedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ReminderFilter filter) filterChanged,
    required TResult Function(Reminder reminder) reminderAdded,
    required TResult Function(Reminder reminder) reminderUpdated,
    required TResult Function(String id) reminderDeleted,
  }) {
    return reminderDeleted(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ReminderFilter filter)? filterChanged,
    TResult? Function(Reminder reminder)? reminderAdded,
    TResult? Function(Reminder reminder)? reminderUpdated,
    TResult? Function(String id)? reminderDeleted,
  }) {
    return reminderDeleted?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ReminderFilter filter)? filterChanged,
    TResult Function(Reminder reminder)? reminderAdded,
    TResult Function(Reminder reminder)? reminderUpdated,
    TResult Function(String id)? reminderDeleted,
    required TResult orElse(),
  }) {
    if (reminderDeleted != null) {
      return reminderDeleted(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FilterChanged value) filterChanged,
    required TResult Function(_ReminderAdded value) reminderAdded,
    required TResult Function(_ReminderUpdated value) reminderUpdated,
    required TResult Function(_ReminderDeleted value) reminderDeleted,
  }) {
    return reminderDeleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FilterChanged value)? filterChanged,
    TResult? Function(_ReminderAdded value)? reminderAdded,
    TResult? Function(_ReminderUpdated value)? reminderUpdated,
    TResult? Function(_ReminderDeleted value)? reminderDeleted,
  }) {
    return reminderDeleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FilterChanged value)? filterChanged,
    TResult Function(_ReminderAdded value)? reminderAdded,
    TResult Function(_ReminderUpdated value)? reminderUpdated,
    TResult Function(_ReminderDeleted value)? reminderDeleted,
    required TResult orElse(),
  }) {
    if (reminderDeleted != null) {
      return reminderDeleted(this);
    }
    return orElse();
  }
}

abstract class _ReminderDeleted implements ReminderListEvent {
  const factory _ReminderDeleted(final String id) = _$ReminderDeletedImpl;

  String get id;

  /// Create a copy of ReminderListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReminderDeletedImplCopyWith<_$ReminderDeletedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReminderListState {
  List<Reminder> get reminders => throw _privateConstructorUsedError;
  ReminderFilter get filter => throw _privateConstructorUsedError;

  /// Create a copy of ReminderListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReminderListStateCopyWith<ReminderListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReminderListStateCopyWith<$Res> {
  factory $ReminderListStateCopyWith(
          ReminderListState value, $Res Function(ReminderListState) then) =
      _$ReminderListStateCopyWithImpl<$Res, ReminderListState>;
  @useResult
  $Res call({List<Reminder> reminders, ReminderFilter filter});
}

/// @nodoc
class _$ReminderListStateCopyWithImpl<$Res, $Val extends ReminderListState>
    implements $ReminderListStateCopyWith<$Res> {
  _$ReminderListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReminderListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reminders = null,
    Object? filter = null,
  }) {
    return _then(_value.copyWith(
      reminders: null == reminders
          ? _value.reminders
          : reminders // ignore: cast_nullable_to_non_nullable
              as List<Reminder>,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as ReminderFilter,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReminderListStateImplCopyWith<$Res>
    implements $ReminderListStateCopyWith<$Res> {
  factory _$$ReminderListStateImplCopyWith(_$ReminderListStateImpl value,
          $Res Function(_$ReminderListStateImpl) then) =
      __$$ReminderListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Reminder> reminders, ReminderFilter filter});
}

/// @nodoc
class __$$ReminderListStateImplCopyWithImpl<$Res>
    extends _$ReminderListStateCopyWithImpl<$Res, _$ReminderListStateImpl>
    implements _$$ReminderListStateImplCopyWith<$Res> {
  __$$ReminderListStateImplCopyWithImpl(_$ReminderListStateImpl _value,
      $Res Function(_$ReminderListStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reminders = null,
    Object? filter = null,
  }) {
    return _then(_$ReminderListStateImpl(
      reminders: null == reminders
          ? _value._reminders
          : reminders // ignore: cast_nullable_to_non_nullable
              as List<Reminder>,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as ReminderFilter,
    ));
  }
}

/// @nodoc

class _$ReminderListStateImpl extends _ReminderListState {
  const _$ReminderListStateImpl(
      {required final List<Reminder> reminders, required this.filter})
      : _reminders = reminders,
        super._();

  final List<Reminder> _reminders;
  @override
  List<Reminder> get reminders {
    if (_reminders is EqualUnmodifiableListView) return _reminders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reminders);
  }

  @override
  final ReminderFilter filter;

  @override
  String toString() {
    return 'ReminderListState(reminders: $reminders, filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReminderListStateImpl &&
            const DeepCollectionEquality()
                .equals(other._reminders, _reminders) &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_reminders), filter);

  /// Create a copy of ReminderListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReminderListStateImplCopyWith<_$ReminderListStateImpl> get copyWith =>
      __$$ReminderListStateImplCopyWithImpl<_$ReminderListStateImpl>(
          this, _$identity);
}

abstract class _ReminderListState extends ReminderListState {
  const factory _ReminderListState(
      {required final List<Reminder> reminders,
      required final ReminderFilter filter}) = _$ReminderListStateImpl;
  const _ReminderListState._() : super._();

  @override
  List<Reminder> get reminders;
  @override
  ReminderFilter get filter;

  /// Create a copy of ReminderListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReminderListStateImplCopyWith<_$ReminderListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
