import 'package:blossom_clinic/network/rest_client_manager.dart';
import 'package:blossom_clinic/network/retrofit_client.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:blossom_clinic/repository/remote_repository_impl.dart';
import 'package:blossom_clinic/utils/error_handle.dart';
import 'package:blossom_clinic/utils/shared_pref_utils.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:injector/injector.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModule {
  Injector injector;
  SharedPreferences sharedPref;

  AppModule(this.injector, this.sharedPref);

  void provide() {
    injector.registerDependency<SharedPrefUtils>(() => SharedPrefUtils(sharedPref));
    injector.registerSingleton<ErrorHandle>(() => ErrorHandle());
    injector.registerSingleton<Logger>(() => Logger());
    injector.registerDependency<RestClientManager>(() => RestClientManager());
    injector.registerSingleton<RetrofitClient>(() {
      RestClientManager restClientManager = injector.get<RestClientManager>();
      return RetrofitClient(restClientManager.getDio());
    });
    injector.registerSingleton<RemoteRepository>(
        () => RemoteRepositoryImpl(retrofitClient: injector.get<RetrofitClient>()));
    injector.registerSingleton<UserData>(() => UserData(injector.get()));
  }
}
