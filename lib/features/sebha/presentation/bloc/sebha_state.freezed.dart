// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sebha_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SebhaState {

 SebhaRequestStatus get status; int get counter; int get currentIndex; bool get goalReached; int? get customGoal; List<ZikrEntity> get customAzkar;
/// Create a copy of SebhaState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SebhaStateCopyWith<SebhaState> get copyWith => _$SebhaStateCopyWithImpl<SebhaState>(this as SebhaState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SebhaState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SebhaState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.counter, _this.counter) || other.counter == _this.counter)&&(identical(other.currentIndex, _this.currentIndex) || other.currentIndex == _this.currentIndex)&&(identical(other.goalReached, _this.goalReached) || other.goalReached == _this.goalReached)&&(identical(other.customGoal, _this.customGoal) || other.customGoal == _this.customGoal)&&const DeepCollectionEquality().equals(other.customAzkar, _this.customAzkar));
}


@override
int get hashCode {
  final _this = this as SebhaState;
  return Object.hash(runtimeType,_this.status,_this.counter,_this.currentIndex,_this.goalReached,_this.customGoal,const DeepCollectionEquality().hash(_this.customAzkar));
}

@override
String toString() {
  final _this = this as SebhaState;
  return 'SebhaState(status: ${_this.status}, counter: ${_this.counter}, currentIndex: ${_this.currentIndex}, goalReached: ${_this.goalReached}, customGoal: ${_this.customGoal}, customAzkar: ${_this.customAzkar})';
}


}

/// @nodoc
abstract mixin class $SebhaStateCopyWith<$Res>  {
  factory $SebhaStateCopyWith(SebhaState value, $Res Function(SebhaState) _then) = _$SebhaStateCopyWithImpl;
@useResult
$Res call({
 SebhaRequestStatus status, int counter, int currentIndex, bool goalReached, int? customGoal, List<ZikrEntity> customAzkar
});




}
/// @nodoc
class _$SebhaStateCopyWithImpl<$Res>
    implements $SebhaStateCopyWith<$Res> {
  _$SebhaStateCopyWithImpl(this._self, this._then);

  final SebhaState _self;
  final $Res Function(SebhaState) _then;

/// Create a copy of SebhaState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? counter = null,Object? currentIndex = null,Object? goalReached = null,Object? customGoal = freezed,Object? customAzkar = null,}) {
  return _then(SebhaState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SebhaRequestStatus,counter: null == counter ? _self.counter : counter // ignore: cast_nullable_to_non_nullable
as int,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,goalReached: null == goalReached ? _self.goalReached : goalReached // ignore: cast_nullable_to_non_nullable
as bool,customGoal: freezed == customGoal ? _self.customGoal : customGoal // ignore: cast_nullable_to_non_nullable
as int?,customAzkar: null == customAzkar ? _self.customAzkar : customAzkar // ignore: cast_nullable_to_non_nullable
as List<ZikrEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [SebhaState].
extension SebhaStatePatterns on SebhaState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SebhaState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SebhaState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SebhaState value)  $default,){
final _that = this;
switch (_that) {
case _SebhaState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SebhaState value)?  $default,){
final _that = this;
switch (_that) {
case _SebhaState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SebhaRequestStatus status,  int counter,  int currentIndex,  bool goalReached,  int? customGoal,  List<ZikrEntity> customAzkar)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SebhaState() when $default != null:
return $default(_that.status,_that.counter,_that.currentIndex,_that.goalReached,_that.customGoal,_that.customAzkar);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SebhaRequestStatus status,  int counter,  int currentIndex,  bool goalReached,  int? customGoal,  List<ZikrEntity> customAzkar)  $default,) {final _that = this;
switch (_that) {
case _SebhaState():
return $default(_that.status,_that.counter,_that.currentIndex,_that.goalReached,_that.customGoal,_that.customAzkar);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SebhaRequestStatus status,  int counter,  int currentIndex,  bool goalReached,  int? customGoal,  List<ZikrEntity> customAzkar)?  $default,) {final _that = this;
switch (_that) {
case _SebhaState() when $default != null:
return $default(_that.status,_that.counter,_that.currentIndex,_that.goalReached,_that.customGoal,_that.customAzkar);case _:
  return null;

}
}

}

/// @nodoc


class _SebhaState extends SebhaState {
  const _SebhaState({this.status = SebhaRequestStatus.initial, this.counter = 0, this.currentIndex = 0, this.goalReached = false, this.customGoal,  List<ZikrEntity> customAzkar = const []}): _customAzkar = customAzkar,super._();
  

@override@JsonKey() final  SebhaRequestStatus status;
@override@JsonKey() final  int counter;
@override@JsonKey() final  int currentIndex;
@override@JsonKey() final  bool goalReached;
@override final  int? customGoal;
 final  List<ZikrEntity> _customAzkar;
@override@JsonKey() List<ZikrEntity> get customAzkar {
  if (_customAzkar is EqualUnmodifiableListView) return _customAzkar;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customAzkar);
}


/// Create a copy of SebhaState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SebhaStateCopyWith<_SebhaState> get copyWith => __$SebhaStateCopyWithImpl<_SebhaState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SebhaState&&(identical(other.status, status) || other.status == status)&&(identical(other.counter, counter) || other.counter == counter)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.goalReached, goalReached) || other.goalReached == goalReached)&&(identical(other.customGoal, customGoal) || other.customGoal == customGoal)&&const DeepCollectionEquality().equals(other.customAzkar, _customAzkar));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,counter,currentIndex,goalReached,customGoal,const DeepCollectionEquality().hash(_customAzkar));
}

@override
String toString() {
    return 'SebhaState(status: $status, counter: $counter, currentIndex: $currentIndex, goalReached: $goalReached, customGoal: $customGoal, customAzkar: $customAzkar)';
}


}

/// @nodoc
abstract mixin class _$SebhaStateCopyWith<$Res> implements $SebhaStateCopyWith<$Res> {
  factory _$SebhaStateCopyWith(_SebhaState value, $Res Function(_SebhaState) _then) = __$SebhaStateCopyWithImpl;
@override @useResult
$Res call({
 SebhaRequestStatus status, int counter, int currentIndex, bool goalReached, int? customGoal, List<ZikrEntity> customAzkar
});




}
/// @nodoc
class __$SebhaStateCopyWithImpl<$Res>
    implements _$SebhaStateCopyWith<$Res> {
  __$SebhaStateCopyWithImpl(this._self, this._then);

  final _SebhaState _self;
  final $Res Function(_SebhaState) _then;

/// Create a copy of SebhaState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? counter = null,Object? currentIndex = null,Object? goalReached = null,Object? customGoal = freezed,Object? customAzkar = null,}) {
  return _then(_SebhaState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SebhaRequestStatus,counter: null == counter ? _self.counter : counter // ignore: cast_nullable_to_non_nullable
as int,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,goalReached: null == goalReached ? _self.goalReached : goalReached // ignore: cast_nullable_to_non_nullable
as bool,customGoal: freezed == customGoal ? _self.customGoal : customGoal // ignore: cast_nullable_to_non_nullable
as int?,customAzkar: null == customAzkar ? _self._customAzkar : customAzkar // ignore: cast_nullable_to_non_nullable
as List<ZikrEntity>,
  ));
}


}

// dart format on
