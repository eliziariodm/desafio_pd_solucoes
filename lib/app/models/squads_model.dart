import 'dart:convert';

class SquadsModel {
  final int id;
  final String name;

  SquadsModel({
    required this.id,
    required this.name,
  });

  factory SquadsModel.fromMap(Map<String, dynamic> map) {
    return SquadsModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory SquadsModel.fromJson(String json) =>
      SquadsModel.fromMap(jsonDecode(json));

  @override
  String toString() {
    return 'SquadsModel(id: $id, name: $name)';
  }
}
