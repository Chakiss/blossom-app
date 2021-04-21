import 'package:blossom_clinic/blossom_clinic_application.dart';
import 'package:blossom_clinic/di/app_module.dart';
import 'package:blossom_clinic/di/use_case_module.dart';
import 'package:blossom_clinic/utils/connecty_cube_properties.dart';
import 'package:connectycube_sdk/connectycube_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:intl/date_symbol_data_local.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerFirebaseCloudMessage();
  initializeDateFormatting("TH");
  _provideDependency();
  _initConnectycube();
  runApp(BlossomClinicApplication());
}

void _provideDependency() {
  final injector = Injector.appInstance;
  AppModule(injector).provide();
  UseCaseModule(injector).provide();
}

void _initConnectycube() {
  init(
    ConnectyCubProperties.APP_ID,
    ConnectyCubProperties.AUTH_KEY,
    ConnectyCubProperties.AUTH_SECRET,
    onSessionRestore: () {

    },
  );
}

Future<void> registerFirebaseCloudMessage() async {
  await Firebase.initializeApp();
  // await FirebaseAuth.instance.useEmulator("http://wongsuksiri.thddns.net:6650");
  // FirebaseFirestore.instance.settings = Settings(
  //   host: "http://wongsuksiri.thddns.net:6652",
  //   sslEnabled: false,
  //   persistenceEnabled: false,
  // );
  // FirebaseFunctions.instance.useFunctionsEmulator(origin: "http://wongsuksiri.thddns.net:6651");

  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

  _messaging.getToken().then((token) {
    print("Firebase Token $token"); // Print the Token in Console
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Foreground Message");
    print('Foreground Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Background Message");
  print('Background Message data: ${message.data}');
}
