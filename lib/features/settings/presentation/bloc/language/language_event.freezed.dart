// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'language_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LanguageEvent {

 Locale get newLocale;
/// Create a copy of LanguageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanguageEventCopyWith<LanguageEvent> get copyWith => _$LanguageEventCopyWithImpl<LanguageEvent>(this as LanguageEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LanguageEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageEvent&&(identical(other.newLocale, _this.newLocale) || other.newLocale == _this.newLocale));
}


@override
int get hashCode {
  final _this = this as LanguageEvent;
  return Object.hash(runtimeType,_this.newLocale);
}

@override
String toString() {
  final _this = this as LanguageEvent;
  return 'LanguageEvent(newLocale: ${_this.newLocale})';
}


}

/// @nodoc
abstract mixin class $LanguageEventCopyWith<$Res>  {
  factory $LanguageEventCopyWith(LanguageEvent value, $Res Function(LanguageEvent) _then) = _$LanguageEventCopyWithImpl;
@useResult
$Res call({
 Locale newLocale
});




}
/// @nodoc
class _$LanguageEventCopyWithImpl<$Res>
    implements $LanguageEventCopyWith<$Res> {
  _$LanguageEventCopyWithImpl(this._self, this._then);

  final LanguageEvent _self;
  final $Res Function(LanguageEvent) _then;

/// Create a copy of LanguageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? newLocale = null,}) {
  return _then(LanguageEvent.changeLanguage(
null == newLocale ? _self.newLocale : newLocale // ignore: cast_nullable_to_non_nullable
as Locale,
  ));
}

}


/// Adds pattern-matching-related methods to [LanguageEvent].
extension LanguageEventPatterns on LanguageEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LanguageChangeLanguage value)?  changeLanguage,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LanguageChangeLanguage() when changeLanguage != null:
return changeLanguage(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LanguageChangeLanguage value)  changeLanguage,}){
final _that = this;
switch (_that) {
case LanguageChangeLanguage():
return changeLanguage(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LanguageChangeLanguage value)?  changeLanguage,}){
final _that = this;
switch (_that) {
case LanguageChangeLanguage() when changeLanguage != null:
return changeLanguage(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Locale newLocale)?  changeLanguage,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LanguageChangeLanguage() when changeLanguage != null:
return changeLanguage(_that.newLocale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Locale newLocale)  changeLanguage,}) {final _that = this;
switch (_that) {
case LanguageChangeLanguage():
return changeLanguage(_that.newLocale);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Locale newLocale)?  changeLanguage,}) {final _that = this;
switch (_that) {
case LanguageChangeLanguage() when changeLanguage != null:
return changeLanguage(_that.newLocale);case _:
  return null;

}
}

}

/// @nodoc


class LanguageChangeLanguage implements LanguageEvent {
  const LanguageChangeLanguage(this.newLocale);
  

@override final  Locale newLocale;

/// Create a copy of LanguageEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanguageChangeLanguageCopyWith<LanguageChangeLanguage> get copyWith => _$LanguageChangeLanguageCopyWithImpl<LanguageChangeLanguage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageChangeLanguage&&(identical(other.newLocale, newLocale) || other.newLocale == newLocale));
}


@override
int get hashCode {
    return Object.hash(runtimeType,newLocale);
}

@override
String toString() {
    return 'LanguageEvent.changeLanguage(newLocale: $newLocale)';
}


}

/// @nodoc
abstract mixin class $LanguageChangeLanguageCopyWith<$Res> implements $LanguageEventCopyWith<$Res> {
  factory $LanguageChangeLanguageCopyWith(LanguageChangeLanguage value, $Res Function(LanguageChangeLanguage) _then) = _$LanguageChangeLanguageCopyWithImpl;
@override @useResult
$Res call({
 Locale newLocale
});




}
/// @nodoc
class _$LanguageChangeLanguageCopyWithImpl<$Res>
    implements $LanguageChangeLanguageCopyWith<$Res> {
  _$LanguageChangeLanguageCopyWithImpl(this._self, this._then);

  final LanguageChangeLanguage _self;
  final $Res Function(LanguageChangeLanguage) _then;

/// Create a copy of LanguageEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? newLocale = null,}) {
  return _then(LanguageChangeLanguage(
null == newLocale ? _self.newLocale : newLocale // ignore: cast_nullable_to_non_nullable
as Locale,
  ));
}


}

// dart format on
