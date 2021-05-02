import 'package:blossom_clinic/network/rest_client_manager.dart';
import 'package:blossom_clinic/network/retrofit_client.dart';
import 'package:blossom_clinic/network/shipnity_client.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:blossom_clinic/repository/remote_repository_impl.dart';
import 'package:blossom_clinic/utils/error_handle.dart';
import 'package:blossom_clinic/utils/shared_pref_utils.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:injector/injector.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModule {
  Injector _injector;
  SharedPreferences _sharedPref;
  String _buildNumber;

  AppModule(this._injector, this._sharedPref, this._buildNumber);

  void provide() {
    _injector.registerDependency<SharedPrefUtils>(() => SharedPrefUtils(_sharedPref, _buildNumber));
    _injector.registerSingleton<ErrorHandle>(() => ErrorHandle());
    _injector.registerSingleton<Logger>(() => Logger());
    _injector.registerDependency<RestClientManager>(() => RestClientManager());
    _injector.registerSingleton<RetrofitClient>(() {
      RestClientManager restClientManager = _injector.get<RestClientManager>();
      return RetrofitClient(restClientManager.getDio());
    });
    _injector.registerSingleton<ShipnityClient>(() {
      RestClientManager restClientManager = _injector.get<RestClientManager>();
      return ShipnityClient(restClientManager.getDio());
    });
    _injector.registerSingleton<RemoteRepository>(() => RemoteRepositoryImpl(
        retrofitClient: _injector.get<RetrofitClient>(), shipnityClient: _injector.get<ShipnityClient>()));
    _injector.registerSingleton<UserData>(() => UserData(_injector.get()));
  }
}
