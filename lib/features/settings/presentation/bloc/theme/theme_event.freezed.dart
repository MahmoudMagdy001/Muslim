// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ThemeEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ThemeEvent()';
}


}

/// @nodoc
class $ThemeEventCopyWith<$Res>  {
$ThemeEventCopyWith(ThemeEvent _, $Res Function(ThemeEvent) __);
}


/// Adds pattern-matching-related methods to [ThemeEvent].
extension ThemeEventPatterns on ThemeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ThemeToggleTheme value)?  toggleTheme,TResult Function( ThemeSetThemeMode value)?  setThemeMode,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ThemeToggleTheme() when toggleTheme != null:
return toggleTheme(_that);case ThemeSetThemeMode() when setThemeMode != null:
return setThemeMode(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ThemeToggleTheme value)  toggleTheme,required TResult Function( ThemeSetThemeMode value)  setThemeMode,}){
final _that = this;
switch (_that) {
case ThemeToggleTheme():
return toggleTheme(_that);case ThemeSetThemeMode():
return setThemeMode(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ThemeToggleTheme value)?  toggleTheme,TResult? Function( ThemeSetThemeMode value)?  setThemeMode,}){
final _that = this;
switch (_that) {
case ThemeToggleTheme() when toggleTheme != null:
return toggleTheme(_that);case ThemeSetThemeMode() when setThemeMode != null:
return setThemeMode(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  toggleTheme,TResult Function( ThemeMode themeMode)?  setThemeMode,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ThemeToggleTheme() when toggleTheme != null:
return toggleTheme();case ThemeSetThemeMode() when setThemeMode != null:
return setThemeMode(_that.themeMode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  toggleTheme,required TResult Function( ThemeMode themeMode)  setThemeMode,}) {final _that = this;
switch (_that) {
case ThemeToggleTheme():
return toggleTheme();case ThemeSetThemeMode():
return setThemeMode(_that.themeMode);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  toggleTheme,TResult? Function( ThemeMode themeMode)?  setThemeMode,}) {final _that = this;
switch (_that) {
case ThemeToggleTheme() when toggleTheme != null:
return toggleTheme();case ThemeSetThemeMode() when setThemeMode != null:
return setThemeMode(_that.themeMode);case _:
  return null;

}
}

}

/// @nodoc


class ThemeToggleTheme implements ThemeEvent {
  const ThemeToggleTheme();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeToggleTheme);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ThemeEvent.toggleTheme()';
}


}




/// @nodoc


class ThemeSetThemeMode implements ThemeEvent {
  const ThemeSetThemeMode(this.themeMode);
  

 final  ThemeMode themeMode;

/// Create a copy of ThemeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeSetThemeModeCopyWith<ThemeSetThemeMode> get copyWith => _$ThemeSetThemeModeCopyWithImpl<ThemeSetThemeMode>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeSetThemeMode&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,themeMode);
}

@override
String toString() {
    return 'ThemeEvent.setThemeMode(themeMode: $themeMode)';
}


}

/// @nodoc
abstract mixin class $ThemeSetThemeModeCopyWith<$Res> implements $ThemeEventCopyWith<$Res> {
  factory $ThemeSetThemeModeCopyWith(ThemeSetThemeMode value, $Res Function(ThemeSetThemeMode) _then) = _$ThemeSetThemeModeCopyWithImpl;
@useResult
$Res call({
 ThemeMode themeMode
});




}
/// @nodoc
class _$ThemeSetThemeModeCopyWithImpl<$Res>
    implements $ThemeSetThemeModeCopyWith<$Res> {
  _$ThemeSetThemeModeCopyWithImpl(this._self, this._then);

  final ThemeSetThemeMode _self;
  final $Res Function(ThemeSetThemeMode) _then;

/// Create a copy of ThemeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? themeMode = null,}) {
  return _then(ThemeSetThemeMode(
null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,
  ));
}


}

// dart format on
