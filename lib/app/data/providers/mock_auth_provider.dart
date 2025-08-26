import '../models/user_model.dart';

class MockAuthProvider {
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return UserModel(id: 'u1', name: 'Guest');
  }
}
