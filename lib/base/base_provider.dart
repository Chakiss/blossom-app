import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/model/status_model.dart';
import 'package:blossom_clinic/utils/error_handle.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injector/injector.dart';

class BaseProvider {

  ErrorHandle errorHandle = Injector.appInstance.get();

  Future<void> showToast(String message) async {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: BlossomTheme.black,
        textColor: BlossomTheme.white);
  }
}