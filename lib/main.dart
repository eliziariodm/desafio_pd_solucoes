import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app/app_widget.dart';
import 'app/core/hive/hive_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await HiveAdapters.startMobile();
  }
  await HiveAdapters.startWeb();

  runApp(const AppWidget());
}
