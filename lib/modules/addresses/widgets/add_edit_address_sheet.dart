// lib/modules/addresses/widgets/add_edit_address_sheet.dart

import 'package:flutter/material.dart';
import '../models/address_model.dart';

class AddEditAddressSheet extends StatefulWidget {
  final Function(AddressModel) onSave;

  const AddEditAddressSheet({super.key, required this.onSave});

  @override
  State<AddEditAddressSheet> createState() => _AddEditAddressSheetState();
}

class _AddEditAddressSheetState extends State<AddEditAddressSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _instructionsController = TextEditingController();

  String? _selectedState;
  AddressType _selectedType = AddressType.home;

  final List<String> _indianStates = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newAddress = AddressModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
        recipientName: _nameController.text,
        addressDetails: _addressController.text,
        pincode: _pincodeController.text,
        state: _selectedState!,
        type: _selectedType,
        instructions: _instructionsController.text.isNotEmpty
            ? _instructionsController.text
            : null,
      );
      widget.onSave(newAddress);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevents dismissing by swiping
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          24,
          24,
          MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add New Address',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Recipient Name',
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address Details (House No, Street, etc.)',
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter address details' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _pincodeController,
                  decoration: const InputDecoration(labelText: 'Pincode'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a pincode' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedState,
                  hint: const Text('Select State'),
                  items: _indianStates.map((state) {
                    return DropdownMenuItem(value: state, child: Text(state));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedState = value),
                  validator: (value) =>
                      value == null ? 'Please select a state' : null,
                ),
                const SizedBox(height: 24),
                Text(
                  'Address Type',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  children: AddressType.values.map((type) {
                    return ChoiceChip(
                      label: Text(
                        type.toString().split('.').last.toUpperCase(),
                      ),
                      selected: _selectedType == type,
                      onSelected: (selected) {
                        if (selected) setState(() => _selectedType = type);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _instructionsController,
                  decoration: const InputDecoration(
                    labelText: 'Delivery Instructions (Optional)',
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pop(), // Explicit close button
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Save Address'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
