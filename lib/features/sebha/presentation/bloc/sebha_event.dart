import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/sebha/domain/entities/zikr_entity.dart';

part 'sebha_event.freezed.dart';

@freezed
sealed class SebhaEvent with _$SebhaEvent {
  const factory SebhaEvent.loadCustomAzkar() = SebhaLoadCustomAzkar;
  const factory SebhaEvent.increment() = SebhaIncrement;
  const factory SebhaEvent.reset() = SebhaReset;
  const factory SebhaEvent.consumeGoalReached() = SebhaConsumeGoalReached;
  const factory SebhaEvent.selectZikr(int index) = SebhaSelectZikr;
  const factory SebhaEvent.setGoal(int? goal) = SebhaSetGoal;
  const factory SebhaEvent.addCustomZikr(ZikrEntity zikr) = SebhaAddCustomZikr;
  const factory SebhaEvent.editCustomZikr(ZikrEntity zikr) = SebhaEditCustomZikr;
  const factory SebhaEvent.deleteCustomZikr(String id) = SebhaDeleteCustomZikr;
}
