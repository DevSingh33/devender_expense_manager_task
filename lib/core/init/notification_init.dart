import 'package:devender_expense_manager_task/core/logging/logging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzd;

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Initialize notification settings
  Future<void> initialize() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    tzd.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap
        kLog('Notification clicked: ${details.payload}',name: "notification tapped");
      },
    );
  }

  // Schedule daily notifications at 1 AM and 10 PM
  Future<void> scheduleDailyNotifications() async {
    // Schedule 1 Pm notification
    await _scheduleDaily(
      id: 1,
      hour: 13,
      minute: 0,
      title: 'Afternoon Expense Check 📝',
      body: 'Time to log your morning expenses!',
    );

    // Schedule 10 PM notification
    await _scheduleDaily(
      id: 2,
      hour: 22,
      minute: 0,
      title: 'Check Daily Expense Summary 🌙',
      body: 'Don\'t forget to add your remaining expenses for today!',
    );
  }

  /// method to schedule a daily notification with provided [id], [hour], [minute], [title], [body]
  Future<void> _scheduleDaily({
    required int id,
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(hour, minute),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'expense_reminders',
          'Expense Reminders',
          channelDescription: 'Daily expense tracking reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
      // androidAllowWhileIdle: true,

      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Calculate next instance of time
  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  /// Show immediate demo notification
  Future<void> showDemoNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'demo_notifications',
      'Demo Notifications',
      channelDescription: 'Demo notification channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      'Demo Notification',
      'Please add your expenses 📝',
      platformChannelSpecifics,
    );
  }
}
