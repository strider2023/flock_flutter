import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../profile/models/edit_profile_model.dart';
import '../repositories/profile_repository.dart';

class EditProfileViewModel extends ChangeNotifier {
  final ProfileRepository _repository;

  EditProfileViewModel({required ProfileRepository repository})
    : _repository = repository {
    _fetchUserData();
  }

  // --- STATE ---
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  DateTime? _dateOfBirth;
  String? _gender;
  XFile? _pickedImage;
  bool _isLoading = false;
  String? _avatarUrl;

  // --- GETTERS ---
  DateTime? get dateOfBirth => _dateOfBirth;
  String? get gender => _gender;
  XFile? get pickedImage => _pickedImage;
  bool get isLoading => _isLoading;
  String? get avatarUrl => _avatarUrl;

  // --- DATA FETCHING ---
  Future<void> _fetchUserData() async {
    _isLoading = true;
    notifyListeners();
    try {
      final user = await _repository.getEditableUserProfile();
      // Populate controllers and state with fetched data
      nameController.text = user.name;
      emailController.text = user.email;
      phoneController.text = user.phone;
      _dateOfBirth = user.dateOfBirth;
      _gender = user.gender;
      _avatarUrl = user.avatarUrl;
    } catch (e) {
      debugPrint("Error fetching user data for editing: $e");
      // Handle error state if needed
    }
    _isLoading = false;
    notifyListeners();
  }

  // --- PUBLIC METHODS ---
  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    _pickedImage = await picker.pickImage(source: source);
    notifyListeners();
  }

  void setDateOfBirth(DateTime? date) {
    _dateOfBirth = date;
    notifyListeners();
  }

  void setGender(String? gender) {
    _gender = gender;
    notifyListeners();
  }

  Future<bool> saveProfile() async {
    _isLoading = true;
    notifyListeners();

    // Create an EditProfileModel with the updated data
    final profileData = EditProfileModel(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      dateOfBirth: _dateOfBirth,
      gender: _gender,
    );

    try {
      await _repository.updateUserProfile(profileData);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("Error saving profile: $e");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
