import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class TYMNotificationsHelper{
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future showNotification({
  int id = 0,
  String? title,
  String? body,
  String? payload,
  }) async =>
      _notifications.show(
          id,
          title,
          body,
          await _notificationDetails(),
          payload: payload,
      );


  static Future showScheduledNotification({
    required int alarmid,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledTime
  }) async =>
      _notifications.zonedSchedule(
        alarmid,
        title,
        body,
        _scheduleDaily(scheduledTime),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );

  static void cancel(int id) => _notifications.cancel(id);
  static void cancelAll() => _notifications.cancelAll();

  static Future _notificationDetails() async{
    final sound = 'calm.wav';
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id 3',
        'channel name',
        importance: Importance.max,
        priority: Priority.max,
        sound: RawResourceAndroidNotificationSound(sound.split('.').first),
      ),
      iOS: DarwinNotificationDetails(
        sound: sound,
      )
    );
  }

  static Future initialize({bool initScheduled = false}) async{
    var androidInitialize = new AndroidInitializationSettings('mipmap/launcher_icon');
    var iosInitialize = new DarwinInitializationSettings();
    var initializationSettings = new InitializationSettings(
      android: androidInitialize,
      iOS: iosInitialize
    );
    await _notifications.initialize(initializationSettings);
    if(initScheduled){
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static tz.TZDateTime _scheduleDaily(DateTime time){
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);
    return scheduledDate.isBefore(now)
        ? scheduledDate.add(Duration(days: 1))
        : scheduledDate;
  }

}