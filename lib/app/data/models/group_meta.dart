class GroupMeta {
  final String id;
  final String title;
  final int membersCount;
  final List<String> avatars; // روابط صور أو مسارات Assets (اختياري)

  const GroupMeta({
    required this.id,
    required this.title,
    required this.membersCount,
    this.avatars = const [],
  });
}
