import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {

  SharedPreferences _sharedPref;

  SharedPrefUtils(this._sharedPref);

  static const String _keyMapFilePath = "keyMapFilePath";

  Future<void> setMapFilePath(Map<String, String> mapFilePath) async {
    await _sharedPref.setString(_keyMapFilePath, json.encode(mapFilePath) ?? "{}");
  }

  Map<String, String> getMapFilePath() {
    final mapFilePathString = _sharedPref.getString(_keyMapFilePath) ?? "{  }";
    return Map<String, String>.from(json.decode(mapFilePathString));
  }
}