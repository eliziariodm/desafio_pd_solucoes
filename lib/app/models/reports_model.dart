import 'dart:convert';

class ReportsModel {
  final int id;
  final int employeeId;
  final String description;
  final int spentHours;
  final String createdAt;

  ReportsModel({
    required this.id,
    required this.employeeId,
    required this.description,
    required this.spentHours,
    required this.createdAt,
  });

  factory ReportsModel.fromMap(Map<String, dynamic> map) {
    return ReportsModel(
      id: map['id'] ?? 0,
      employeeId: map['employeeId'] ?? 0,
      description: map['description'] ?? '',
      spentHours: map['spentHours'] ?? 0,
      createdAt: map['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employeeId': employeeId,
      'description': description,
      'spentHours': spentHours,
      'createdAt': createdAt,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory ReportsModel.fromJson(String json) =>
      ReportsModel.fromMap(jsonDecode(json));

  @override
  String toString() {
    return 'ReportsModel(id: $id, employeeId: $employeeId, description: $description, spentHours: $spentHours, createdAt: $createdAt)';
  }
}
