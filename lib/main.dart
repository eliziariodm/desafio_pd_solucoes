import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'app/app_widget.dart';
import 'app/core/hive/hive_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await HiveAdapters.start();

  runApp(const AppWidget());
}
