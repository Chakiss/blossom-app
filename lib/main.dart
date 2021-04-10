import 'package:blossom_clinic/page/splash_screen_page.dart';
import 'package:blossom_clinic/page/splash_screen_provider.dart';
import 'package:blossom_clinic/repository/omise_repository.dart';
import 'package:blossom_clinic/repository/omise_repository_impl.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:blossom_clinic/repository/remote_repository_impl.dart';
import 'package:blossom_clinic/utils/error_handle.dart';
import 'package:blossom_clinic/utils/shared_pref_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'blossom_theme.dart';
import 'model/user_model.dart';
import 'network/omise_rest_client_manager.dart';
import 'network/omise_retrofit_client.dart';
import 'network/rest_client_manager.dart';
import 'network/retrofit_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting("TH");
  _provideDependency();
  registerFirebaseCloudMessage();
  runApp(BlossomClinicApplication());
}

void _provideDependency() {
  final injector = Injector.appInstance;
  injector.registerSingleton<Logger>(() => Logger());

  injector.registerDependency<RestClientManager>(() => RestClientManager());
  injector.registerSingleton<RetrofitClient>(() {
    RestClientManager restClientManager = injector.get<RestClientManager>();
    return RetrofitClient(restClientManager.getDio());
  });
  injector
      .registerSingleton<RemoteRepository>(() => RemoteRepositoryImpl(retrofitClient: injector.get<RetrofitClient>()));

  injector.registerDependency<OmiseRestClientManager>(() => OmiseRestClientManager());
  injector.registerSingleton<OmiseRetrofitClient>(() {
    OmiseRestClientManager restClientManager = injector.get<OmiseRestClientManager>();
    return OmiseRetrofitClient(restClientManager.getDio());
  });
  injector.registerSingleton<OmiseRepository>(
      () => OmiseRepositoryImpl(omiseRetrofitClient: injector.get<OmiseRetrofitClient>()));

  injector.registerSingleton<UserModel>(() => UserModel());
  injector.registerDependency<SharedPrefUtils>(() => SharedPrefUtils());
  injector.registerSingleton<ErrorHandle>(() => ErrorHandle());
}

Future<void> registerFirebaseCloudMessage() async {
  await Firebase.initializeApp();
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

class BlossomClinicApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: BlossomTheme.white,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) {
              return SplashScreenProvider();
            },
          )
        ],
        child: SplashScreenPage(),
      ),
    );
  }
}
