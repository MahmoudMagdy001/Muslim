import 'package:equatable/equatable.dart';

import '../../domain/entities/hadith_entity.dart';

enum HadithStatus { initial, loading, success, error }

class HadithState extends Equatable {
  const HadithState({
    this.status = HadithStatus.initial,
    this.hadiths = const [],
    this.savedHadiths = const [],
    this.dataLoaded = false,
    this.message = '',
  });

  final HadithStatus status;
  final List<HadithEntity> hadiths;
  final List<Map<String, dynamic>> savedHadiths;
  final bool dataLoaded;
  final String message;

  HadithState copyWith({
    HadithStatus? status,
    List<HadithEntity>? hadiths,
    List<Map<String, dynamic>>? savedHadiths,
    bool? dataLoaded,
    String? message,
  }) => HadithState(
    status: status ?? this.status,
    hadiths: hadiths ?? this.hadiths,
    savedHadiths: savedHadiths ?? this.savedHadiths,
    dataLoaded: dataLoaded ?? this.dataLoaded,
    message: message ?? this.message,
  );

  @override
  List<Object?> get props => [
    status,
    hadiths,
    savedHadiths,
    dataLoaded,
    message,
  ];
}
