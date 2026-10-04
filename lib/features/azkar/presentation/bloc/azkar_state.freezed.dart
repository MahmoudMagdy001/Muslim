// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'azkar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AzkarState {

 RequestStatus get status; RequestStatus get contentStatus; List<AzkarEntity> get azkarList; Map<String, List<AzkarEntity>> get groupedAzkar; List<AzkarContentEntity> get currentContent; Map<int, int> get currentCounts; String? get message;
/// Create a copy of AzkarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AzkarStateCopyWith<AzkarState> get copyWith => _$AzkarStateCopyWithImpl<AzkarState>(this as AzkarState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AzkarState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AzkarState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.contentStatus, _this.contentStatus) || other.contentStatus == _this.contentStatus)&&const DeepCollectionEquality().equals(other.azkarList, _this.azkarList)&&const DeepCollectionEquality().equals(other.groupedAzkar, _this.groupedAzkar)&&const DeepCollectionEquality().equals(other.currentContent, _this.currentContent)&&const DeepCollectionEquality().equals(other.currentCounts, _this.currentCounts)&&(identical(other.message, _this.message) || other.message == _this.message));
}


@override
int get hashCode {
  final _this = this as AzkarState;
  return Object.hash(runtimeType,_this.status,_this.contentStatus,const DeepCollectionEquality().hash(_this.azkarList),const DeepCollectionEquality().hash(_this.groupedAzkar),const DeepCollectionEquality().hash(_this.currentContent),const DeepCollectionEquality().hash(_this.currentCounts),_this.message);
}

@override
String toString() {
  final _this = this as AzkarState;
  return 'AzkarState(status: ${_this.status}, contentStatus: ${_this.contentStatus}, azkarList: ${_this.azkarList}, groupedAzkar: ${_this.groupedAzkar}, currentContent: ${_this.currentContent}, currentCounts: ${_this.currentCounts}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $AzkarStateCopyWith<$Res>  {
  factory $AzkarStateCopyWith(AzkarState value, $Res Function(AzkarState) _then) = _$AzkarStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, RequestStatus contentStatus, List<AzkarEntity> azkarList, Map<String, List<AzkarEntity>> groupedAzkar, List<AzkarContentEntity> currentContent, Map<int, int> currentCounts, String? message
});




}
/// @nodoc
class _$AzkarStateCopyWithImpl<$Res>
    implements $AzkarStateCopyWith<$Res> {
  _$AzkarStateCopyWithImpl(this._self, this._then);

  final AzkarState _self;
  final $Res Function(AzkarState) _then;

/// Create a copy of AzkarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? contentStatus = null,Object? azkarList = null,Object? groupedAzkar = null,Object? currentContent = null,Object? currentCounts = null,Object? message = freezed,}) {
  return _then(AzkarState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,contentStatus: null == contentStatus ? _self.contentStatus : contentStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,azkarList: null == azkarList ? _self.azkarList : azkarList // ignore: cast_nullable_to_non_nullable
as List<AzkarEntity>,groupedAzkar: null == groupedAzkar ? _self.groupedAzkar : groupedAzkar // ignore: cast_nullable_to_non_nullable
as Map<String, List<AzkarEntity>>,currentContent: null == currentContent ? _self.currentContent : currentContent // ignore: cast_nullable_to_non_nullable
as List<AzkarContentEntity>,currentCounts: null == currentCounts ? _self.currentCounts : currentCounts // ignore: cast_nullable_to_non_nullable
as Map<int, int>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AzkarState].
extension AzkarStatePatterns on AzkarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AzkarState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AzkarState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AzkarState value)  $default,){
final _that = this;
switch (_that) {
case _AzkarState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AzkarState value)?  $default,){
final _that = this;
switch (_that) {
case _AzkarState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus contentStatus,  List<AzkarEntity> azkarList,  Map<String, List<AzkarEntity>> groupedAzkar,  List<AzkarContentEntity> currentContent,  Map<int, int> currentCounts,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AzkarState() when $default != null:
return $default(_that.status,_that.contentStatus,_that.azkarList,_that.groupedAzkar,_that.currentContent,_that.currentCounts,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  RequestStatus contentStatus,  List<AzkarEntity> azkarList,  Map<String, List<AzkarEntity>> groupedAzkar,  List<AzkarContentEntity> currentContent,  Map<int, int> currentCounts,  String? message)  $default,) {final _that = this;
switch (_that) {
case _AzkarState():
return $default(_that.status,_that.contentStatus,_that.azkarList,_that.groupedAzkar,_that.currentContent,_that.currentCounts,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  RequestStatus contentStatus,  List<AzkarEntity> azkarList,  Map<String, List<AzkarEntity>> groupedAzkar,  List<AzkarContentEntity> currentContent,  Map<int, int> currentCounts,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _AzkarState() when $default != null:
return $default(_that.status,_that.contentStatus,_that.azkarList,_that.groupedAzkar,_that.currentContent,_that.currentCounts,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _AzkarState implements AzkarState {
  const _AzkarState({this.status = RequestStatus.initial, this.contentStatus = RequestStatus.initial,  List<AzkarEntity> azkarList = const [],  Map<String, List<AzkarEntity>> groupedAzkar = const {},  List<AzkarContentEntity> currentContent = const [],  Map<int, int> currentCounts = const {}, this.message}): _azkarList = azkarList,_groupedAzkar = groupedAzkar,_currentContent = currentContent,_currentCounts = currentCounts;
  

@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  RequestStatus contentStatus;
 final  List<AzkarEntity> _azkarList;
@override@JsonKey() List<AzkarEntity> get azkarList {
  if (_azkarList is EqualUnmodifiableListView) return _azkarList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_azkarList);
}

 final  Map<String, List<AzkarEntity>> _groupedAzkar;
@override@JsonKey() Map<String, List<AzkarEntity>> get groupedAzkar {
  if (_groupedAzkar is EqualUnmodifiableMapView) return _groupedAzkar;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_groupedAzkar);
}

 final  List<AzkarContentEntity> _currentContent;
@override@JsonKey() List<AzkarContentEntity> get currentContent {
  if (_currentContent is EqualUnmodifiableListView) return _currentContent;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currentContent);
}

 final  Map<int, int> _currentCounts;
@override@JsonKey() Map<int, int> get currentCounts {
  if (_currentCounts is EqualUnmodifiableMapView) return _currentCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_currentCounts);
}

@override final  String? message;

/// Create a copy of AzkarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AzkarStateCopyWith<_AzkarState> get copyWith => __$AzkarStateCopyWithImpl<_AzkarState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AzkarState&&(identical(other.status, status) || other.status == status)&&(identical(other.contentStatus, contentStatus) || other.contentStatus == contentStatus)&&const DeepCollectionEquality().equals(other.azkarList, _azkarList)&&const DeepCollectionEquality().equals(other.groupedAzkar, _groupedAzkar)&&const DeepCollectionEquality().equals(other.currentContent, _currentContent)&&const DeepCollectionEquality().equals(other.currentCounts, _currentCounts)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,contentStatus,const DeepCollectionEquality().hash(_azkarList),const DeepCollectionEquality().hash(_groupedAzkar),const DeepCollectionEquality().hash(_currentContent),const DeepCollectionEquality().hash(_currentCounts),message);
}

@override
String toString() {
    return 'AzkarState(status: $status, contentStatus: $contentStatus, azkarList: $azkarList, groupedAzkar: $groupedAzkar, currentContent: $currentContent, currentCounts: $currentCounts, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AzkarStateCopyWith<$Res> implements $AzkarStateCopyWith<$Res> {
  factory _$AzkarStateCopyWith(_AzkarState value, $Res Function(_AzkarState) _then) = __$AzkarStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, RequestStatus contentStatus, List<AzkarEntity> azkarList, Map<String, List<AzkarEntity>> groupedAzkar, List<AzkarContentEntity> currentContent, Map<int, int> currentCounts, String? message
});




}
/// @nodoc
class __$AzkarStateCopyWithImpl<$Res>
    implements _$AzkarStateCopyWith<$Res> {
  __$AzkarStateCopyWithImpl(this._self, this._then);

  final _AzkarState _self;
  final $Res Function(_AzkarState) _then;

/// Create a copy of AzkarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? contentStatus = null,Object? azkarList = null,Object? groupedAzkar = null,Object? currentContent = null,Object? currentCounts = null,Object? message = freezed,}) {
  return _then(_AzkarState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,contentStatus: null == contentStatus ? _self.contentStatus : contentStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,azkarList: null == azkarList ? _self._azkarList : azkarList // ignore: cast_nullable_to_non_nullable
as List<AzkarEntity>,groupedAzkar: null == groupedAzkar ? _self._groupedAzkar : groupedAzkar // ignore: cast_nullable_to_non_nullable
as Map<String, List<AzkarEntity>>,currentContent: null == currentContent ? _self._currentContent : currentContent // ignore: cast_nullable_to_non_nullable
as List<AzkarContentEntity>,currentCounts: null == currentCounts ? _self._currentCounts : currentCounts // ignore: cast_nullable_to_non_nullable
as Map<int, int>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
