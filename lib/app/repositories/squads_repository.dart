import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/squads_model.dart';

class SquadsRepository {
  Future<List<SquadsModel>> fetchSquads() async {
    String jsonString = await rootBundle.loadString('jsons/reflections.json');
    List list = jsonDecode(jsonString);
    return list.map((json) => SquadsModel.fromMap(json)).toList();
  }
}
