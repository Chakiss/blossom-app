import 'package:blossom_clinic/usecase/login_facebook_use_case.dart';
import 'package:blossom_clinic/usecase/login_use_case.dart';
import 'package:injector/injector.dart';

class UseCaseModule {
  Injector injector;

  UseCaseModule(this.injector);

  void provide() {
    injector.registerDependency<LoginUseCase>(() => LoginUseCase(injector.get(), injector.get()));
    injector.registerDependency<LoginFacebookUseCase>(() => LoginFacebookUseCase(injector.get(), injector.get()));
  }
}
