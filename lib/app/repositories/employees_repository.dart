import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/employees_model.dart';

class EmployeesRepository {
  Future<List<EmployeesModel>> fetchEmployees() async {
    String jsonString = await rootBundle.loadString('jsons/messages.json');
    List list = jsonDecode(jsonString);
    return list.map((json) => EmployeesModel.fromMap(json)).toList();
  }
}
