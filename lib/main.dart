import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

import 'package:debts_app/core/work/worker.dart';
import 'package:debts_app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  Worker.setupRecurrentWork();
  runApp(MyApp());
}
