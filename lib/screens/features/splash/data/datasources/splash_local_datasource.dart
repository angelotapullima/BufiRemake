




import 'package:bufi_remake/core/error/exceptions.dart';
import 'package:bufi_remake/core/sharedpreferences/storage_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SplashLocalDataSource {
  Future<String> getLastToken(); 
}

class SplashLocalDataSourceImpl extends SplashLocalDataSource {
  final SharedPreferences? sharedPreferences;

  SplashLocalDataSourceImpl({required this.sharedPreferences});
 

  @override
  Future<String> getLastToken() async {
    String? jsonStr = await StorageManager.readData('tn');
    if (jsonStr == null) {
      throw CacheException();
    }
    return Future.value(jsonStr);
  }
}
