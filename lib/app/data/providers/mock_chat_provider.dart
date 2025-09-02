import 'dart:async';
import '../models/chat_thread.dart';

class MockChatProvider {
  Future<List<ChatThread>> fetchThreads() async {
    await Future.delayed(const Duration(milliseconds: 350));
    final now = DateTime.now();

    // نفس أسماء جهات الاتصال الموجودة في MockContactsProvider
    return [
      ChatThread(
        id: '1',
        name: 'David Wayne',
        lastMessage: 'Thanks a bunch! Have a great day! 😊',
        lastTime: now.subtract(const Duration(minutes: 4)),
        unreadCount: 2,
      ),
      ChatThread(
        id: '2',
        name: 'Edward Mint',
        lastMessage: 'On my way.',
        lastTime: now.subtract(const Duration(minutes: 12)),
      ),
      ChatThread(
        id: '3',
        name: 'May HG. Kang',
        lastMessage: 'Updated figma file shared.',
        lastTime: now.subtract(const Duration(hours: 1, minutes: 5)),
        unreadCount: 5,
      ),
      ChatThread(
        id: '4',
        name: 'Lily Dare',
        lastMessage: 'تمام، نشوفك بكرة',
        lastTime: now.subtract(const Duration(days: 1, hours: 2)),
      ),
      ChatThread(
        id: '5',
        name: 'Dennis Dang',
        lastMessage: 'I am good',
        lastTime: now.subtract(const Duration(days: 7, hours: 8)),
        unreadCount: 1,
      ),
    ];
  }
}
