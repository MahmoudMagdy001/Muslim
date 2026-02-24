import 'package:equatable/equatable.dart';

import '../../data/models/zikr_model.dart';
import '../../domain/entities/zikr_entity.dart';

enum SebhaRequestStatus { initial, loading, success, failure }

class SebhaState extends Equatable {
  const SebhaState({
    this.status = SebhaRequestStatus.initial,
    this.counter = 0,
    this.currentIndex = 0,
    this.customGoal,
    this.customAzkar = const [],
    this.goalReached = false,
  });

  final SebhaRequestStatus status;
  final int counter;
  final int currentIndex;
  final int? customGoal;
  final List<ZikrEntity> customAzkar;
  final bool goalReached;

  List<ZikrEntity> get allAzkar => [...ZikrModel.defaultAzkar, ...customAzkar];

  ZikrEntity? get currentZikr {
    final azkar = allAzkar;
    if (currentIndex < azkar.length) return azkar[currentIndex];
    return null;
  }

  SebhaState copyWith({
    SebhaRequestStatus? status,
    int? counter,
    int? currentIndex,
    int? Function()? customGoal,
    List<ZikrEntity>? customAzkar,
    bool? goalReached,
  }) => SebhaState(
    status: status ?? this.status,
    counter: counter ?? this.counter,
    currentIndex: currentIndex ?? this.currentIndex,
    customGoal: customGoal != null ? customGoal() : this.customGoal,
    customAzkar: customAzkar ?? this.customAzkar,
    goalReached: goalReached ?? this.goalReached,
  );

  @override
  List<Object?> get props => [
    status,
    counter,
    currentIndex,
    customGoal,
    customAzkar,
    goalReached,
  ];
}
