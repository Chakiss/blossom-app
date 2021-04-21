import 'package:blossom_clinic/usecase/login_use_case.dart';
import 'package:blossom_clinic/usecase/register_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injector/injector.dart';

class UseCaseModule {
  Injector injector;

  UseCaseModule(this.injector);

  void provide() {
    injector.registerDependency<RegisterUseCase>(() => RegisterUseCase(injector.get()));
    injector.registerDependency<LoginUseCase>(() => LoginUseCase(FirebaseAuth.instance));
  }
}
