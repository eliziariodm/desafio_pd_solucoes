import 'dart:convert';

class EmployeesModel {
  final int id;
  final String name;
  final int estimatedHours;
  final int squadId;

  EmployeesModel({
    required this.id,
    required this.name,
    required this.estimatedHours,
    required this.squadId,
  });

  factory EmployeesModel.fromMap(Map<String, dynamic> map) {
    return EmployeesModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      estimatedHours: map['estimatedHours'] ?? 0,
      squadId: map['squadId'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'estimatedHours': estimatedHours,
      'squadId': squadId,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory EmployeesModel.fromJson(String json) =>
      EmployeesModel.fromMap(jsonDecode(json));

  @override
  String toString() {
    return 'EmployeesModel(id: $id, name: $name, estimatedHours: $estimatedHours, squadId: $squadId)';
  }
}
