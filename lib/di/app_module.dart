import 'package:blossom_clinic/network/rest_client_manager.dart';
import 'package:blossom_clinic/network/retrofit_client.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:blossom_clinic/repository/remote_repository_impl.dart';
import 'package:blossom_clinic/utils/error_handle.dart';
import 'package:blossom_clinic/utils/shared_pref_utils.dart';
import 'package:injector/injector.dart';
import 'package:logger/logger.dart';

class AppModule {
  Injector injector;

  AppModule(this.injector);

  void provide() {
    injector.registerDependency<SharedPrefUtils>(() => SharedPrefUtils());
    injector.registerSingleton<ErrorHandle>(() => ErrorHandle());
    injector.registerSingleton<Logger>(() => Logger());
    injector.registerDependency<RestClientManager>(() => RestClientManager());
    injector.registerSingleton<RetrofitClient>(() {
      RestClientManager restClientManager = injector.get<RestClientManager>();
      return RetrofitClient(restClientManager.getDio());
    });
    injector.registerSingleton<RemoteRepository>(
        () => RemoteRepositoryImpl(retrofitClient: injector.get<RetrofitClient>()));
  }
}
