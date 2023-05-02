import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData(String key, List<String> value) async {
    try {
      return await sharedPreferences.setStringList(key, value );
    } catch (e) {
      rethrow;
    }
  }

  static getData(String key) {
    try {
      return sharedPreferences.get(key);
    } catch (e) {
      rethrow;
    }
  }
}
