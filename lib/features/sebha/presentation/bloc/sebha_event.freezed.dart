// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sebha_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SebhaEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SebhaEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SebhaEvent()';
}


}

/// @nodoc
class $SebhaEventCopyWith<$Res>  {
$SebhaEventCopyWith(SebhaEvent _, $Res Function(SebhaEvent) __);
}


/// Adds pattern-matching-related methods to [SebhaEvent].
extension SebhaEventPatterns on SebhaEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SebhaLoadCustomAzkar value)?  loadCustomAzkar,TResult Function( SebhaIncrement value)?  increment,TResult Function( SebhaReset value)?  reset,TResult Function( SebhaConsumeGoalReached value)?  consumeGoalReached,TResult Function( SebhaSelectZikr value)?  selectZikr,TResult Function( SebhaSetGoal value)?  setGoal,TResult Function( SebhaAddCustomZikr value)?  addCustomZikr,TResult Function( SebhaEditCustomZikr value)?  editCustomZikr,TResult Function( SebhaDeleteCustomZikr value)?  deleteCustomZikr,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SebhaLoadCustomAzkar() when loadCustomAzkar != null:
return loadCustomAzkar(_that);case SebhaIncrement() when increment != null:
return increment(_that);case SebhaReset() when reset != null:
return reset(_that);case SebhaConsumeGoalReached() when consumeGoalReached != null:
return consumeGoalReached(_that);case SebhaSelectZikr() when selectZikr != null:
return selectZikr(_that);case SebhaSetGoal() when setGoal != null:
return setGoal(_that);case SebhaAddCustomZikr() when addCustomZikr != null:
return addCustomZikr(_that);case SebhaEditCustomZikr() when editCustomZikr != null:
return editCustomZikr(_that);case SebhaDeleteCustomZikr() when deleteCustomZikr != null:
return deleteCustomZikr(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SebhaLoadCustomAzkar value)  loadCustomAzkar,required TResult Function( SebhaIncrement value)  increment,required TResult Function( SebhaReset value)  reset,required TResult Function( SebhaConsumeGoalReached value)  consumeGoalReached,required TResult Function( SebhaSelectZikr value)  selectZikr,required TResult Function( SebhaSetGoal value)  setGoal,required TResult Function( SebhaAddCustomZikr value)  addCustomZikr,required TResult Function( SebhaEditCustomZikr value)  editCustomZikr,required TResult Function( SebhaDeleteCustomZikr value)  deleteCustomZikr,}){
final _that = this;
switch (_that) {
case SebhaLoadCustomAzkar():
return loadCustomAzkar(_that);case SebhaIncrement():
return increment(_that);case SebhaReset():
return reset(_that);case SebhaConsumeGoalReached():
return consumeGoalReached(_that);case SebhaSelectZikr():
return selectZikr(_that);case SebhaSetGoal():
return setGoal(_that);case SebhaAddCustomZikr():
return addCustomZikr(_that);case SebhaEditCustomZikr():
return editCustomZikr(_that);case SebhaDeleteCustomZikr():
return deleteCustomZikr(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SebhaLoadCustomAzkar value)?  loadCustomAzkar,TResult? Function( SebhaIncrement value)?  increment,TResult? Function( SebhaReset value)?  reset,TResult? Function( SebhaConsumeGoalReached value)?  consumeGoalReached,TResult? Function( SebhaSelectZikr value)?  selectZikr,TResult? Function( SebhaSetGoal value)?  setGoal,TResult? Function( SebhaAddCustomZikr value)?  addCustomZikr,TResult? Function( SebhaEditCustomZikr value)?  editCustomZikr,TResult? Function( SebhaDeleteCustomZikr value)?  deleteCustomZikr,}){
final _that = this;
switch (_that) {
case SebhaLoadCustomAzkar() when loadCustomAzkar != null:
return loadCustomAzkar(_that);case SebhaIncrement() when increment != null:
return increment(_that);case SebhaReset() when reset != null:
return reset(_that);case SebhaConsumeGoalReached() when consumeGoalReached != null:
return consumeGoalReached(_that);case SebhaSelectZikr() when selectZikr != null:
return selectZikr(_that);case SebhaSetGoal() when setGoal != null:
return setGoal(_that);case SebhaAddCustomZikr() when addCustomZikr != null:
return addCustomZikr(_that);case SebhaEditCustomZikr() when editCustomZikr != null:
return editCustomZikr(_that);case SebhaDeleteCustomZikr() when deleteCustomZikr != null:
return deleteCustomZikr(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadCustomAzkar,TResult Function()?  increment,TResult Function()?  reset,TResult Function()?  consumeGoalReached,TResult Function( int index)?  selectZikr,TResult Function( int? goal)?  setGoal,TResult Function( ZikrEntity zikr)?  addCustomZikr,TResult Function( ZikrEntity zikr)?  editCustomZikr,TResult Function( String id)?  deleteCustomZikr,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SebhaLoadCustomAzkar() when loadCustomAzkar != null:
return loadCustomAzkar();case SebhaIncrement() when increment != null:
return increment();case SebhaReset() when reset != null:
return reset();case SebhaConsumeGoalReached() when consumeGoalReached != null:
return consumeGoalReached();case SebhaSelectZikr() when selectZikr != null:
return selectZikr(_that.index);case SebhaSetGoal() when setGoal != null:
return setGoal(_that.goal);case SebhaAddCustomZikr() when addCustomZikr != null:
return addCustomZikr(_that.zikr);case SebhaEditCustomZikr() when editCustomZikr != null:
return editCustomZikr(_that.zikr);case SebhaDeleteCustomZikr() when deleteCustomZikr != null:
return deleteCustomZikr(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadCustomAzkar,required TResult Function()  increment,required TResult Function()  reset,required TResult Function()  consumeGoalReached,required TResult Function( int index)  selectZikr,required TResult Function( int? goal)  setGoal,required TResult Function( ZikrEntity zikr)  addCustomZikr,required TResult Function( ZikrEntity zikr)  editCustomZikr,required TResult Function( String id)  deleteCustomZikr,}) {final _that = this;
switch (_that) {
case SebhaLoadCustomAzkar():
return loadCustomAzkar();case SebhaIncrement():
return increment();case SebhaReset():
return reset();case SebhaConsumeGoalReached():
return consumeGoalReached();case SebhaSelectZikr():
return selectZikr(_that.index);case SebhaSetGoal():
return setGoal(_that.goal);case SebhaAddCustomZikr():
return addCustomZikr(_that.zikr);case SebhaEditCustomZikr():
return editCustomZikr(_that.zikr);case SebhaDeleteCustomZikr():
return deleteCustomZikr(_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadCustomAzkar,TResult? Function()?  increment,TResult? Function()?  reset,TResult? Function()?  consumeGoalReached,TResult? Function( int index)?  selectZikr,TResult? Function( int? goal)?  setGoal,TResult? Function( ZikrEntity zikr)?  addCustomZikr,TResult? Function( ZikrEntity zikr)?  editCustomZikr,TResult? Function( String id)?  deleteCustomZikr,}) {final _that = this;
switch (_that) {
case SebhaLoadCustomAzkar() when loadCustomAzkar != null:
return loadCustomAzkar();case SebhaIncrement() when increment != null:
return increment();case SebhaReset() when reset != null:
return reset();case SebhaConsumeGoalReached() when consumeGoalReached != null:
return consumeGoalReached();case SebhaSelectZikr() when selectZikr != null:
return selectZikr(_that.index);case SebhaSetGoal() when setGoal != null:
return setGoal(_that.goal);case SebhaAddCustomZikr() when addCustomZikr != null:
return addCustomZikr(_that.zikr);case SebhaEditCustomZikr() when editCustomZikr != null:
return editCustomZikr(_that.zikr);case SebhaDeleteCustomZikr() when deleteCustomZikr != null:
return deleteCustomZikr(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class SebhaLoadCustomAzkar implements SebhaEvent {
  const SebhaLoadCustomAzkar();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SebhaLoadCustomAzkar);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SebhaEvent.loadCustomAzkar()';
}


}




/// @nodoc


class SebhaIncrement implements SebhaEvent {
  const SebhaIncrement();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SebhaIncrement);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SebhaEvent.increment()';
}


}




/// @nodoc


class SebhaReset implements SebhaEvent {
  const SebhaReset();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SebhaReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SebhaEvent.reset()';
}


}




/// @nodoc


class SebhaConsumeGoalReached implements SebhaEvent {
  const SebhaConsumeGoalReached();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SebhaConsumeGoalReached);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SebhaEvent.consumeGoalReached()';
}


}




/// @nodoc


class SebhaSelectZikr implements SebhaEvent {
  const SebhaSelectZikr(this.index);
  

 final  int index;

/// Create a copy of SebhaEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SebhaSelectZikrCopyWith<SebhaSelectZikr> get copyWith => _$SebhaSelectZikrCopyWithImpl<SebhaSelectZikr>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SebhaSelectZikr&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode {
    return Object.hash(runtimeType,index);
}

@override
String toString() {
    return 'SebhaEvent.selectZikr(index: $index)';
}


}

/// @nodoc
abstract mixin class $SebhaSelectZikrCopyWith<$Res> implements $SebhaEventCopyWith<$Res> {
  factory $SebhaSelectZikrCopyWith(SebhaSelectZikr value, $Res Function(SebhaSelectZikr) _then) = _$SebhaSelectZikrCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$SebhaSelectZikrCopyWithImpl<$Res>
    implements $SebhaSelectZikrCopyWith<$Res> {
  _$SebhaSelectZikrCopyWithImpl(this._self, this._then);

  final SebhaSelectZikr _self;
  final $Res Function(SebhaSelectZikr) _then;

/// Create a copy of SebhaEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(SebhaSelectZikr(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SebhaSetGoal implements SebhaEvent {
  const SebhaSetGoal(this.goal);
  

 final  int? goal;

/// Create a copy of SebhaEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SebhaSetGoalCopyWith<SebhaSetGoal> get copyWith => _$SebhaSetGoalCopyWithImpl<SebhaSetGoal>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SebhaSetGoal&&(identical(other.goal, goal) || other.goal == goal));
}


@override
int get hashCode {
    return Object.hash(runtimeType,goal);
}

@override
String toString() {
    return 'SebhaEvent.setGoal(goal: $goal)';
}


}

/// @nodoc
abstract mixin class $SebhaSetGoalCopyWith<$Res> implements $SebhaEventCopyWith<$Res> {
  factory $SebhaSetGoalCopyWith(SebhaSetGoal value, $Res Function(SebhaSetGoal) _then) = _$SebhaSetGoalCopyWithImpl;
@useResult
$Res call({
 int? goal
});




}
/// @nodoc
class _$SebhaSetGoalCopyWithImpl<$Res>
    implements $SebhaSetGoalCopyWith<$Res> {
  _$SebhaSetGoalCopyWithImpl(this._self, this._then);

  final SebhaSetGoal _self;
  final $Res Function(SebhaSetGoal) _then;

/// Create a copy of SebhaEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? goal = freezed,}) {
  return _then(SebhaSetGoal(
freezed == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class SebhaAddCustomZikr implements SebhaEvent {
  const SebhaAddCustomZikr(this.zikr);
  

 final  ZikrEntity zikr;

/// Create a copy of SebhaEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SebhaAddCustomZikrCopyWith<SebhaAddCustomZikr> get copyWith => _$SebhaAddCustomZikrCopyWithImpl<SebhaAddCustomZikr>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SebhaAddCustomZikr&&(identical(other.zikr, zikr) || other.zikr == zikr));
}


@override
int get hashCode {
    return Object.hash(runtimeType,zikr);
}

@override
String toString() {
    return 'SebhaEvent.addCustomZikr(zikr: $zikr)';
}


}

/// @nodoc
abstract mixin class $SebhaAddCustomZikrCopyWith<$Res> implements $SebhaEventCopyWith<$Res> {
  factory $SebhaAddCustomZikrCopyWith(SebhaAddCustomZikr value, $Res Function(SebhaAddCustomZikr) _then) = _$SebhaAddCustomZikrCopyWithImpl;
@useResult
$Res call({
 ZikrEntity zikr
});


$ZikrEntityCopyWith<$Res> get zikr;

}
/// @nodoc
class _$SebhaAddCustomZikrCopyWithImpl<$Res>
    implements $SebhaAddCustomZikrCopyWith<$Res> {
  _$SebhaAddCustomZikrCopyWithImpl(this._self, this._then);

  final SebhaAddCustomZikr _self;
  final $Res Function(SebhaAddCustomZikr) _then;

/// Create a copy of SebhaEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? zikr = null,}) {
  return _then(SebhaAddCustomZikr(
null == zikr ? _self.zikr : zikr // ignore: cast_nullable_to_non_nullable
as ZikrEntity,
  ));
}

/// Create a copy of SebhaEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZikrEntityCopyWith<$Res> get zikr {
  
  return $ZikrEntityCopyWith<$Res>(_self.zikr, (value) {
    return _then(_self.copyWith(zikr: value));
  });
}
}

/// @nodoc


class SebhaEditCustomZikr implements SebhaEvent {
  const SebhaEditCustomZikr(this.zikr);
  

 final  ZikrEntity zikr;

/// Create a copy of SebhaEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SebhaEditCustomZikrCopyWith<SebhaEditCustomZikr> get copyWith => _$SebhaEditCustomZikrCopyWithImpl<SebhaEditCustomZikr>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SebhaEditCustomZikr&&(identical(other.zikr, zikr) || other.zikr == zikr));
}


@override
int get hashCode {
    return Object.hash(runtimeType,zikr);
}

@override
String toString() {
    return 'SebhaEvent.editCustomZikr(zikr: $zikr)';
}


}

/// @nodoc
abstract mixin class $SebhaEditCustomZikrCopyWith<$Res> implements $SebhaEventCopyWith<$Res> {
  factory $SebhaEditCustomZikrCopyWith(SebhaEditCustomZikr value, $Res Function(SebhaEditCustomZikr) _then) = _$SebhaEditCustomZikrCopyWithImpl;
@useResult
$Res call({
 ZikrEntity zikr
});


$ZikrEntityCopyWith<$Res> get zikr;

}
/// @nodoc
class _$SebhaEditCustomZikrCopyWithImpl<$Res>
    implements $SebhaEditCustomZikrCopyWith<$Res> {
  _$SebhaEditCustomZikrCopyWithImpl(this._self, this._then);

  final SebhaEditCustomZikr _self;
  final $Res Function(SebhaEditCustomZikr) _then;

/// Create a copy of SebhaEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? zikr = null,}) {
  return _then(SebhaEditCustomZikr(
null == zikr ? _self.zikr : zikr // ignore: cast_nullable_to_non_nullable
as ZikrEntity,
  ));
}

/// Create a copy of SebhaEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZikrEntityCopyWith<$Res> get zikr {
  
  return $ZikrEntityCopyWith<$Res>(_self.zikr, (value) {
    return _then(_self.copyWith(zikr: value));
  });
}
}

/// @nodoc


class SebhaDeleteCustomZikr implements SebhaEvent {
  const SebhaDeleteCustomZikr(this.id);
  

 final  String id;

/// Create a copy of SebhaEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SebhaDeleteCustomZikrCopyWith<SebhaDeleteCustomZikr> get copyWith => _$SebhaDeleteCustomZikrCopyWithImpl<SebhaDeleteCustomZikr>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SebhaDeleteCustomZikr&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id);
}

@override
String toString() {
    return 'SebhaEvent.deleteCustomZikr(id: $id)';
}


}

/// @nodoc
abstract mixin class $SebhaDeleteCustomZikrCopyWith<$Res> implements $SebhaEventCopyWith<$Res> {
  factory $SebhaDeleteCustomZikrCopyWith(SebhaDeleteCustomZikr value, $Res Function(SebhaDeleteCustomZikr) _then) = _$SebhaDeleteCustomZikrCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$SebhaDeleteCustomZikrCopyWithImpl<$Res>
    implements $SebhaDeleteCustomZikrCopyWith<$Res> {
  _$SebhaDeleteCustomZikrCopyWithImpl(this._self, this._then);

  final SebhaDeleteCustomZikr _self;
  final $Res Function(SebhaDeleteCustomZikr) _then;

/// Create a copy of SebhaEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(SebhaDeleteCustomZikr(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
