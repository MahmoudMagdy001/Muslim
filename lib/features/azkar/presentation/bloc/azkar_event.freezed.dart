// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'azkar_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AzkarEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AzkarEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AzkarEvent()';
}


}

/// @nodoc
class $AzkarEventCopyWith<$Res>  {
$AzkarEventCopyWith(AzkarEvent _, $Res Function(AzkarEvent) __);
}


/// Adds pattern-matching-related methods to [AzkarEvent].
extension AzkarEventPatterns on AzkarEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AzkarLoadAzkar value)?  loadAzkar,TResult Function( AzkarLoadAzkarContent value)?  loadAzkarContent,TResult Function( AzkarDecrementCount value)?  decrementCount,TResult Function( AzkarResetCount value)?  resetCount,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AzkarLoadAzkar() when loadAzkar != null:
return loadAzkar(_that);case AzkarLoadAzkarContent() when loadAzkarContent != null:
return loadAzkarContent(_that);case AzkarDecrementCount() when decrementCount != null:
return decrementCount(_that);case AzkarResetCount() when resetCount != null:
return resetCount(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AzkarLoadAzkar value)  loadAzkar,required TResult Function( AzkarLoadAzkarContent value)  loadAzkarContent,required TResult Function( AzkarDecrementCount value)  decrementCount,required TResult Function( AzkarResetCount value)  resetCount,}){
final _that = this;
switch (_that) {
case AzkarLoadAzkar():
return loadAzkar(_that);case AzkarLoadAzkarContent():
return loadAzkarContent(_that);case AzkarDecrementCount():
return decrementCount(_that);case AzkarResetCount():
return resetCount(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AzkarLoadAzkar value)?  loadAzkar,TResult? Function( AzkarLoadAzkarContent value)?  loadAzkarContent,TResult? Function( AzkarDecrementCount value)?  decrementCount,TResult? Function( AzkarResetCount value)?  resetCount,}){
final _that = this;
switch (_that) {
case AzkarLoadAzkar() when loadAzkar != null:
return loadAzkar(_that);case AzkarLoadAzkarContent() when loadAzkarContent != null:
return loadAzkarContent(_that);case AzkarDecrementCount() when decrementCount != null:
return decrementCount(_that);case AzkarResetCount() when resetCount != null:
return resetCount(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadAzkar,TResult Function( String url)?  loadAzkarContent,TResult Function( String url,  int index)?  decrementCount,TResult Function( String url,  int index)?  resetCount,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AzkarLoadAzkar() when loadAzkar != null:
return loadAzkar();case AzkarLoadAzkarContent() when loadAzkarContent != null:
return loadAzkarContent(_that.url);case AzkarDecrementCount() when decrementCount != null:
return decrementCount(_that.url,_that.index);case AzkarResetCount() when resetCount != null:
return resetCount(_that.url,_that.index);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadAzkar,required TResult Function( String url)  loadAzkarContent,required TResult Function( String url,  int index)  decrementCount,required TResult Function( String url,  int index)  resetCount,}) {final _that = this;
switch (_that) {
case AzkarLoadAzkar():
return loadAzkar();case AzkarLoadAzkarContent():
return loadAzkarContent(_that.url);case AzkarDecrementCount():
return decrementCount(_that.url,_that.index);case AzkarResetCount():
return resetCount(_that.url,_that.index);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadAzkar,TResult? Function( String url)?  loadAzkarContent,TResult? Function( String url,  int index)?  decrementCount,TResult? Function( String url,  int index)?  resetCount,}) {final _that = this;
switch (_that) {
case AzkarLoadAzkar() when loadAzkar != null:
return loadAzkar();case AzkarLoadAzkarContent() when loadAzkarContent != null:
return loadAzkarContent(_that.url);case AzkarDecrementCount() when decrementCount != null:
return decrementCount(_that.url,_that.index);case AzkarResetCount() when resetCount != null:
return resetCount(_that.url,_that.index);case _:
  return null;

}
}

}

/// @nodoc


class AzkarLoadAzkar implements AzkarEvent {
  const AzkarLoadAzkar();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AzkarLoadAzkar);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AzkarEvent.loadAzkar()';
}


}




/// @nodoc


class AzkarLoadAzkarContent implements AzkarEvent {
  const AzkarLoadAzkarContent(this.url);
  

 final  String url;

/// Create a copy of AzkarEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AzkarLoadAzkarContentCopyWith<AzkarLoadAzkarContent> get copyWith => _$AzkarLoadAzkarContentCopyWithImpl<AzkarLoadAzkarContent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AzkarLoadAzkarContent&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode {
    return Object.hash(runtimeType,url);
}

@override
String toString() {
    return 'AzkarEvent.loadAzkarContent(url: $url)';
}


}

/// @nodoc
abstract mixin class $AzkarLoadAzkarContentCopyWith<$Res> implements $AzkarEventCopyWith<$Res> {
  factory $AzkarLoadAzkarContentCopyWith(AzkarLoadAzkarContent value, $Res Function(AzkarLoadAzkarContent) _then) = _$AzkarLoadAzkarContentCopyWithImpl;
@useResult
$Res call({
 String url
});




}
/// @nodoc
class _$AzkarLoadAzkarContentCopyWithImpl<$Res>
    implements $AzkarLoadAzkarContentCopyWith<$Res> {
  _$AzkarLoadAzkarContentCopyWithImpl(this._self, this._then);

  final AzkarLoadAzkarContent _self;
  final $Res Function(AzkarLoadAzkarContent) _then;

/// Create a copy of AzkarEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,}) {
  return _then(AzkarLoadAzkarContent(
null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AzkarDecrementCount implements AzkarEvent {
  const AzkarDecrementCount(this.url, this.index);
  

 final  String url;
 final  int index;

/// Create a copy of AzkarEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AzkarDecrementCountCopyWith<AzkarDecrementCount> get copyWith => _$AzkarDecrementCountCopyWithImpl<AzkarDecrementCount>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AzkarDecrementCount&&(identical(other.url, url) || other.url == url)&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode {
    return Object.hash(runtimeType,url,index);
}

@override
String toString() {
    return 'AzkarEvent.decrementCount(url: $url, index: $index)';
}


}

/// @nodoc
abstract mixin class $AzkarDecrementCountCopyWith<$Res> implements $AzkarEventCopyWith<$Res> {
  factory $AzkarDecrementCountCopyWith(AzkarDecrementCount value, $Res Function(AzkarDecrementCount) _then) = _$AzkarDecrementCountCopyWithImpl;
@useResult
$Res call({
 String url, int index
});




}
/// @nodoc
class _$AzkarDecrementCountCopyWithImpl<$Res>
    implements $AzkarDecrementCountCopyWith<$Res> {
  _$AzkarDecrementCountCopyWithImpl(this._self, this._then);

  final AzkarDecrementCount _self;
  final $Res Function(AzkarDecrementCount) _then;

/// Create a copy of AzkarEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,Object? index = null,}) {
  return _then(AzkarDecrementCount(
null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class AzkarResetCount implements AzkarEvent {
  const AzkarResetCount(this.url, this.index);
  

 final  String url;
 final  int index;

/// Create a copy of AzkarEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AzkarResetCountCopyWith<AzkarResetCount> get copyWith => _$AzkarResetCountCopyWithImpl<AzkarResetCount>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AzkarResetCount&&(identical(other.url, url) || other.url == url)&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode {
    return Object.hash(runtimeType,url,index);
}

@override
String toString() {
    return 'AzkarEvent.resetCount(url: $url, index: $index)';
}


}

/// @nodoc
abstract mixin class $AzkarResetCountCopyWith<$Res> implements $AzkarEventCopyWith<$Res> {
  factory $AzkarResetCountCopyWith(AzkarResetCount value, $Res Function(AzkarResetCount) _then) = _$AzkarResetCountCopyWithImpl;
@useResult
$Res call({
 String url, int index
});




}
/// @nodoc
class _$AzkarResetCountCopyWithImpl<$Res>
    implements $AzkarResetCountCopyWith<$Res> {
  _$AzkarResetCountCopyWithImpl(this._self, this._then);

  final AzkarResetCount _self;
  final $Res Function(AzkarResetCount) _then;

/// Create a copy of AzkarEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,Object? index = null,}) {
  return _then(AzkarResetCount(
null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
