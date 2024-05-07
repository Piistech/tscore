import '../../config/config.dart';
import '../shared.dart';

class NotificationManager {
  static final NotificationManager _instance = NotificationManager._internal();

  NotificationManager._internal();

  static NotificationManager get instance => _instance;

//! ------------------------------------ Notification ------------------------------------
  final FlutterLocalNotificationsPlugin _notification = FlutterLocalNotificationsPlugin();

  void initialize() {
    _notification
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('splash');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
    );

    _notification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  void onDidReceiveNotificationResponse(NotificationResponse response) async {
    debugPrint('Notification: $response');
    if (response.actionId == 'stop') {
      AgoraManager.instance.engine.leaveChannel();
    }
  }

  void onCommentaryStarted({
    required String matchName,
    required String channelId,
    required String fixtureGuid,
    required String icon,
  }) {
    final Map<String, String> payload = {
      'matchName': matchName,
      'channelId': channelId,
      'fixtureGuid': fixtureGuid,
    };

    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'live-commentary',
      'Live commentary',
      icon: 'splash',
      channelDescription: 'Live commentary podcast channel',
      importance: Importance.max,
      largeIcon: FilePathAndroidBitmap(icon),
      priority: Priority.max,
      ticker: 'ticker',
      groupKey: 'live-commentary',
      setAsGroupSummary: true,
      ongoing: true,
      showWhen: false,
      playSound: true,
      enableVibration: true,
      progress: 1,
      category: AndroidNotificationCategory.status,
      colorized: true,
      color: const Color.fromARGB(255, 255, 0, 0),
      showProgress: true,
      maxProgress: 1,
      styleInformation: const MediaStyleInformation(),
      groupAlertBehavior: GroupAlertBehavior.all,
      visibility: NotificationVisibility.public,
      actions: [
        const AndroidNotificationAction(
          'stop',
          'Stop',
          showsUserInterface: true,
        ),
      ],
    );

    final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    _notification.show(
      DateTime.now().microsecond,
      matchName,
      'Live',
      notificationDetails,
      payload: json.encode(payload),
    );
  }

  void dismissActiveNotification() {
    _notification.cancelAll();
  }
}
