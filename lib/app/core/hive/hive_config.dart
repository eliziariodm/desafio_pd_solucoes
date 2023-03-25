import 'package:hive_flutter/hive_flutter.dart';

import 'employees_hive_adapter.dart';
import 'reports_hive_adapter.dart';
import 'squads_hive_adapter.dart';

class HiveAdapters {
  static Future start() async {
    Hive.registerAdapter(EmployeesHiveAdapter());
    Hive.registerAdapter(ReportsHiveAdapter());
    Hive.registerAdapter(SquadsHiveAdapter());
  }
}
