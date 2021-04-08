import 'package:blossom_clinic/page/splash_screen_page.dart';
import 'package:blossom_clinic/page/splash_screen_provider.dart';
import 'package:blossom_clinic/repository/omise_repository.dart';
import 'package:blossom_clinic/repository/omise_repository_impl.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:blossom_clinic/repository/remote_repository_impl.dart';
import 'package:blossom_clinic/utils/shared_pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'blossom_theme.dart';
import 'model/user_model.dart';
import 'network/omise_rest_client_manager.dart';
import 'network/omise_retrofit_client.dart';
import 'network/rest_client_manager.dart';
import 'network/retrofit_client.dart';

void main() {
  _provideDependency();
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
}

class BlossomClinicApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: BlossomTheme.white
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (BuildContext context) {
            return SplashScreenProvider();
          },)
        ],
        child: SplashScreenPage(),
      ),
    );
  }
}
