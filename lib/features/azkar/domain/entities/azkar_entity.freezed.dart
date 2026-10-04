// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'azkar_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AzkarEntity {

 int get id; String get title; String get engTitle; String get slug; bool get isFavorite; String get category; String get audioUrl; String get textUrl;
/// Create a copy of AzkarEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AzkarEntityCopyWith<AzkarEntity> get copyWith => _$AzkarEntityCopyWithImpl<AzkarEntity>(this as AzkarEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AzkarEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AzkarEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.engTitle, _this.engTitle) || other.engTitle == _this.engTitle)&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.isFavorite, _this.isFavorite) || other.isFavorite == _this.isFavorite)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.audioUrl, _this.audioUrl) || other.audioUrl == _this.audioUrl)&&(identical(other.textUrl, _this.textUrl) || other.textUrl == _this.textUrl));
}


@override
int get hashCode {
  final _this = this as AzkarEntity;
  return Object.hash(runtimeType,_this.id,_this.title,_this.engTitle,_this.slug,_this.isFavorite,_this.category,_this.audioUrl,_this.textUrl);
}

@override
String toString() {
  final _this = this as AzkarEntity;
  return 'AzkarEntity(id: ${_this.id}, title: ${_this.title}, engTitle: ${_this.engTitle}, slug: ${_this.slug}, isFavorite: ${_this.isFavorite}, category: ${_this.category}, audioUrl: ${_this.audioUrl}, textUrl: ${_this.textUrl})';
}


}

/// @nodoc
abstract mixin class $AzkarEntityCopyWith<$Res>  {
  factory $AzkarEntityCopyWith(AzkarEntity value, $Res Function(AzkarEntity) _then) = _$AzkarEntityCopyWithImpl;
@useResult
$Res call({
 int id, String title, String engTitle, String slug, bool isFavorite, String category, String audioUrl, String textUrl
});




}
/// @nodoc
class _$AzkarEntityCopyWithImpl<$Res>
    implements $AzkarEntityCopyWith<$Res> {
  _$AzkarEntityCopyWithImpl(this._self, this._then);

  final AzkarEntity _self;
  final $Res Function(AzkarEntity) _then;

/// Create a copy of AzkarEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? engTitle = null,Object? slug = null,Object? isFavorite = null,Object? category = null,Object? audioUrl = null,Object? textUrl = null,}) {
  return _then(AzkarEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,engTitle: null == engTitle ? _self.engTitle : engTitle // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,audioUrl: null == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String,textUrl: null == textUrl ? _self.textUrl : textUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AzkarEntity].
extension AzkarEntityPatterns on AzkarEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AzkarEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AzkarEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AzkarEntity value)  $default,){
final _that = this;
switch (_that) {
case _AzkarEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AzkarEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AzkarEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String engTitle,  String slug,  bool isFavorite,  String category,  String audioUrl,  String textUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AzkarEntity() when $default != null:
return $default(_that.id,_that.title,_that.engTitle,_that.slug,_that.isFavorite,_that.category,_that.audioUrl,_that.textUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String engTitle,  String slug,  bool isFavorite,  String category,  String audioUrl,  String textUrl)  $default,) {final _that = this;
switch (_that) {
case _AzkarEntity():
return $default(_that.id,_that.title,_that.engTitle,_that.slug,_that.isFavorite,_that.category,_that.audioUrl,_that.textUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String engTitle,  String slug,  bool isFavorite,  String category,  String audioUrl,  String textUrl)?  $default,) {final _that = this;
switch (_that) {
case _AzkarEntity() when $default != null:
return $default(_that.id,_that.title,_that.engTitle,_that.slug,_that.isFavorite,_that.category,_that.audioUrl,_that.textUrl);case _:
  return null;

}
}

}

/// @nodoc


class _AzkarEntity implements AzkarEntity {
  const _AzkarEntity({required this.id, required this.title, required this.engTitle, required this.slug, required this.isFavorite, required this.category, required this.audioUrl, required this.textUrl});
  

@override final  int id;
@override final  String title;
@override final  String engTitle;
@override final  String slug;
@override final  bool isFavorite;
@override final  String category;
@override final  String audioUrl;
@override final  String textUrl;

/// Create a copy of AzkarEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AzkarEntityCopyWith<_AzkarEntity> get copyWith => __$AzkarEntityCopyWithImpl<_AzkarEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AzkarEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.engTitle, engTitle) || other.engTitle == engTitle)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.category, category) || other.category == category)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.textUrl, textUrl) || other.textUrl == textUrl));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,engTitle,slug,isFavorite,category,audioUrl,textUrl);
}

@override
String toString() {
    return 'AzkarEntity(id: $id, title: $title, engTitle: $engTitle, slug: $slug, isFavorite: $isFavorite, category: $category, audioUrl: $audioUrl, textUrl: $textUrl)';
}


}

/// @nodoc
abstract mixin class _$AzkarEntityCopyWith<$Res> implements $AzkarEntityCopyWith<$Res> {
  factory _$AzkarEntityCopyWith(_AzkarEntity value, $Res Function(_AzkarEntity) _then) = __$AzkarEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String engTitle, String slug, bool isFavorite, String category, String audioUrl, String textUrl
});




}
/// @nodoc
class __$AzkarEntityCopyWithImpl<$Res>
    implements _$AzkarEntityCopyWith<$Res> {
  __$AzkarEntityCopyWithImpl(this._self, this._then);

  final _AzkarEntity _self;
  final $Res Function(_AzkarEntity) _then;

/// Create a copy of AzkarEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? engTitle = null,Object? slug = null,Object? isFavorite = null,Object? category = null,Object? audioUrl = null,Object? textUrl = null,}) {
  return _then(_AzkarEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,engTitle: null == engTitle ? _self.engTitle : engTitle // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,audioUrl: null == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String,textUrl: null == textUrl ? _self.textUrl : textUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$AzkarContentEntity {

 int get id; String get arabicText; String get translatedText; int get repeat; String get audio;
/// Create a copy of AzkarContentEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AzkarContentEntityCopyWith<AzkarContentEntity> get copyWith => _$AzkarContentEntityCopyWithImpl<AzkarContentEntity>(this as AzkarContentEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AzkarContentEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AzkarContentEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.arabicText, _this.arabicText) || other.arabicText == _this.arabicText)&&(identical(other.translatedText, _this.translatedText) || other.translatedText == _this.translatedText)&&(identical(other.repeat, _this.repeat) || other.repeat == _this.repeat)&&(identical(other.audio, _this.audio) || other.audio == _this.audio));
}


@override
int get hashCode {
  final _this = this as AzkarContentEntity;
  return Object.hash(runtimeType,_this.id,_this.arabicText,_this.translatedText,_this.repeat,_this.audio);
}

@override
String toString() {
  final _this = this as AzkarContentEntity;
  return 'AzkarContentEntity(id: ${_this.id}, arabicText: ${_this.arabicText}, translatedText: ${_this.translatedText}, repeat: ${_this.repeat}, audio: ${_this.audio})';
}


}

/// @nodoc
abstract mixin class $AzkarContentEntityCopyWith<$Res>  {
  factory $AzkarContentEntityCopyWith(AzkarContentEntity value, $Res Function(AzkarContentEntity) _then) = _$AzkarContentEntityCopyWithImpl;
@useResult
$Res call({
 int id, String arabicText, String translatedText, int repeat, String audio
});




}
/// @nodoc
class _$AzkarContentEntityCopyWithImpl<$Res>
    implements $AzkarContentEntityCopyWith<$Res> {
  _$AzkarContentEntityCopyWithImpl(this._self, this._then);

  final AzkarContentEntity _self;
  final $Res Function(AzkarContentEntity) _then;

/// Create a copy of AzkarContentEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? arabicText = null,Object? translatedText = null,Object? repeat = null,Object? audio = null,}) {
  return _then(AzkarContentEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,arabicText: null == arabicText ? _self.arabicText : arabicText // ignore: cast_nullable_to_non_nullable
as String,translatedText: null == translatedText ? _self.translatedText : translatedText // ignore: cast_nullable_to_non_nullable
as String,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as int,audio: null == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AzkarContentEntity].
extension AzkarContentEntityPatterns on AzkarContentEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AzkarContentEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AzkarContentEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AzkarContentEntity value)  $default,){
final _that = this;
switch (_that) {
case _AzkarContentEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AzkarContentEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AzkarContentEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String arabicText,  String translatedText,  int repeat,  String audio)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AzkarContentEntity() when $default != null:
return $default(_that.id,_that.arabicText,_that.translatedText,_that.repeat,_that.audio);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String arabicText,  String translatedText,  int repeat,  String audio)  $default,) {final _that = this;
switch (_that) {
case _AzkarContentEntity():
return $default(_that.id,_that.arabicText,_that.translatedText,_that.repeat,_that.audio);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String arabicText,  String translatedText,  int repeat,  String audio)?  $default,) {final _that = this;
switch (_that) {
case _AzkarContentEntity() when $default != null:
return $default(_that.id,_that.arabicText,_that.translatedText,_that.repeat,_that.audio);case _:
  return null;

}
}

}

/// @nodoc


class _AzkarContentEntity implements AzkarContentEntity {
  const _AzkarContentEntity({required this.id, required this.arabicText, required this.translatedText, required this.repeat, required this.audio});
  

@override final  int id;
@override final  String arabicText;
@override final  String translatedText;
@override final  int repeat;
@override final  String audio;

/// Create a copy of AzkarContentEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AzkarContentEntityCopyWith<_AzkarContentEntity> get copyWith => __$AzkarContentEntityCopyWithImpl<_AzkarContentEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AzkarContentEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.arabicText, arabicText) || other.arabicText == arabicText)&&(identical(other.translatedText, translatedText) || other.translatedText == translatedText)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&(identical(other.audio, audio) || other.audio == audio));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,arabicText,translatedText,repeat,audio);
}

@override
String toString() {
    return 'AzkarContentEntity(id: $id, arabicText: $arabicText, translatedText: $translatedText, repeat: $repeat, audio: $audio)';
}


}

/// @nodoc
abstract mixin class _$AzkarContentEntityCopyWith<$Res> implements $AzkarContentEntityCopyWith<$Res> {
  factory _$AzkarContentEntityCopyWith(_AzkarContentEntity value, $Res Function(_AzkarContentEntity) _then) = __$AzkarContentEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String arabicText, String translatedText, int repeat, String audio
});




}
/// @nodoc
class __$AzkarContentEntityCopyWithImpl<$Res>
    implements _$AzkarContentEntityCopyWith<$Res> {
  __$AzkarContentEntityCopyWithImpl(this._self, this._then);

  final _AzkarContentEntity _self;
  final $Res Function(_AzkarContentEntity) _then;

/// Create a copy of AzkarContentEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? arabicText = null,Object? translatedText = null,Object? repeat = null,Object? audio = null,}) {
  return _then(_AzkarContentEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,arabicText: null == arabicText ? _self.arabicText : arabicText // ignore: cast_nullable_to_non_nullable
as String,translatedText: null == translatedText ? _self.translatedText : translatedText // ignore: cast_nullable_to_non_nullable
as String,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as int,audio: null == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
