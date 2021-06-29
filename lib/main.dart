import 'dart:convert';
import 'dart:io';

import 'package:blossom_clinic/blossom_clinic_application.dart';
import 'package:blossom_clinic/di/app_module.dart';
import 'package:blossom_clinic/di/use_case_module.dart';
import 'package:blossom_clinic/utils/connecty_cube_properties.dart';
import 'package:connectycube_sdk/connectycube_core.dart';
import 'package:connectycube_sdk/connectycube_pushnotifications.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injector/injector.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerFirebaseCloudMessage();
  initializeDateFormatting("TH");
  final sharedPref = await SharedPreferences.getInstance();
  _provideDependency(sharedPref);
  _initConnectycube();
  runApp(BlossomClinicApplication());
}

void _provideDependency(SharedPreferences sharedPref) {
  final injector = Injector.appInstance;
  AppModule(injector, sharedPref).provide();
  UseCaseModule(injector).provide();
}

void _initConnectycube() {
  init(ConnectyCubProperties.APP_ID, ConnectyCubProperties.AUTH_KEY, ConnectyCubProperties.AUTH_SECRET,
      onSessionRestore: () {
    return createSession();
  });
}

Future<void> registerFirebaseCloudMessage() async {
  await Firebase.initializeApp();
  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  _messaging.requestPermission(alert: true, badge: true, sound: true);

  await _messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Foreground Message data: ${message.data}');
    if (message.notification != null) {
      final Map<String, String> payload = {};
      payload["title"] = message.notification.title ?? "Blossom";
      payload["message"] = message.notification.body ?? "Message";
      print('Message also contained a notification: ${message.notification}');
      _showNotification(payload);
    } else {
      _showNotification(message.data);
    }
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Background Message data: ${message.data}');
  if (message.notification != null) {
    final Map<String, String> payload = {};
    payload["title"] = message.notification.title ?? "Blossom";
    payload["message"] = message.notification.body ?? "Message";
    print('Message also contained a notification: ${message.notification}');
    _showNotification(payload);
  } else {
    _showNotification(message.data);
  }
}

Future<void> _subscribe(String token) async {
  log('[subscribe] token: $token');
  CreateSubscriptionParameters parameters = CreateSubscriptionParameters();
  parameters.environment = CubeEnvironment.PRODUCTION;

  if (Platform.isAndroid) {
    parameters.channel = NotificationsChannels.GCM;
    parameters.platform = CubePlatform.ANDROID;
    parameters.bundleIdentifier = "com.blossomclinic.app";
  } else if (Platform.isIOS) {
    parameters.channel = NotificationsChannels.APNS;
    parameters.platform = CubePlatform.IOS;
    parameters.bundleIdentifier = "com.blossomclinic.blossomapp";
  }

  String deviceId = await _getDeviceId();
  parameters.udid = deviceId;
  parameters.pushToken = token;

  createSubscription(parameters.getRequestParameters()).then((cubeSubscription) {}).catchError((error) {});
}

Future<String> _getDeviceId() async {
  String identifier;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      identifier = build.androidId; //UUID for Android
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      identifier = data.identifierForVendor; //UUID for iOS
    }
  } on PlatformException {
    print('Failed to get platform version');
  }

  return identifier;
}

Future<void> _showNotification(Map<String, dynamic> payload) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '4837', 'BLOSSOM_NOTIFICATION_CHANNEL', 'BLOSSOM_NOTIFICATION_CHANNEL_DETAIL',
      importance: Importance.max, priority: Priority.high);
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();

  var platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
      111, (payload["title"] as String) ?? "Blossom", (payload["message"] as String) ?? "Message", platformChannelSpecifics,
      payload: jsonEncode(payload));
}

Future<void> subscribeNotification() async {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  String token;
  if (Platform.isAndroid) {
    token = await firebaseMessaging.getToken();
  } else if (Platform.isIOS) {
    token = await firebaseMessaging.getAPNSToken();
  }

  if (!isEmpty(token)) {
    _subscribe(token);
  }

  firebaseMessaging.onTokenRefresh.listen((newToken) {
    _subscribe(newToken);
  });
}
