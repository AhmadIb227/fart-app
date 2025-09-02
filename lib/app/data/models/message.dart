class Message {
  final String id;
  final String text;
  final bool isMe; // true = مرسلة مني, false = واردة
  final DateTime time;

  const Message({
    required this.id,
    required this.text,
    required this.isMe,
    required this.time,
  });
}
