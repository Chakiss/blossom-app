import 'package:blossom_clinic/utils/error_handle.dart';
import 'package:injector/injector.dart';

class BaseProvider {

  ErrorHandle errorHandle = Injector.appInstance.get();

}