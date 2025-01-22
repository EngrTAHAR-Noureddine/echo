import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:echo/constant/constant.dart';
import 'package:echo/constant/screen_routes.dart';
import 'package:echo/firebase_options.dart';
import 'package:echo/utils/app_singleton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class FireMessageService {
  /// private constructor
  FireMessageService._();

  /// the one and only instance of this singleton
  static final instance = FireMessageService._();

  String? fcmToken;
  final Dio dio = Dio();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _messaging.setAutoInitEnabled(true);
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> unSubscribeToTopic() async {
    await _messaging.unsubscribeFromTopic("chat");
    await _messaging.deleteToken();
  }

  Future<void> setup() async {
    _setupOnMessage();
    _setupOnBackground();
    await _setupInteractedMessage();
    await _subscribeToTopic();
  }

  void _setupOnMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('[FireMessageService] Got a message whilst in the foreground!');
      // print('[FireMessageService] Message data: ${message.data}');

      // if (message.notification != null) {
      //   print(
      //       '[FireMessageService] Message also contained a notification: ${message.notification}');
      // }
    });
  }

  void _setupOnBackground() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _setupInteractedMessage() async {
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      if (navigatorKey.currentContext != null) {
        Navigator.pushNamed(
          navigatorKey.currentContext!,
          NavigationRoutes.chat,
          arguments: ["", null, false],
        );
      }
    }
  }

  String _constructFCMPayload(String? token, String message) {
    return jsonEncode({
      'token': token,
      'topic': 'chat',
      'data': {
        'via': 'Echo',
        'count': '0',
      },
      'notification': {
        'title': AppSingleton.instance.user?.displayName ?? 'Echo',
        'body': message,
      },
    });
  }

  Future<void> _subscribeToTopic() async {
    await _messaging.subscribeToTopic("chat");
    fcmToken = await _messaging.getToken();
  }
}
