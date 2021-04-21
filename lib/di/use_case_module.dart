import 'package:blossom_clinic/usecase/register_use_case.dart';
import 'package:injector/injector.dart';

class UseCaseModule {
  Injector injector;

  UseCaseModule(this.injector);

  void provide() {
    injector.registerDependency<RegisterUseCase>(() => RegisterUseCase(injector.get()));
  }
}
