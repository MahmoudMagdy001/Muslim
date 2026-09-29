import 'package:equatable/equatable.dart';

import 'package:muslim/features/hadith/domain/entities/hadith_entity.dart';

enum HadithStatus { initial, loading, success, error }

class HadithState extends Equatable {
  const HadithState({
    this.status = HadithStatus.initial,
    this.hadiths = const [],
    this.savedHadiths = const [],
    this.savedHadithIds = const {},
    this.dataLoaded = false,
    this.message = '',
  });

  final HadithStatus status;
  final List<HadithEntity> hadiths;
  final List<Map<String, dynamic>> savedHadiths;
  final Set<String> savedHadithIds;
  final bool dataLoaded;
  final String message;

  HadithState copyWith({
    HadithStatus? status,
    List<HadithEntity>? hadiths,
    List<Map<String, dynamic>>? savedHadiths,
    Set<String>? savedHadithIds,
    bool? dataLoaded,
    String? message,
  }) => HadithState(
    status: status ?? this.status,
    hadiths: hadiths ?? this.hadiths,
    savedHadiths: savedHadiths ?? this.savedHadiths,
    savedHadithIds: savedHadithIds ?? this.savedHadithIds,
    dataLoaded: dataLoaded ?? this.dataLoaded,
    message: message ?? this.message,
  );

  @override
  List<Object?> get props => [
    status,
    hadiths,
    savedHadiths,
    savedHadithIds,
    dataLoaded,
    message,
  ];
}
