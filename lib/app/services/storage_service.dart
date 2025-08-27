import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  final GetStorage _box = GetStorage();

  bool isFirstLaunch() {
    return _box.read('seenOnboarding') ?? true;
  }

  void setOnboardingSeen() {
    _box.write('seenOnboarding', false);
  }
}
