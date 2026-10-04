// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gold_price_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GoldPriceModel {

 double get priceInUsd; String get currency;
/// Create a copy of GoldPriceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoldPriceModelCopyWith<GoldPriceModel> get copyWith => _$GoldPriceModelCopyWithImpl<GoldPriceModel>(this as GoldPriceModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GoldPriceModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoldPriceModel&&(identical(other.priceInUsd, _this.priceInUsd) || other.priceInUsd == _this.priceInUsd)&&(identical(other.currency, _this.currency) || other.currency == _this.currency));
}


@override
int get hashCode {
  final _this = this as GoldPriceModel;
  return Object.hash(runtimeType,_this.priceInUsd,_this.currency);
}

@override
String toString() {
  final _this = this as GoldPriceModel;
  return 'GoldPriceModel(priceInUsd: ${_this.priceInUsd}, currency: ${_this.currency})';
}


}

/// @nodoc
abstract mixin class $GoldPriceModelCopyWith<$Res>  {
  factory $GoldPriceModelCopyWith(GoldPriceModel value, $Res Function(GoldPriceModel) _then) = _$GoldPriceModelCopyWithImpl;
@useResult
$Res call({
 double priceInUsd, String currency
});




}
/// @nodoc
class _$GoldPriceModelCopyWithImpl<$Res>
    implements $GoldPriceModelCopyWith<$Res> {
  _$GoldPriceModelCopyWithImpl(this._self, this._then);

  final GoldPriceModel _self;
  final $Res Function(GoldPriceModel) _then;

/// Create a copy of GoldPriceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? priceInUsd = null,Object? currency = null,}) {
  return _then(GoldPriceModel(
priceInUsd: null == priceInUsd ? _self.priceInUsd : priceInUsd // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GoldPriceModel].
extension GoldPriceModelPatterns on GoldPriceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoldPriceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoldPriceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoldPriceModel value)  $default,){
final _that = this;
switch (_that) {
case _GoldPriceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoldPriceModel value)?  $default,){
final _that = this;
switch (_that) {
case _GoldPriceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double priceInUsd,  String currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoldPriceModel() when $default != null:
return $default(_that.priceInUsd,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double priceInUsd,  String currency)  $default,) {final _that = this;
switch (_that) {
case _GoldPriceModel():
return $default(_that.priceInUsd,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double priceInUsd,  String currency)?  $default,) {final _that = this;
switch (_that) {
case _GoldPriceModel() when $default != null:
return $default(_that.priceInUsd,_that.currency);case _:
  return null;

}
}

}

/// @nodoc


class _GoldPriceModel extends GoldPriceModel {
  const _GoldPriceModel({required this.priceInUsd, required this.currency}): super._();
  

@override final  double priceInUsd;
@override final  String currency;

/// Create a copy of GoldPriceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoldPriceModelCopyWith<_GoldPriceModel> get copyWith => __$GoldPriceModelCopyWithImpl<_GoldPriceModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoldPriceModel&&(identical(other.priceInUsd, priceInUsd) || other.priceInUsd == priceInUsd)&&(identical(other.currency, currency) || other.currency == currency));
}


@override
int get hashCode {
    return Object.hash(runtimeType,priceInUsd,currency);
}

@override
String toString() {
    return 'GoldPriceModel(priceInUsd: $priceInUsd, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$GoldPriceModelCopyWith<$Res> implements $GoldPriceModelCopyWith<$Res> {
  factory _$GoldPriceModelCopyWith(_GoldPriceModel value, $Res Function(_GoldPriceModel) _then) = __$GoldPriceModelCopyWithImpl;
@override @useResult
$Res call({
 double priceInUsd, String currency
});




}
/// @nodoc
class __$GoldPriceModelCopyWithImpl<$Res>
    implements _$GoldPriceModelCopyWith<$Res> {
  __$GoldPriceModelCopyWithImpl(this._self, this._then);

  final _GoldPriceModel _self;
  final $Res Function(_GoldPriceModel) _then;

/// Create a copy of GoldPriceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? priceInUsd = null,Object? currency = null,}) {
  return _then(_GoldPriceModel(
priceInUsd: null == priceInUsd ? _self.priceInUsd : priceInUsd // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
