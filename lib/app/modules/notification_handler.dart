import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Pesan diterima di background: ${message.notification?.title}');
}

class FirebaseMessagingHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotification = FlutterLocalNotificationsPlugin();
  late AndroidNotificationChannel _androidChannel;

  Future<void> initPushNotification() async {
    await initLocalNotification();
    

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('Izin yang diberikan pengguna: ${settings.authorizationStatus}');

    // Mendapatkan token FCM
    _firebaseMessaging.getToken().then((token) {
      print('FCM Token: $token');
    });

    // Saat aplikasi dalam keadaan terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("Pesan saat aplikasi terminated: ${message?.notification?.title}");
    });

    // Saat aplikasi dalam keadaan background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handler untuk notifikasi ketika aplikasi di foreground
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      // Tampilkan notifikasi lokal
      _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/app_icon',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );

      print('Pesan diterima saat aplikasi di foreground: ${message.notification?.title}');
    });

    // Handler ketika pesan dibuka dari notifikasi
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Pesan dibuka dari notifikasi: ${message.notification?.title}');
    });
  }

  Future<void> initLocalNotification() async {
    _androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // name
      description: 'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    // Inisialisasi pengaturan notifikasi
    const ios = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/app_icon');
    const settings = InitializationSettings(android: android, iOS: ios);
    await _localNotification.initialize(settings);

    await _localNotification
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidChannel);
  }
}
