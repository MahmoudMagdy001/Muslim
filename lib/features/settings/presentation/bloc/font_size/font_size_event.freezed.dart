// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'font_size_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FontSizeEvent {

 double get value;
/// Create a copy of FontSizeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FontSizeEventCopyWith<FontSizeEvent> get copyWith => _$FontSizeEventCopyWithImpl<FontSizeEvent>(this as FontSizeEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FontSizeEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FontSizeEvent&&(identical(other.value, _this.value) || other.value == _this.value));
}


@override
int get hashCode {
  final _this = this as FontSizeEvent;
  return Object.hash(runtimeType,_this.value);
}

@override
String toString() {
  final _this = this as FontSizeEvent;
  return 'FontSizeEvent(value: ${_this.value})';
}


}

/// @nodoc
abstract mixin class $FontSizeEventCopyWith<$Res>  {
  factory $FontSizeEventCopyWith(FontSizeEvent value, $Res Function(FontSizeEvent) _then) = _$FontSizeEventCopyWithImpl;
@useResult
$Res call({
 double value
});




}
/// @nodoc
class _$FontSizeEventCopyWithImpl<$Res>
    implements $FontSizeEventCopyWith<$Res> {
  _$FontSizeEventCopyWithImpl(this._self, this._then);

  final FontSizeEvent _self;
  final $Res Function(FontSizeEvent) _then;

/// Create a copy of FontSizeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(FontSizeEvent.setFontSize(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [FontSizeEvent].
extension FontSizeEventPatterns on FontSizeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FontSizeSetFontSize value)?  setFontSize,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FontSizeSetFontSize() when setFontSize != null:
return setFontSize(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FontSizeSetFontSize value)  setFontSize,}){
final _that = this;
switch (_that) {
case FontSizeSetFontSize():
return setFontSize(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FontSizeSetFontSize value)?  setFontSize,}){
final _that = this;
switch (_that) {
case FontSizeSetFontSize() when setFontSize != null:
return setFontSize(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( double value)?  setFontSize,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FontSizeSetFontSize() when setFontSize != null:
return setFontSize(_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( double value)  setFontSize,}) {final _that = this;
switch (_that) {
case FontSizeSetFontSize():
return setFontSize(_that.value);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( double value)?  setFontSize,}) {final _that = this;
switch (_that) {
case FontSizeSetFontSize() when setFontSize != null:
return setFontSize(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class FontSizeSetFontSize implements FontSizeEvent {
  const FontSizeSetFontSize(this.value);
  

@override final  double value;

/// Create a copy of FontSizeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FontSizeSetFontSizeCopyWith<FontSizeSetFontSize> get copyWith => _$FontSizeSetFontSizeCopyWithImpl<FontSizeSetFontSize>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FontSizeSetFontSize&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode {
    return Object.hash(runtimeType,value);
}

@override
String toString() {
    return 'FontSizeEvent.setFontSize(value: $value)';
}


}

/// @nodoc
abstract mixin class $FontSizeSetFontSizeCopyWith<$Res> implements $FontSizeEventCopyWith<$Res> {
  factory $FontSizeSetFontSizeCopyWith(FontSizeSetFontSize value, $Res Function(FontSizeSetFontSize) _then) = _$FontSizeSetFontSizeCopyWithImpl;
@override @useResult
$Res call({
 double value
});




}
/// @nodoc
class _$FontSizeSetFontSizeCopyWithImpl<$Res>
    implements $FontSizeSetFontSizeCopyWith<$Res> {
  _$FontSizeSetFontSizeCopyWithImpl(this._self, this._then);

  final FontSizeSetFontSize _self;
  final $Res Function(FontSizeSetFontSize) _then;

/// Create a copy of FontSizeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(FontSizeSetFontSize(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
