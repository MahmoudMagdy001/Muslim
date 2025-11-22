import '../../model/hadith_model.dart';

abstract class HadithState {}

class HadithInitial extends HadithState {}

class HadithLoading extends HadithState {}

class HadithLoaded extends HadithState {
  HadithLoaded({
    required this.hadiths,
    required this.savedHadiths,
    required this.dataLoaded,
  });
  final List<HadithModel> hadiths;
  final List<Map<String, dynamic>> savedHadiths;
  final bool dataLoaded;

  HadithLoaded copyWith({
    List<HadithModel>? hadiths,
    List<Map<String, dynamic>>? savedHadiths,
    bool? dataLoaded,
  }) => HadithLoaded(
    hadiths: hadiths ?? this.hadiths,
    savedHadiths: savedHadiths ?? this.savedHadiths,
    dataLoaded: dataLoaded ?? this.dataLoaded,
  );
}

class HadithError extends HadithState {
  HadithError(this.message);
  final String message;
}
