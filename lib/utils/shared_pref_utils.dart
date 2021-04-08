import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {

  Future<void> saveUserModel(String userModelJson) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("UserModel", userModelJson);
  }

  Future<String> getUserModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("UserModel");
  }

  Future<void> clearUserModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("UserModel", "");
  }
}