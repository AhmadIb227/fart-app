class UserModel {
  final String id;
  final String? name;
  final String? avatarPath;

  UserModel({required this.id, this.name, this.avatarPath});

  UserModel copyWith({String? name, String? avatarPath}) => UserModel(
    id: id,
    name: name ?? this.name,
    avatarPath: avatarPath ?? this.avatarPath,
  );
}
