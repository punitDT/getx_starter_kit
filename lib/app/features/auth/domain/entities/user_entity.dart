class UserEntity {
  const UserEntity({required this.id, required this.name, required this.email, this.avatarUrl});

  final String id;
  final String name;
  final String email;
  final String? avatarUrl;

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id']?.toString() ?? 'demo-user',
      name: json['name']?.toString() ?? 'Demo User',
      email: json['email']?.toString() ?? 'demo@example.com',
      avatarUrl: json['avatarUrl']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'avatarUrl': avatarUrl,
      };
}
