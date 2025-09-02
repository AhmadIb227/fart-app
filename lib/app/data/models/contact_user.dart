import 'package:equatable/equatable.dart';

class ContactUser extends Equatable {
  final String id;
  final String name;
  final String phone;

  /// رابط صورة الأفاتار (شبكي أو من الأصول). يمكن أن تكون null
  /// مثال شبكة: https://i.pravatar.cc/150?img=3
  /// مثال أصول: assets/avatars/user1.png
  final String? avatarUrl;

  const ContactUser({
    required this.id,
    required this.name,
    required this.phone,
    this.avatarUrl,
  });

  ContactUser copyWith({
    String? id,
    String? name,
    String? phone,
    String? avatarUrl,
  }) {
    return ContactUser(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  factory ContactUser.fromJson(Map<String, dynamic> json) => ContactUser(
    id: json['id'] as String,
    name: json['name'] as String,
    phone: json['phone'] as String,
    avatarUrl: json['avatarUrl'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'avatarUrl': avatarUrl,
  };

  /// نساوي العناصر حسب الـ id حتى يعمل الـ Set<> والاختيار المؤقت بدون مشاكل
  @override
  List<Object?> get props => [id];
}
