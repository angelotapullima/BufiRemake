import 'package:bufi_remake/core/error/exceptions.dart';
import 'package:bufi_remake/core/sharedpreferences/storage_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginLocalDataSource {
  Future<String> getLastToken();
  Future<void> guardarPrefs(String key, dynamic value);
}

class LoginLocalDataSourceImpl extends LoginLocalDataSource {
  final SharedPreferences? sharedPreferences;

  LoginLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> guardarPrefs(String key, dynamic value) {
    StorageManager.saveData(key, value);
    return sharedPreferences!.setString('$key-fffff', value);
  }

  @override
  Future<String> getLastToken() async {
    String? jsonStr = await StorageManager.readData('tn');
    if (jsonStr == null) {
      throw CacheException();
    }
    return Future.value(jsonStr);
  }
}
