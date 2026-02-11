import 'package:equatable/equatable.dart';

import '../../prayer_times/viewmodel/prayer_times_state.dart'; // Reusing RequestStatus from here as discovered earlier
import '../models/azkar_model.dart';

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
  final List<AzkarModel> azkarList;
  final Map<String, List<AzkarModel>> groupedAzkar;
  final List<AzkarContentModel> currentContent;
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
    List<AzkarModel>? azkarList,
    Map<String, List<AzkarModel>>? groupedAzkar,
    List<AzkarContentModel>? currentContent,
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
