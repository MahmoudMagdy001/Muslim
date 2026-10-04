// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reciter_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReciterEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ReciterEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ReciterEvent()';
}


}

/// @nodoc
class $ReciterEventCopyWith<$Res>  {
$ReciterEventCopyWith(ReciterEvent _, $Res Function(ReciterEvent) __);
}


/// Adds pattern-matching-related methods to [ReciterEvent].
extension ReciterEventPatterns on ReciterEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ReciterInitialize value)?  initialize,TResult Function( ReciterSaveReciter value)?  saveReciter,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ReciterInitialize() when initialize != null:
return initialize(_that);case ReciterSaveReciter() when saveReciter != null:
return saveReciter(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ReciterInitialize value)  initialize,required TResult Function( ReciterSaveReciter value)  saveReciter,}){
final _that = this;
switch (_that) {
case ReciterInitialize():
return initialize(_that);case ReciterSaveReciter():
return saveReciter(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ReciterInitialize value)?  initialize,TResult? Function( ReciterSaveReciter value)?  saveReciter,}){
final _that = this;
switch (_that) {
case ReciterInitialize() when initialize != null:
return initialize(_that);case ReciterSaveReciter() when saveReciter != null:
return saveReciter(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialize,TResult Function( String reciterId)?  saveReciter,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ReciterInitialize() when initialize != null:
return initialize();case ReciterSaveReciter() when saveReciter != null:
return saveReciter(_that.reciterId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialize,required TResult Function( String reciterId)  saveReciter,}) {final _that = this;
switch (_that) {
case ReciterInitialize():
return initialize();case ReciterSaveReciter():
return saveReciter(_that.reciterId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialize,TResult? Function( String reciterId)?  saveReciter,}) {final _that = this;
switch (_that) {
case ReciterInitialize() when initialize != null:
return initialize();case ReciterSaveReciter() when saveReciter != null:
return saveReciter(_that.reciterId);case _:
  return null;

}
}

}

/// @nodoc


class ReciterInitialize implements ReciterEvent {
  const ReciterInitialize();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ReciterInitialize);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ReciterEvent.initialize()';
}


}




/// @nodoc


class ReciterSaveReciter implements ReciterEvent {
  const ReciterSaveReciter(this.reciterId);
  

 final  String reciterId;

/// Create a copy of ReciterEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReciterSaveReciterCopyWith<ReciterSaveReciter> get copyWith => _$ReciterSaveReciterCopyWithImpl<ReciterSaveReciter>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ReciterSaveReciter&&(identical(other.reciterId, reciterId) || other.reciterId == reciterId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,reciterId);
}

@override
String toString() {
    return 'ReciterEvent.saveReciter(reciterId: $reciterId)';
}


}

/// @nodoc
abstract mixin class $ReciterSaveReciterCopyWith<$Res> implements $ReciterEventCopyWith<$Res> {
  factory $ReciterSaveReciterCopyWith(ReciterSaveReciter value, $Res Function(ReciterSaveReciter) _then) = _$ReciterSaveReciterCopyWithImpl;
@useResult
$Res call({
 String reciterId
});




}
/// @nodoc
class _$ReciterSaveReciterCopyWithImpl<$Res>
    implements $ReciterSaveReciterCopyWith<$Res> {
  _$ReciterSaveReciterCopyWithImpl(this._self, this._then);

  final ReciterSaveReciter _self;
  final $Res Function(ReciterSaveReciter) _then;

/// Create a copy of ReciterEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reciterId = null,}) {
  return _then(ReciterSaveReciter(
null == reciterId ? _self.reciterId : reciterId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
