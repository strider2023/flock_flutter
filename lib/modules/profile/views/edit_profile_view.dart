import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../viewmodels/edit_profile_viewmodel.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EditProfileViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildAvatar(context, viewModel),
                  const SizedBox(height: 32),
                  TextField(
                    controller: viewModel.nameController,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: viewModel.emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: viewModel.phoneController,
                    decoration: const InputDecoration(labelText: 'Phone'),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  _buildDatePicker(context, viewModel),
                  const SizedBox(height: 16),
                  _buildGenderPicker(context, viewModel),
                  const SizedBox(height: 32),

                  // ✨ ADDED: The save button is now in the main view.
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: viewModel.isLoading
                          ? null
                          : () async {
                              if (await viewModel.saveProfile()) {
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              }
                            },
                      child: viewModel.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Save Changes'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildAvatar(BuildContext context, EditProfileViewModel viewModel) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: viewModel.pickedImage != null
              ? FileImage(File(viewModel.pickedImage!.path))
              : (viewModel.avatarUrl?.isNotEmpty ==
                            true // Use ?. and == true
                        ? NetworkImage(viewModel.avatarUrl!)
                        : null)
                    as ImageProvider?,
          child:
              viewModel.pickedImage == null &&
                  (viewModel.avatarUrl?.isEmpty ?? true)
              ? const Icon(Icons.person, size: 60)
              : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Theme.of(context).primaryColor,
            child: IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.black, size: 20),
              onPressed: () => _showImageSourcePicker(context, viewModel),
            ),
          ),
        ),
      ],
    );
  }

  void _showImageSourcePicker(
    BuildContext context,
    EditProfileViewModel viewModel,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Photo Library'),
              onTap: () {
                viewModel.pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () {
                viewModel.pickImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker(
    BuildContext context,
    EditProfileViewModel viewModel,
  ) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: viewModel.dateOfBirth ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          viewModel.setDateOfBirth(picked);
        }
      },
      child: InputDecorator(
        decoration: const InputDecoration(labelText: 'Date of Birth'),
        child: Text(
          viewModel.dateOfBirth != null
              ? DateFormat('d MMMM yyyy').format(viewModel.dateOfBirth!)
              : 'Not set',
        ),
      ),
    );
  }

  Widget _buildGenderPicker(
    BuildContext context,
    EditProfileViewModel viewModel,
  ) {
    return DropdownButtonFormField<String>(
      value: viewModel.gender,
      decoration: const InputDecoration(labelText: 'Gender'),
      items: ['Male', 'Female', 'Other', 'Prefer not to say'].map((
        String value,
      ) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: viewModel.setGender,
    );
  }
}
