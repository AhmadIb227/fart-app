abstract class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const profileSetup = '/profile-setup';
  static const home = '/home';
  static const pinSetup = '/pin-setup';
  static const biometricSetup = '/biometric-setup';

  // جديد: قائمة المحادثات
  static const chats = '/chats';
  static const addFriend = '/add-friend';
  static const createGroup = '/create-group';
}

// lib/app/routes/app_routes.dart

abstract class Routes {
  Routes._();
  static const chats = '/chats';
  static const createGroup = '/create-group';
  static const conversation = '/conversation';
}
