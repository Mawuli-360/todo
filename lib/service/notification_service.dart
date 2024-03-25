import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:todo/feature/todo/domain/model/todo_model.dart';
part 'notification_service.g.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings androidInitializationSettings =
      const AndroidInitializationSettings("@mipmap/ic_launcher");

  NotificationService() {
    initialNotification();
  }

  // initialize notification
  Future<void> initialNotification() async {
    _configTimeZone();
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // schedule a local notification
  Future scheduleNotification(
      {required int year,
      required int month,
      required int day,
      required int hour,
      required int minute,
      required TodoModel todo}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channelId', 'channelName',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high);


    await flutterLocalNotificationsPlugin.zonedSchedule(
        todo.id,
        todo.title,
        todo.description,
        tz.TZDateTime.from(DateTime(year, month, day, hour, minute), tz.local),
        const NotificationDetails(android: androidNotificationDetails),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: "payload",
        matchDateTimeComponents: DateTimeComponents.time);
  }

  //config time zone
  Future<void> _configTimeZone() async {
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
  }

  //cancel all notifications
  Future cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

@riverpod
NotificationService notificationService(NotificationServiceRef ref) {
  return NotificationService();
}
