// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hadith_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HadithState {

 HadithStatus get status; List<HadithEntity> get hadiths; List<Map<String, dynamic>> get savedHadiths; Set<String> get savedHadithIds; bool get dataLoaded; String? get message;
/// Create a copy of HadithState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HadithStateCopyWith<HadithState> get copyWith => _$HadithStateCopyWithImpl<HadithState>(this as HadithState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HadithState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HadithState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.hadiths, _this.hadiths)&&const DeepCollectionEquality().equals(other.savedHadiths, _this.savedHadiths)&&const DeepCollectionEquality().equals(other.savedHadithIds, _this.savedHadithIds)&&(identical(other.dataLoaded, _this.dataLoaded) || other.dataLoaded == _this.dataLoaded)&&(identical(other.message, _this.message) || other.message == _this.message));
}


@override
int get hashCode {
  final _this = this as HadithState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.hadiths),const DeepCollectionEquality().hash(_this.savedHadiths),const DeepCollectionEquality().hash(_this.savedHadithIds),_this.dataLoaded,_this.message);
}

@override
String toString() {
  final _this = this as HadithState;
  return 'HadithState(status: ${_this.status}, hadiths: ${_this.hadiths}, savedHadiths: ${_this.savedHadiths}, savedHadithIds: ${_this.savedHadithIds}, dataLoaded: ${_this.dataLoaded}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $HadithStateCopyWith<$Res>  {
  factory $HadithStateCopyWith(HadithState value, $Res Function(HadithState) _then) = _$HadithStateCopyWithImpl;
@useResult
$Res call({
 HadithStatus status, List<HadithEntity> hadiths, List<Map<String, dynamic>> savedHadiths, Set<String> savedHadithIds, bool dataLoaded, String? message
});




}
/// @nodoc
class _$HadithStateCopyWithImpl<$Res>
    implements $HadithStateCopyWith<$Res> {
  _$HadithStateCopyWithImpl(this._self, this._then);

  final HadithState _self;
  final $Res Function(HadithState) _then;

/// Create a copy of HadithState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? hadiths = null,Object? savedHadiths = null,Object? savedHadithIds = null,Object? dataLoaded = null,Object? message = freezed,}) {
  return _then(HadithState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HadithStatus,hadiths: null == hadiths ? _self.hadiths : hadiths // ignore: cast_nullable_to_non_nullable
as List<HadithEntity>,savedHadiths: null == savedHadiths ? _self.savedHadiths : savedHadiths // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,savedHadithIds: null == savedHadithIds ? _self.savedHadithIds : savedHadithIds // ignore: cast_nullable_to_non_nullable
as Set<String>,dataLoaded: null == dataLoaded ? _self.dataLoaded : dataLoaded // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HadithState].
extension HadithStatePatterns on HadithState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HadithState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HadithState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HadithState value)  $default,){
final _that = this;
switch (_that) {
case _HadithState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HadithState value)?  $default,){
final _that = this;
switch (_that) {
case _HadithState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HadithStatus status,  List<HadithEntity> hadiths,  List<Map<String, dynamic>> savedHadiths,  Set<String> savedHadithIds,  bool dataLoaded,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HadithState() when $default != null:
return $default(_that.status,_that.hadiths,_that.savedHadiths,_that.savedHadithIds,_that.dataLoaded,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HadithStatus status,  List<HadithEntity> hadiths,  List<Map<String, dynamic>> savedHadiths,  Set<String> savedHadithIds,  bool dataLoaded,  String? message)  $default,) {final _that = this;
switch (_that) {
case _HadithState():
return $default(_that.status,_that.hadiths,_that.savedHadiths,_that.savedHadithIds,_that.dataLoaded,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HadithStatus status,  List<HadithEntity> hadiths,  List<Map<String, dynamic>> savedHadiths,  Set<String> savedHadithIds,  bool dataLoaded,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _HadithState() when $default != null:
return $default(_that.status,_that.hadiths,_that.savedHadiths,_that.savedHadithIds,_that.dataLoaded,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _HadithState implements HadithState {
  const _HadithState({this.status = HadithStatus.initial,  List<HadithEntity> hadiths = const [],  List<Map<String, dynamic>> savedHadiths = const [],  Set<String> savedHadithIds = const {}, this.dataLoaded = false, this.message}): _hadiths = hadiths,_savedHadiths = savedHadiths,_savedHadithIds = savedHadithIds;
  

@override@JsonKey() final  HadithStatus status;
 final  List<HadithEntity> _hadiths;
@override@JsonKey() List<HadithEntity> get hadiths {
  if (_hadiths is EqualUnmodifiableListView) return _hadiths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hadiths);
}

 final  List<Map<String, dynamic>> _savedHadiths;
@override@JsonKey() List<Map<String, dynamic>> get savedHadiths {
  if (_savedHadiths is EqualUnmodifiableListView) return _savedHadiths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_savedHadiths);
}

 final  Set<String> _savedHadithIds;
@override@JsonKey() Set<String> get savedHadithIds {
  if (_savedHadithIds is EqualUnmodifiableSetView) return _savedHadithIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_savedHadithIds);
}

@override@JsonKey() final  bool dataLoaded;
@override final  String? message;

/// Create a copy of HadithState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HadithStateCopyWith<_HadithState> get copyWith => __$HadithStateCopyWithImpl<_HadithState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HadithState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.hadiths, _hadiths)&&const DeepCollectionEquality().equals(other.savedHadiths, _savedHadiths)&&const DeepCollectionEquality().equals(other.savedHadithIds, _savedHadithIds)&&(identical(other.dataLoaded, dataLoaded) || other.dataLoaded == dataLoaded)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_hadiths),const DeepCollectionEquality().hash(_savedHadiths),const DeepCollectionEquality().hash(_savedHadithIds),dataLoaded,message);
}

@override
String toString() {
    return 'HadithState(status: $status, hadiths: $hadiths, savedHadiths: $savedHadiths, savedHadithIds: $savedHadithIds, dataLoaded: $dataLoaded, message: $message)';
}


}

/// @nodoc
abstract mixin class _$HadithStateCopyWith<$Res> implements $HadithStateCopyWith<$Res> {
  factory _$HadithStateCopyWith(_HadithState value, $Res Function(_HadithState) _then) = __$HadithStateCopyWithImpl;
@override @useResult
$Res call({
 HadithStatus status, List<HadithEntity> hadiths, List<Map<String, dynamic>> savedHadiths, Set<String> savedHadithIds, bool dataLoaded, String? message
});




}
/// @nodoc
class __$HadithStateCopyWithImpl<$Res>
    implements _$HadithStateCopyWith<$Res> {
  __$HadithStateCopyWithImpl(this._self, this._then);

  final _HadithState _self;
  final $Res Function(_HadithState) _then;

/// Create a copy of HadithState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? hadiths = null,Object? savedHadiths = null,Object? savedHadithIds = null,Object? dataLoaded = null,Object? message = freezed,}) {
  return _then(_HadithState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HadithStatus,hadiths: null == hadiths ? _self._hadiths : hadiths // ignore: cast_nullable_to_non_nullable
as List<HadithEntity>,savedHadiths: null == savedHadiths ? _self._savedHadiths : savedHadiths // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,savedHadithIds: null == savedHadithIds ? _self._savedHadithIds : savedHadithIds // ignore: cast_nullable_to_non_nullable
as Set<String>,dataLoaded: null == dataLoaded ? _self.dataLoaded : dataLoaded // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
