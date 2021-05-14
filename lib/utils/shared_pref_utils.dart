import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  SharedPreferences _sharedPref;

  SharedPrefUtils(this._sharedPref);

  static const int _buildVersion = 5;
  static const String _keyMapFilePath = "keyMapFilePath$_buildVersion";
  static const String _keyMapUserReference = "keyMapUserReference";
  static const String _keyMapDoctorReference = "keyMapDoctorReference";

  Future<void> setMapFilePath(Map<String, String> mapFilePath) async {
    await _sharedPref.setString(_keyMapFilePath, json.encode(mapFilePath) ?? "{}");
  }

  Map<String, String> getMapFilePath() {
    final mapFilePathString = _sharedPref.getString(_keyMapFilePath) ?? "{}";
    return Map<String, String>.from(json.decode(mapFilePathString));
  }

  Future<void> setMapUserReference(Map<String, String> mapUserReference) async {
    await _sharedPref.setString(_keyMapUserReference, json.encode(mapUserReference) ?? "{}");
  }

  Map<String, String> getMapUserReference() {
    final mapFilePathString = _sharedPref.getString(_keyMapUserReference) ?? "{}";
    return Map<String, String>.from(json.decode(mapFilePathString));
  }

  Future<void> setMapDoctorReference(Map<String, String> mapUserReference) async {
    await _sharedPref.setString(_keyMapDoctorReference, json.encode(mapUserReference) ?? "{}");
  }

  Map<String, String> getMapDoctorReference() {
    final mapFilePathString = _sharedPref.getString(_keyMapDoctorReference) ?? "{}";
    return Map<String, String>.from(json.decode(mapFilePathString));
  }
}
