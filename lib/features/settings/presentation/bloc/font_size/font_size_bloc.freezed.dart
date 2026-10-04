// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'font_size_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FontSizeState {

 double get fontSize;
/// Create a copy of FontSizeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FontSizeStateCopyWith<FontSizeState> get copyWith => _$FontSizeStateCopyWithImpl<FontSizeState>(this as FontSizeState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FontSizeState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FontSizeState&&(identical(other.fontSize, _this.fontSize) || other.fontSize == _this.fontSize));
}


@override
int get hashCode {
  final _this = this as FontSizeState;
  return Object.hash(runtimeType,_this.fontSize);
}

@override
String toString() {
  final _this = this as FontSizeState;
  return 'FontSizeState(fontSize: ${_this.fontSize})';
}


}

/// @nodoc
abstract mixin class $FontSizeStateCopyWith<$Res>  {
  factory $FontSizeStateCopyWith(FontSizeState value, $Res Function(FontSizeState) _then) = _$FontSizeStateCopyWithImpl;
@useResult
$Res call({
 double fontSize
});




}
/// @nodoc
class _$FontSizeStateCopyWithImpl<$Res>
    implements $FontSizeStateCopyWith<$Res> {
  _$FontSizeStateCopyWithImpl(this._self, this._then);

  final FontSizeState _self;
  final $Res Function(FontSizeState) _then;

/// Create a copy of FontSizeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fontSize = null,}) {
  return _then(FontSizeState(
fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [FontSizeState].
extension FontSizeStatePatterns on FontSizeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FontSizeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FontSizeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FontSizeState value)  $default,){
final _that = this;
switch (_that) {
case _FontSizeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FontSizeState value)?  $default,){
final _that = this;
switch (_that) {
case _FontSizeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double fontSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FontSizeState() when $default != null:
return $default(_that.fontSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double fontSize)  $default,) {final _that = this;
switch (_that) {
case _FontSizeState():
return $default(_that.fontSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double fontSize)?  $default,) {final _that = this;
switch (_that) {
case _FontSizeState() when $default != null:
return $default(_that.fontSize);case _:
  return null;

}
}

}

/// @nodoc


class _FontSizeState implements FontSizeState {
  const _FontSizeState({required this.fontSize});
  

@override final  double fontSize;

/// Create a copy of FontSizeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FontSizeStateCopyWith<_FontSizeState> get copyWith => __$FontSizeStateCopyWithImpl<_FontSizeState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FontSizeState&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize));
}


@override
int get hashCode {
    return Object.hash(runtimeType,fontSize);
}

@override
String toString() {
    return 'FontSizeState(fontSize: $fontSize)';
}


}

/// @nodoc
abstract mixin class _$FontSizeStateCopyWith<$Res> implements $FontSizeStateCopyWith<$Res> {
  factory _$FontSizeStateCopyWith(_FontSizeState value, $Res Function(_FontSizeState) _then) = __$FontSizeStateCopyWithImpl;
@override @useResult
$Res call({
 double fontSize
});




}
/// @nodoc
class __$FontSizeStateCopyWithImpl<$Res>
    implements _$FontSizeStateCopyWith<$Res> {
  __$FontSizeStateCopyWithImpl(this._self, this._then);

  final _FontSizeState _self;
  final $Res Function(_FontSizeState) _then;

/// Create a copy of FontSizeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fontSize = null,}) {
  return _then(_FontSizeState(
fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
