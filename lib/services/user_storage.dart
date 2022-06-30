import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static String userStorageKey = 'fitbitterUserId';

  static save(userId) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(userStorageKey, userId);
  }

  static clear() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(userStorageKey);
  }

  static Future<String?> read() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(userStorageKey);
  }

  static present() async {
    final userId = await read();
    return userId != null && userId.isNotEmpty;
  }
}
