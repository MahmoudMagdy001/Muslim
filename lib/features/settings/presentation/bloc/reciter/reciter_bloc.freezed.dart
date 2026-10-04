// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reciter_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReciterState {

 String get selectedReciter;
/// Create a copy of ReciterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReciterStateCopyWith<ReciterState> get copyWith => _$ReciterStateCopyWithImpl<ReciterState>(this as ReciterState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReciterState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReciterState&&(identical(other.selectedReciter, _this.selectedReciter) || other.selectedReciter == _this.selectedReciter));
}


@override
int get hashCode {
  final _this = this as ReciterState;
  return Object.hash(runtimeType,_this.selectedReciter);
}

@override
String toString() {
  final _this = this as ReciterState;
  return 'ReciterState(selectedReciter: ${_this.selectedReciter})';
}


}

/// @nodoc
abstract mixin class $ReciterStateCopyWith<$Res>  {
  factory $ReciterStateCopyWith(ReciterState value, $Res Function(ReciterState) _then) = _$ReciterStateCopyWithImpl;
@useResult
$Res call({
 String selectedReciter
});




}
/// @nodoc
class _$ReciterStateCopyWithImpl<$Res>
    implements $ReciterStateCopyWith<$Res> {
  _$ReciterStateCopyWithImpl(this._self, this._then);

  final ReciterState _self;
  final $Res Function(ReciterState) _then;

/// Create a copy of ReciterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedReciter = null,}) {
  return _then(ReciterState(
selectedReciter: null == selectedReciter ? _self.selectedReciter : selectedReciter // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReciterState].
extension ReciterStatePatterns on ReciterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReciterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReciterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReciterState value)  $default,){
final _that = this;
switch (_that) {
case _ReciterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReciterState value)?  $default,){
final _that = this;
switch (_that) {
case _ReciterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String selectedReciter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReciterState() when $default != null:
return $default(_that.selectedReciter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String selectedReciter)  $default,) {final _that = this;
switch (_that) {
case _ReciterState():
return $default(_that.selectedReciter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String selectedReciter)?  $default,) {final _that = this;
switch (_that) {
case _ReciterState() when $default != null:
return $default(_that.selectedReciter);case _:
  return null;

}
}

}

/// @nodoc


class _ReciterState implements ReciterState {
  const _ReciterState({required this.selectedReciter});
  

@override final  String selectedReciter;

/// Create a copy of ReciterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReciterStateCopyWith<_ReciterState> get copyWith => __$ReciterStateCopyWithImpl<_ReciterState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReciterState&&(identical(other.selectedReciter, selectedReciter) || other.selectedReciter == selectedReciter));
}


@override
int get hashCode {
    return Object.hash(runtimeType,selectedReciter);
}

@override
String toString() {
    return 'ReciterState(selectedReciter: $selectedReciter)';
}


}

/// @nodoc
abstract mixin class _$ReciterStateCopyWith<$Res> implements $ReciterStateCopyWith<$Res> {
  factory _$ReciterStateCopyWith(_ReciterState value, $Res Function(_ReciterState) _then) = __$ReciterStateCopyWithImpl;
@override @useResult
$Res call({
 String selectedReciter
});




}
/// @nodoc
class __$ReciterStateCopyWithImpl<$Res>
    implements _$ReciterStateCopyWith<$Res> {
  __$ReciterStateCopyWithImpl(this._self, this._then);

  final _ReciterState _self;
  final $Res Function(_ReciterState) _then;

/// Create a copy of ReciterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedReciter = null,}) {
  return _then(_ReciterState(
selectedReciter: null == selectedReciter ? _self.selectedReciter : selectedReciter // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
