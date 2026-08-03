import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService instance = NotificationService._internal();
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
  tz.initializeTimeZones();

  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  const settings = InitializationSettings(android: androidSettings, iOS: iosSettings);
  
  await _notifications.initialize(settings);

  final androidPlugin = _notifications
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

  await androidPlugin?.requestNotificationsPermission();
  await androidPlugin?.requestExactAlarmsPermission();
}

 Future<void> scheduleReminder({
  required int id,
  required String bookTitle,
  required DateTime dateTime,
  
})

 async {
  await _notifications.zonedSchedule(
    
    id,
    "Time to read 📖",
    "Don't forget to continue reading \"$bookTitle\"",
    tz.TZDateTime.from(dateTime, tz.local),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'reading_reminders',
        'Reading Reminders',
        channelDescription: 'Reminders to continue reading your books',
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, // <-- add this line
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

  Future<void> cancelReminder(int id) async {
    await _notifications.cancel(id);
  }
}