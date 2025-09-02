import 'dart:async';
import '../models/contact_user.dart';

class MockContactsProvider {
  Future<List<ContactUser>> fetchContacts() async {
    await Future.delayed(const Duration(milliseconds: 300));

    // يمكنك استبدال الروابط بأصول محلية مثل: assets/avatars/user1.png
    return const [
      ContactUser(
        id: 'u1',
        name: 'David Wayne',
        phone: '(+44) 50 9285 3022',
        avatarUrl: 'https://i.pravatar.cc/150?img=12',
      ),
      ContactUser(
        id: 'u2',
        name: 'Edward Mint',
        phone: '(+44) 50 9285 2090',
        avatarUrl: 'https://i.pravatar.cc/150?img=32',
      ),
      ContactUser(
        id: 'u3',
        name: 'May HG. Kang',
        phone: '(+44) 50 9285 2214',
        avatarUrl: 'https://i.pravatar.cc/150?img=47',
      ),
      ContactUser(
        id: 'u4',
        name: 'Lily Dare',
        phone: '(+44) 50 9285 5530',
        avatarUrl: 'https://i.pravatar.cc/150?img=15',
      ),
      ContactUser(
        id: 'u5',
        name: 'Dennis Dang',
        phone: '(+44) 50 9285 2225',
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
      ),
    ];
  }
}
