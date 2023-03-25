import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/reports_model.dart';

class ReportsRepository {
  Future<List<ReportsModel>> fetchReports() async {
    String jsonString = await rootBundle.loadString('jsons/reflections.json');
    List list = jsonDecode(jsonString);
    return list.map((json) => ReportsModel.fromMap(json)).toList();
  }
}
