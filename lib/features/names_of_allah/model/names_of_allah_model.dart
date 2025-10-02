class DataItem {
  const DataItem({required this.id, required this.name, required this.text});

  factory DataItem.fromJson(Map<String, dynamic> json) => DataItem(
    id: json['id'] as int,
    name: json['name'] as String? ?? '',
    text: json['text'] as String? ?? '',
  );
  final int id;
  final String name;
  final String text;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'text': text};
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
