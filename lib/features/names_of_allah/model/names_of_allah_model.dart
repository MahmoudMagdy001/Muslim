class DataItem {
  const DataItem({
    required this.id,
    required this.name,
    required this.text,
    required this.nameTranslation,
    required this.textTranslation,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) => DataItem(
    id: json['id'] as int,
    name: json['name'] as String? ?? '',
    nameTranslation: json['name_translation'] as String? ?? '',
    text: json['text'] as String? ?? '',
    textTranslation: json['text_translation'] as String? ?? '',
  );
  final int id;
  final String name;
  final String nameTranslation;
  final String text;
  final String textTranslation;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'text': text,
    'nameTranslation': nameTranslation,
    'textTranslation': textTranslation,
  };
}

class NamesOfAllahModel {
  const NamesOfAllahModel({this.items = const []});

  factory NamesOfAllahModel.fromJson(List json) => NamesOfAllahModel(
    items: (json)
        .map((e) => DataItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
  final List<DataItem> items;

  Map<String, dynamic> toJson() => {
    'items': items.map((e) => e.toJson()).toList(),
  };
}
