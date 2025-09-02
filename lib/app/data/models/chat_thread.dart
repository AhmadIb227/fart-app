class ChatThread {
  final String id;
  final String name;
  final String lastMessage;
  final DateTime lastTime;
  final int unreadCount;
  final String? avatarPath; // path أو url (اختياري)

  const ChatThread({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.lastTime,
    this.unreadCount = 0,
    this.avatarPath,
  });
}
