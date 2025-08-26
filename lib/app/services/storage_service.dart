import 'package:get_storage/get_storage.dart';

class StorageService {
  static final GetStorage _box = GetStorage('app');

  static Future<void> init() async {
    await GetStorage.init('app');
  }

  static String? getString(String key) => _box.read<String>(key);
  static Future<void> setString(String key, String value) =>
      _box.write(key, value);

  static const String kAvatarPath = 'avatar_path';
  static const String kUserName = 'user_name';
}
