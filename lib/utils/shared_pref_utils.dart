import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  SharedPreferences _sharedPref;
  String _buildNumber;

  SharedPrefUtils(this._sharedPref, this._buildNumber);

  static const String _keyMapFilePath = "keyMapFilePath";
  static const String _keyMapUserReference = "keyMapUserReference";

  Future<void> setMapFilePath(Map<String, String> mapFilePath) async {
    await _sharedPref.setString(_keyMapFilePath + _buildNumber, json.encode(mapFilePath) ?? "{}");
  }

  Map<String, String> getMapFilePath() {
    final mapFilePathString = _sharedPref.getString(_keyMapFilePath + _buildNumber) ?? "{}";
    return Map<String, String>.from(json.decode(mapFilePathString));
  }

  Future<void> setMapUserReference(Map<String, String> mapUserReference) async {
    await _sharedPref.setString(_keyMapUserReference, json.encode(mapUserReference) ?? "{}");
  }

  Map<String, String> getMapUserReference() {
    final mapFilePathString = _sharedPref.getString(_keyMapUserReference) ?? "{}";
    return Map<String, String>.from(json.decode(mapFilePathString));
  }
}
