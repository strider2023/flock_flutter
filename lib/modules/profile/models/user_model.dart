class UserModel {
  final String name;
  final String phone;
  final String email;
  final String avatarUrl;
  final DateTime? dateOfBirth; // ✨ ADDED
  final String? gender; // ✨ ADDED

  UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.avatarUrl,
    this.dateOfBirth,
    this.gender,
  });
}
