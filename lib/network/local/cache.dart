import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static SharedPreferences? share;
  static Future<SharedPreferences> init() async {
    return share = await SharedPreferences.getInstance();
  }

  static Future<bool> putData(String key, value) async {
    return await share!.setBool(key, value);
  }

  static bool? getData(String key) {
    return share!.getBool(key);
  }
}
