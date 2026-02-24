import 'package:equatable/equatable.dart';

import '../../../prayer_times/presentation/cubit/prayer_times_state.dart';
import '../../domain/entities/azkar_entity.dart';

class AzkarState extends Equatable {
  const AzkarState({
    this.status = RequestStatus.initial,
    this.contentStatus = RequestStatus.initial,
    this.azkarList = const [],
    this.groupedAzkar = const {},
    this.currentContent = const [],
    this.currentCounts = const {},
    this.message,
  });

  final RequestStatus status;
  final RequestStatus contentStatus;
  final List<AzkarEntity> azkarList;
  final Map<String, List<AzkarEntity>> groupedAzkar;
  final List<AzkarContentEntity> currentContent;
  final Map<int, int> currentCounts;
  final String? message;

  @override
  List<Object?> get props => [
    status,
    contentStatus,
    azkarList,
    groupedAzkar,
    currentContent,
    currentCounts,
    message,
  ];

  AzkarState copyWith({
    RequestStatus? status,
    RequestStatus? contentStatus,
    List<AzkarEntity>? azkarList,
    Map<String, List<AzkarEntity>>? groupedAzkar,
    List<AzkarContentEntity>? currentContent,
    Map<int, int>? currentCounts,
    String? message,
  }) => AzkarState(
    status: status ?? this.status,
    contentStatus: contentStatus ?? this.contentStatus,
    azkarList: azkarList ?? this.azkarList,
    groupedAzkar: groupedAzkar ?? this.groupedAzkar,
    currentContent: currentContent ?? this.currentContent,
    currentCounts: currentCounts ?? this.currentCounts,
    message: message ?? this.message,
  );
}
