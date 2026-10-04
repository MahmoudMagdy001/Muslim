// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'azkar_audio_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AzkarAudioEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AzkarAudioEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AzkarAudioEvent()';
}


}

/// @nodoc
class $AzkarAudioEventCopyWith<$Res>  {
$AzkarAudioEventCopyWith(AzkarAudioEvent _, $Res Function(AzkarAudioEvent) __);
}


/// Adds pattern-matching-related methods to [AzkarAudioEvent].
extension AzkarAudioEventPatterns on AzkarAudioEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AzkarAudioStarted value)?  started,TResult Function( AzkarAudioStateUpdated value)?  stateUpdated,TResult Function( AzkarAudioPlayRequested value)?  playRequested,TResult Function( AzkarAudioStopRequested value)?  stopRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AzkarAudioStarted() when started != null:
return started(_that);case AzkarAudioStateUpdated() when stateUpdated != null:
return stateUpdated(_that);case AzkarAudioPlayRequested() when playRequested != null:
return playRequested(_that);case AzkarAudioStopRequested() when stopRequested != null:
return stopRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AzkarAudioStarted value)  started,required TResult Function( AzkarAudioStateUpdated value)  stateUpdated,required TResult Function( AzkarAudioPlayRequested value)  playRequested,required TResult Function( AzkarAudioStopRequested value)  stopRequested,}){
final _that = this;
switch (_that) {
case AzkarAudioStarted():
return started(_that);case AzkarAudioStateUpdated():
return stateUpdated(_that);case AzkarAudioPlayRequested():
return playRequested(_that);case AzkarAudioStopRequested():
return stopRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AzkarAudioStarted value)?  started,TResult? Function( AzkarAudioStateUpdated value)?  stateUpdated,TResult? Function( AzkarAudioPlayRequested value)?  playRequested,TResult? Function( AzkarAudioStopRequested value)?  stopRequested,}){
final _that = this;
switch (_that) {
case AzkarAudioStarted() when started != null:
return started(_that);case AzkarAudioStateUpdated() when stateUpdated != null:
return stateUpdated(_that);case AzkarAudioPlayRequested() when playRequested != null:
return playRequested(_that);case AzkarAudioStopRequested() when stopRequested != null:
return stopRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( AzkarAudioState state)?  stateUpdated,TResult Function( String url,  String? title)?  playRequested,TResult Function()?  stopRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AzkarAudioStarted() when started != null:
return started();case AzkarAudioStateUpdated() when stateUpdated != null:
return stateUpdated(_that.state);case AzkarAudioPlayRequested() when playRequested != null:
return playRequested(_that.url,_that.title);case AzkarAudioStopRequested() when stopRequested != null:
return stopRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( AzkarAudioState state)  stateUpdated,required TResult Function( String url,  String? title)  playRequested,required TResult Function()  stopRequested,}) {final _that = this;
switch (_that) {
case AzkarAudioStarted():
return started();case AzkarAudioStateUpdated():
return stateUpdated(_that.state);case AzkarAudioPlayRequested():
return playRequested(_that.url,_that.title);case AzkarAudioStopRequested():
return stopRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( AzkarAudioState state)?  stateUpdated,TResult? Function( String url,  String? title)?  playRequested,TResult? Function()?  stopRequested,}) {final _that = this;
switch (_that) {
case AzkarAudioStarted() when started != null:
return started();case AzkarAudioStateUpdated() when stateUpdated != null:
return stateUpdated(_that.state);case AzkarAudioPlayRequested() when playRequested != null:
return playRequested(_that.url,_that.title);case AzkarAudioStopRequested() when stopRequested != null:
return stopRequested();case _:
  return null;

}
}

}

/// @nodoc


class AzkarAudioStarted implements AzkarAudioEvent {
  const AzkarAudioStarted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AzkarAudioStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AzkarAudioEvent.started()';
}


}




/// @nodoc


class AzkarAudioStateUpdated implements AzkarAudioEvent {
  const AzkarAudioStateUpdated(this.state);
  

 final  AzkarAudioState state;

/// Create a copy of AzkarAudioEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AzkarAudioStateUpdatedCopyWith<AzkarAudioStateUpdated> get copyWith => _$AzkarAudioStateUpdatedCopyWithImpl<AzkarAudioStateUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AzkarAudioStateUpdated&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state);
}

@override
String toString() {
    return 'AzkarAudioEvent.stateUpdated(state: $state)';
}


}

/// @nodoc
abstract mixin class $AzkarAudioStateUpdatedCopyWith<$Res> implements $AzkarAudioEventCopyWith<$Res> {
  factory $AzkarAudioStateUpdatedCopyWith(AzkarAudioStateUpdated value, $Res Function(AzkarAudioStateUpdated) _then) = _$AzkarAudioStateUpdatedCopyWithImpl;
@useResult
$Res call({
 AzkarAudioState state
});


$AzkarAudioStateCopyWith<$Res> get state;

}
/// @nodoc
class _$AzkarAudioStateUpdatedCopyWithImpl<$Res>
    implements $AzkarAudioStateUpdatedCopyWith<$Res> {
  _$AzkarAudioStateUpdatedCopyWithImpl(this._self, this._then);

  final AzkarAudioStateUpdated _self;
  final $Res Function(AzkarAudioStateUpdated) _then;

/// Create a copy of AzkarAudioEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? state = null,}) {
  return _then(AzkarAudioStateUpdated(
null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as AzkarAudioState,
  ));
}

/// Create a copy of AzkarAudioEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AzkarAudioStateCopyWith<$Res> get state {
  
  return $AzkarAudioStateCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}

/// @nodoc


class AzkarAudioPlayRequested implements AzkarAudioEvent {
  const AzkarAudioPlayRequested(this.url, {this.title});
  

 final  String url;
 final  String? title;

/// Create a copy of AzkarAudioEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AzkarAudioPlayRequestedCopyWith<AzkarAudioPlayRequested> get copyWith => _$AzkarAudioPlayRequestedCopyWithImpl<AzkarAudioPlayRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AzkarAudioPlayRequested&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode {
    return Object.hash(runtimeType,url,title);
}

@override
String toString() {
    return 'AzkarAudioEvent.playRequested(url: $url, title: $title)';
}


}

/// @nodoc
abstract mixin class $AzkarAudioPlayRequestedCopyWith<$Res> implements $AzkarAudioEventCopyWith<$Res> {
  factory $AzkarAudioPlayRequestedCopyWith(AzkarAudioPlayRequested value, $Res Function(AzkarAudioPlayRequested) _then) = _$AzkarAudioPlayRequestedCopyWithImpl;
@useResult
$Res call({
 String url, String? title
});




}
/// @nodoc
class _$AzkarAudioPlayRequestedCopyWithImpl<$Res>
    implements $AzkarAudioPlayRequestedCopyWith<$Res> {
  _$AzkarAudioPlayRequestedCopyWithImpl(this._self, this._then);

  final AzkarAudioPlayRequested _self;
  final $Res Function(AzkarAudioPlayRequested) _then;

/// Create a copy of AzkarAudioEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,Object? title = freezed,}) {
  return _then(AzkarAudioPlayRequested(
null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class AzkarAudioStopRequested implements AzkarAudioEvent {
  const AzkarAudioStopRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AzkarAudioStopRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AzkarAudioEvent.stopRequested()';
}


}




// dart format on
