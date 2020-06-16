import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:debts_app/core/utils/utils.dart' as utils;
import 'package:debts_app/core/data/repositories/debtors_repository_impl.dart';
import 'package:debts_app/core/data/repositories/lenders_repository_impl.dart';
import 'package:debts_app/core/domain/repositories/debtors_repository.dart';
import 'package:debts_app/core/domain/repositories/lenders_repository.dart';

class Worker {
  static const _alarmId = 2;
  static const _duration = Duration(days: 31);

  static void setupRecurrentWork() {
    final now = DateTime.now();
    final month = now.month < 12 ? now.month + 1 : 1;
    final year = now.month == 12 ? now.year + 1 : now.year;
    final startAt = DateTime(year, month, 1, 9, 30);
    AndroidAlarmManager.periodic(
      _duration,
      _alarmId,
      _monthlyWork,
      startAt: startAt,
      exact: true,
      rescheduleOnReboot: true,
      wakeup: true,
    );
  }
}

Future<void> _monthlyWork() async {
  try {
    double totalOweMe = 0.0;
    double totalIOwe = 0.0;
    final DebtorsRepository debtorsRepository = DebtorsRepositoryImpl();
    final LendersRepository lendersRepository = LendersRepositoryImpl();
    final debtors = await debtorsRepository.getDebtors();
    for (final d in debtors) {
      totalOweMe += d.total;
    }
    final lenders = await lendersRepository.getLenders();
    for (final l in lenders) {
      totalIOwe += l.total;
    }

    String message = '';
    const format = r'$#,##0.#';
    final value1 = utils.formatCurrency(totalOweMe, format);
    final value2 = utils.formatCurrency(totalIOwe, format);
    if (totalIOwe <= 0 && totalOweMe <= 0) {
      message = 'No tienes nada pendiente';
    } else if (totalIOwe > 0 && totalOweMe > 0) {
      message = 'Te deben $value1 y debes $value2';
    } else if (totalOweMe > 0) {
      message = 'Te deben $value1';
    } else if (totalIOwe > 0) {
      message = 'Debes $value2';
    }

    const initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notification');
    const initializationSettings =
        InitializationSettings(initializationSettingsAndroid, null);
    final localNotifications = FlutterLocalNotificationsPlugin();
    await localNotifications.initialize(initializationSettings);

    final android = AndroidNotificationDetails(
      'debty_notification_channel',
      'Debty',
      'Resumen de deudas',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker',
      color: utils.Colors.mountainMeadow,
      autoCancel: true,
      styleInformation: BigTextStyleInformation(message),
    );
    final details = NotificationDetails(android, null);

    localNotifications.show(
      1,
      'Resumen Debty',
      message,
      details,
    );
  } catch (e) {
    return;
  }
}
