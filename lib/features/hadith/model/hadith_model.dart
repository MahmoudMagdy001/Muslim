class HadithModel {
  HadithModel({
    required this.id,
    required this.hadithNumber,
    required this.hadithArabic,
    required this.headingArabic,
    required this.status,
  });

  factory HadithModel.fromJson(Map<String, dynamic> json) => HadithModel(
    id: json['id']?.toString() ?? '',
    hadithNumber: json['hadithNumber']?.toString() ?? '',
    hadithArabic: json['hadithArabic']?.toString() ?? '',
    headingArabic: json['headingArabic']?.toString() ?? '',
    status: json['status']?.toString() ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'hadithNumber': hadithNumber,
    'hadithArabic': hadithArabic,
    'headingArabic': headingArabic,
    'status': status,
  };

  final String id;
  final String hadithNumber;
  final String hadithArabic;
  final String headingArabic;
  final String status;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HadithModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
