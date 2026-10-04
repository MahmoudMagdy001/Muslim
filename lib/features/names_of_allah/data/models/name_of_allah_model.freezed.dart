// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'name_of_allah_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NameOfAllahModel {

 int get id; String get name; String get text; String get nameTranslation; String get textTranslation;
/// Create a copy of NameOfAllahModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NameOfAllahModelCopyWith<NameOfAllahModel> get copyWith => _$NameOfAllahModelCopyWithImpl<NameOfAllahModel>(this as NameOfAllahModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NameOfAllahModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NameOfAllahModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.nameTranslation, _this.nameTranslation) || other.nameTranslation == _this.nameTranslation)&&(identical(other.textTranslation, _this.textTranslation) || other.textTranslation == _this.textTranslation));
}


@override
int get hashCode {
  final _this = this as NameOfAllahModel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.text,_this.nameTranslation,_this.textTranslation);
}

@override
String toString() {
  final _this = this as NameOfAllahModel;
  return 'NameOfAllahModel(id: ${_this.id}, name: ${_this.name}, text: ${_this.text}, nameTranslation: ${_this.nameTranslation}, textTranslation: ${_this.textTranslation})';
}


}

/// @nodoc
abstract mixin class $NameOfAllahModelCopyWith<$Res>  {
  factory $NameOfAllahModelCopyWith(NameOfAllahModel value, $Res Function(NameOfAllahModel) _then) = _$NameOfAllahModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String text, String nameTranslation, String textTranslation
});




}
/// @nodoc
class _$NameOfAllahModelCopyWithImpl<$Res>
    implements $NameOfAllahModelCopyWith<$Res> {
  _$NameOfAllahModelCopyWithImpl(this._self, this._then);

  final NameOfAllahModel _self;
  final $Res Function(NameOfAllahModel) _then;

/// Create a copy of NameOfAllahModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? text = null,Object? nameTranslation = null,Object? textTranslation = null,}) {
  return _then(NameOfAllahModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,nameTranslation: null == nameTranslation ? _self.nameTranslation : nameTranslation // ignore: cast_nullable_to_non_nullable
as String,textTranslation: null == textTranslation ? _self.textTranslation : textTranslation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NameOfAllahModel].
extension NameOfAllahModelPatterns on NameOfAllahModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NameOfAllahModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NameOfAllahModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NameOfAllahModel value)  $default,){
final _that = this;
switch (_that) {
case _NameOfAllahModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NameOfAllahModel value)?  $default,){
final _that = this;
switch (_that) {
case _NameOfAllahModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String text,  String nameTranslation,  String textTranslation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NameOfAllahModel() when $default != null:
return $default(_that.id,_that.name,_that.text,_that.nameTranslation,_that.textTranslation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String text,  String nameTranslation,  String textTranslation)  $default,) {final _that = this;
switch (_that) {
case _NameOfAllahModel():
return $default(_that.id,_that.name,_that.text,_that.nameTranslation,_that.textTranslation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String text,  String nameTranslation,  String textTranslation)?  $default,) {final _that = this;
switch (_that) {
case _NameOfAllahModel() when $default != null:
return $default(_that.id,_that.name,_that.text,_that.nameTranslation,_that.textTranslation);case _:
  return null;

}
}

}

/// @nodoc


class _NameOfAllahModel extends NameOfAllahModel {
  const _NameOfAllahModel({required this.id, required this.name, required this.text, required this.nameTranslation, required this.textTranslation}): super._();
  

@override final  int id;
@override final  String name;
@override final  String text;
@override final  String nameTranslation;
@override final  String textTranslation;

/// Create a copy of NameOfAllahModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NameOfAllahModelCopyWith<_NameOfAllahModel> get copyWith => __$NameOfAllahModelCopyWithImpl<_NameOfAllahModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NameOfAllahModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.text, text) || other.text == text)&&(identical(other.nameTranslation, nameTranslation) || other.nameTranslation == nameTranslation)&&(identical(other.textTranslation, textTranslation) || other.textTranslation == textTranslation));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,text,nameTranslation,textTranslation);
}

@override
String toString() {
    return 'NameOfAllahModel(id: $id, name: $name, text: $text, nameTranslation: $nameTranslation, textTranslation: $textTranslation)';
}


}

/// @nodoc
abstract mixin class _$NameOfAllahModelCopyWith<$Res> implements $NameOfAllahModelCopyWith<$Res> {
  factory _$NameOfAllahModelCopyWith(_NameOfAllahModel value, $Res Function(_NameOfAllahModel) _then) = __$NameOfAllahModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String text, String nameTranslation, String textTranslation
});




}
/// @nodoc
class __$NameOfAllahModelCopyWithImpl<$Res>
    implements _$NameOfAllahModelCopyWith<$Res> {
  __$NameOfAllahModelCopyWithImpl(this._self, this._then);

  final _NameOfAllahModel _self;
  final $Res Function(_NameOfAllahModel) _then;

/// Create a copy of NameOfAllahModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? text = null,Object? nameTranslation = null,Object? textTranslation = null,}) {
  return _then(_NameOfAllahModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,nameTranslation: null == nameTranslation ? _self.nameTranslation : nameTranslation // ignore: cast_nullable_to_non_nullable
as String,textTranslation: null == textTranslation ? _self.textTranslation : textTranslation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
