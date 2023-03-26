import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'employees_hive_adapter.dart';
import 'reports_hive_adapter.dart';
import 'squads_hive_adapter.dart';

class HiveAdapters {
  static Future startWeb() async {
    await Hive.initFlutter();
    Hive.registerAdapter(EmployeesHiveAdapter());
    Hive.registerAdapter(ReportsHiveAdapter());
    Hive.registerAdapter(SquadsHiveAdapter());
  }

  static Future startMobile() async {
    Directory dir = await getApplicationSupportDirectory();

    await Hive.initFlutter(dir.path);
    Hive.registerAdapter(EmployeesHiveAdapter());
    Hive.registerAdapter(ReportsHiveAdapter());
    Hive.registerAdapter(SquadsHiveAdapter());
  }
}
