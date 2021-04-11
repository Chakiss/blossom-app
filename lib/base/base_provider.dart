import 'package:blossom_clinic/model/user_model.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:blossom_clinic/utils/error_handle.dart';
import 'package:injector/injector.dart';

class BaseProvider {

  RemoteRepository remoteRepository = Injector.appInstance.get();
  ErrorHandle errorHandle = Injector.appInstance.get();
  UserModel userModel = Injector.appInstance.get();
}