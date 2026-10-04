// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'azkar_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AzkarModel {

 int get id; String get title; String get engTitle; String get slug; bool get isFavorite; String get category; String get audioUrl; String get textUrl;
/// Create a copy of AzkarModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AzkarModelCopyWith<AzkarModel> get copyWith => _$AzkarModelCopyWithImpl<AzkarModel>(this as AzkarModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AzkarModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AzkarModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.engTitle, _this.engTitle) || other.engTitle == _this.engTitle)&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.isFavorite, _this.isFavorite) || other.isFavorite == _this.isFavorite)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.audioUrl, _this.audioUrl) || other.audioUrl == _this.audioUrl)&&(identical(other.textUrl, _this.textUrl) || other.textUrl == _this.textUrl));
}


@override
int get hashCode {
  final _this = this as AzkarModel;
  return Object.hash(runtimeType,_this.id,_this.title,_this.engTitle,_this.slug,_this.isFavorite,_this.category,_this.audioUrl,_this.textUrl);
}

@override
String toString() {
  final _this = this as AzkarModel;
  return 'AzkarModel(id: ${_this.id}, title: ${_this.title}, engTitle: ${_this.engTitle}, slug: ${_this.slug}, isFavorite: ${_this.isFavorite}, category: ${_this.category}, audioUrl: ${_this.audioUrl}, textUrl: ${_this.textUrl})';
}


}

/// @nodoc
abstract mixin class $AzkarModelCopyWith<$Res>  {
  factory $AzkarModelCopyWith(AzkarModel value, $Res Function(AzkarModel) _then) = _$AzkarModelCopyWithImpl;
@useResult
$Res call({
 int id, String title, String engTitle, String slug, bool isFavorite, String category, String audioUrl, String textUrl
});




}
/// @nodoc
class _$AzkarModelCopyWithImpl<$Res>
    implements $AzkarModelCopyWith<$Res> {
  _$AzkarModelCopyWithImpl(this._self, this._then);

  final AzkarModel _self;
  final $Res Function(AzkarModel) _then;

/// Create a copy of AzkarModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? engTitle = null,Object? slug = null,Object? isFavorite = null,Object? category = null,Object? audioUrl = null,Object? textUrl = null,}) {
  return _then(AzkarModel(
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


/// Adds pattern-matching-related methods to [AzkarModel].
extension AzkarModelPatterns on AzkarModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AzkarModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AzkarModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AzkarModel value)  $default,){
final _that = this;
switch (_that) {
case _AzkarModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AzkarModel value)?  $default,){
final _that = this;
switch (_that) {
case _AzkarModel() when $default != null:
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
case _AzkarModel() when $default != null:
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
case _AzkarModel():
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
case _AzkarModel() when $default != null:
return $default(_that.id,_that.title,_that.engTitle,_that.slug,_that.isFavorite,_that.category,_that.audioUrl,_that.textUrl);case _:
  return null;

}
}

}

/// @nodoc


class _AzkarModel extends AzkarModel {
  const _AzkarModel({required this.id, required this.title, this.engTitle = '', this.slug = '', this.isFavorite = false, this.category = 'General', this.audioUrl = '', this.textUrl = ''}): super._();
  

@override final  int id;
@override final  String title;
@override@JsonKey() final  String engTitle;
@override@JsonKey() final  String slug;
@override@JsonKey() final  bool isFavorite;
@override@JsonKey() final  String category;
@override@JsonKey() final  String audioUrl;
@override@JsonKey() final  String textUrl;

/// Create a copy of AzkarModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AzkarModelCopyWith<_AzkarModel> get copyWith => __$AzkarModelCopyWithImpl<_AzkarModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AzkarModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.engTitle, engTitle) || other.engTitle == engTitle)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.category, category) || other.category == category)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.textUrl, textUrl) || other.textUrl == textUrl));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,engTitle,slug,isFavorite,category,audioUrl,textUrl);
}

@override
String toString() {
    return 'AzkarModel(id: $id, title: $title, engTitle: $engTitle, slug: $slug, isFavorite: $isFavorite, category: $category, audioUrl: $audioUrl, textUrl: $textUrl)';
}


}

/// @nodoc
abstract mixin class _$AzkarModelCopyWith<$Res> implements $AzkarModelCopyWith<$Res> {
  factory _$AzkarModelCopyWith(_AzkarModel value, $Res Function(_AzkarModel) _then) = __$AzkarModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String engTitle, String slug, bool isFavorite, String category, String audioUrl, String textUrl
});




}
/// @nodoc
class __$AzkarModelCopyWithImpl<$Res>
    implements _$AzkarModelCopyWith<$Res> {
  __$AzkarModelCopyWithImpl(this._self, this._then);

  final _AzkarModel _self;
  final $Res Function(_AzkarModel) _then;

/// Create a copy of AzkarModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? engTitle = null,Object? slug = null,Object? isFavorite = null,Object? category = null,Object? audioUrl = null,Object? textUrl = null,}) {
  return _then(_AzkarModel(
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
mixin _$AzkarContentModel {

 int get id; String get arabicText; String get translatedText; int get repeat; String get audio;
/// Create a copy of AzkarContentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AzkarContentModelCopyWith<AzkarContentModel> get copyWith => _$AzkarContentModelCopyWithImpl<AzkarContentModel>(this as AzkarContentModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AzkarContentModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AzkarContentModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.arabicText, _this.arabicText) || other.arabicText == _this.arabicText)&&(identical(other.translatedText, _this.translatedText) || other.translatedText == _this.translatedText)&&(identical(other.repeat, _this.repeat) || other.repeat == _this.repeat)&&(identical(other.audio, _this.audio) || other.audio == _this.audio));
}


@override
int get hashCode {
  final _this = this as AzkarContentModel;
  return Object.hash(runtimeType,_this.id,_this.arabicText,_this.translatedText,_this.repeat,_this.audio);
}

@override
String toString() {
  final _this = this as AzkarContentModel;
  return 'AzkarContentModel(id: ${_this.id}, arabicText: ${_this.arabicText}, translatedText: ${_this.translatedText}, repeat: ${_this.repeat}, audio: ${_this.audio})';
}


}

/// @nodoc
abstract mixin class $AzkarContentModelCopyWith<$Res>  {
  factory $AzkarContentModelCopyWith(AzkarContentModel value, $Res Function(AzkarContentModel) _then) = _$AzkarContentModelCopyWithImpl;
@useResult
$Res call({
 int id, String arabicText, String translatedText, int repeat, String audio
});




}
/// @nodoc
class _$AzkarContentModelCopyWithImpl<$Res>
    implements $AzkarContentModelCopyWith<$Res> {
  _$AzkarContentModelCopyWithImpl(this._self, this._then);

  final AzkarContentModel _self;
  final $Res Function(AzkarContentModel) _then;

/// Create a copy of AzkarContentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? arabicText = null,Object? translatedText = null,Object? repeat = null,Object? audio = null,}) {
  return _then(AzkarContentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,arabicText: null == arabicText ? _self.arabicText : arabicText // ignore: cast_nullable_to_non_nullable
as String,translatedText: null == translatedText ? _self.translatedText : translatedText // ignore: cast_nullable_to_non_nullable
as String,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as int,audio: null == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AzkarContentModel].
extension AzkarContentModelPatterns on AzkarContentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AzkarContentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AzkarContentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AzkarContentModel value)  $default,){
final _that = this;
switch (_that) {
case _AzkarContentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AzkarContentModel value)?  $default,){
final _that = this;
switch (_that) {
case _AzkarContentModel() when $default != null:
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
case _AzkarContentModel() when $default != null:
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
case _AzkarContentModel():
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
case _AzkarContentModel() when $default != null:
return $default(_that.id,_that.arabicText,_that.translatedText,_that.repeat,_that.audio);case _:
  return null;

}
}

}

/// @nodoc


class _AzkarContentModel extends AzkarContentModel {
  const _AzkarContentModel({required this.id, this.arabicText = '', this.translatedText = '', this.repeat = 1, this.audio = ''}): super._();
  

@override final  int id;
@override@JsonKey() final  String arabicText;
@override@JsonKey() final  String translatedText;
@override@JsonKey() final  int repeat;
@override@JsonKey() final  String audio;

/// Create a copy of AzkarContentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AzkarContentModelCopyWith<_AzkarContentModel> get copyWith => __$AzkarContentModelCopyWithImpl<_AzkarContentModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AzkarContentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.arabicText, arabicText) || other.arabicText == arabicText)&&(identical(other.translatedText, translatedText) || other.translatedText == translatedText)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&(identical(other.audio, audio) || other.audio == audio));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,arabicText,translatedText,repeat,audio);
}

@override
String toString() {
    return 'AzkarContentModel(id: $id, arabicText: $arabicText, translatedText: $translatedText, repeat: $repeat, audio: $audio)';
}


}

/// @nodoc
abstract mixin class _$AzkarContentModelCopyWith<$Res> implements $AzkarContentModelCopyWith<$Res> {
  factory _$AzkarContentModelCopyWith(_AzkarContentModel value, $Res Function(_AzkarContentModel) _then) = __$AzkarContentModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String arabicText, String translatedText, int repeat, String audio
});




}
/// @nodoc
class __$AzkarContentModelCopyWithImpl<$Res>
    implements _$AzkarContentModelCopyWith<$Res> {
  __$AzkarContentModelCopyWithImpl(this._self, this._then);

  final _AzkarContentModel _self;
  final $Res Function(_AzkarContentModel) _then;

/// Create a copy of AzkarContentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? arabicText = null,Object? translatedText = null,Object? repeat = null,Object? audio = null,}) {
  return _then(_AzkarContentModel(
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
