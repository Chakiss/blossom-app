import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:injector/injector.dart';

class BaseProvider {

  RemoteRepository remoteRepository = Injector.appInstance.get();
}