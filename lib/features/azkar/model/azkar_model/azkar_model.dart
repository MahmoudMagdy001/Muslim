class AzkarModel {
  AzkarModel({
    required this.category,
    required this.count,
    required this.description,
    required this.reference,
    required this.search,
    required this.zekr,
  });

  factory AzkarModel.fromJson(Map<String, dynamic> json) {
    int parsedCount = 0;
    final dynamic rawCount = json['count'];

    if (rawCount is int) {
      parsedCount = rawCount;
    } else if (rawCount is String && rawCount.trim().isNotEmpty) {
      parsedCount = int.tryParse(rawCount) ?? 0;
    }

    return AzkarModel(
      category: json['category'] as String,
      count: parsedCount,
      description: json['description'] as String?,
      reference: json['reference'] as String?,
      search: json['search'] as String?,
      zekr: json['zekr'] as String?,
    );
  }

  final String category;
  final int? count;
  final String? description;
  final String? reference;
  final String? search;
  final String? zekr;

  Map<String, dynamic> toJson() => {
    'category': category,
    'count': count,
    'description': description,
    'reference': reference,
    'search': search,
    'zekr': zekr,
  };
}
