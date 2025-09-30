class UserEntity {
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
    required this.image,
    required this.role,
    required this.banned,
    required this.banReason,
    required this.banExpires,
    required this.createdAt,
    required this.updatedAt,
  });
  final String id;
  final String name;
  final String email;
  final bool emailVerified;
  final String? image;
  final String? role;
  final bool? banned;
  final String? banReason;
  final DateTime? banExpires;
  final DateTime createdAt;
  final DateTime updatedAt;
}
