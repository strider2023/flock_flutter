// lib/modules/profile/models/edit_profile_model.dart
class EditProfileModel {
  final String name;
  final String email;
  final String phone;
  final DateTime? dateOfBirth;
  final String? gender;

  EditProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    this.dateOfBirth,
    this.gender,
  });
}
