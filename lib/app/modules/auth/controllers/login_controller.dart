import 'package:get/get.dart';
import '../../../data/providers/mock_auth_provider.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final _provider = MockAuthProvider();
  final isLoading = false.obs;

  Future<void> fakeLogin() async {
    isLoading.value = true;
    await _provider.login(email: 'a@a.com', password: '123456');
    isLoading.value = false;
    Get.toNamed(AppRoutes.profileSetup);
  }
}
