// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zakat_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ZakatEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ZakatEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ZakatEvent()';
}


}

/// @nodoc
class $ZakatEventCopyWith<$Res>  {
$ZakatEventCopyWith(ZakatEvent _, $Res Function(ZakatEvent) __);
}


/// Adds pattern-matching-related methods to [ZakatEvent].
extension ZakatEventPatterns on ZakatEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ZakatLoadGoldPrice value)?  loadGoldPrice,TResult Function( ZakatSetManualGoldPrice value)?  setManualGoldPrice,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ZakatLoadGoldPrice() when loadGoldPrice != null:
return loadGoldPrice(_that);case ZakatSetManualGoldPrice() when setManualGoldPrice != null:
return setManualGoldPrice(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ZakatLoadGoldPrice value)  loadGoldPrice,required TResult Function( ZakatSetManualGoldPrice value)  setManualGoldPrice,}){
final _that = this;
switch (_that) {
case ZakatLoadGoldPrice():
return loadGoldPrice(_that);case ZakatSetManualGoldPrice():
return setManualGoldPrice(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ZakatLoadGoldPrice value)?  loadGoldPrice,TResult? Function( ZakatSetManualGoldPrice value)?  setManualGoldPrice,}){
final _that = this;
switch (_that) {
case ZakatLoadGoldPrice() when loadGoldPrice != null:
return loadGoldPrice(_that);case ZakatSetManualGoldPrice() when setManualGoldPrice != null:
return setManualGoldPrice(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadGoldPrice,TResult Function( double price)?  setManualGoldPrice,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ZakatLoadGoldPrice() when loadGoldPrice != null:
return loadGoldPrice();case ZakatSetManualGoldPrice() when setManualGoldPrice != null:
return setManualGoldPrice(_that.price);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadGoldPrice,required TResult Function( double price)  setManualGoldPrice,}) {final _that = this;
switch (_that) {
case ZakatLoadGoldPrice():
return loadGoldPrice();case ZakatSetManualGoldPrice():
return setManualGoldPrice(_that.price);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadGoldPrice,TResult? Function( double price)?  setManualGoldPrice,}) {final _that = this;
switch (_that) {
case ZakatLoadGoldPrice() when loadGoldPrice != null:
return loadGoldPrice();case ZakatSetManualGoldPrice() when setManualGoldPrice != null:
return setManualGoldPrice(_that.price);case _:
  return null;

}
}

}

/// @nodoc


class ZakatLoadGoldPrice implements ZakatEvent {
  const ZakatLoadGoldPrice();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ZakatLoadGoldPrice);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ZakatEvent.loadGoldPrice()';
}


}




/// @nodoc


class ZakatSetManualGoldPrice implements ZakatEvent {
  const ZakatSetManualGoldPrice(this.price);
  

 final  double price;

/// Create a copy of ZakatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZakatSetManualGoldPriceCopyWith<ZakatSetManualGoldPrice> get copyWith => _$ZakatSetManualGoldPriceCopyWithImpl<ZakatSetManualGoldPrice>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ZakatSetManualGoldPrice&&(identical(other.price, price) || other.price == price));
}


@override
int get hashCode {
    return Object.hash(runtimeType,price);
}

@override
String toString() {
    return 'ZakatEvent.setManualGoldPrice(price: $price)';
}


}

/// @nodoc
abstract mixin class $ZakatSetManualGoldPriceCopyWith<$Res> implements $ZakatEventCopyWith<$Res> {
  factory $ZakatSetManualGoldPriceCopyWith(ZakatSetManualGoldPrice value, $Res Function(ZakatSetManualGoldPrice) _then) = _$ZakatSetManualGoldPriceCopyWithImpl;
@useResult
$Res call({
 double price
});




}
/// @nodoc
class _$ZakatSetManualGoldPriceCopyWithImpl<$Res>
    implements $ZakatSetManualGoldPriceCopyWith<$Res> {
  _$ZakatSetManualGoldPriceCopyWithImpl(this._self, this._then);

  final ZakatSetManualGoldPrice _self;
  final $Res Function(ZakatSetManualGoldPrice) _then;

/// Create a copy of ZakatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? price = null,}) {
  return _then(ZakatSetManualGoldPrice(
null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
