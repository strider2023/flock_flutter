// lib/modules/addresses/views/manage_addresses_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/address_viewmodel.dart';
import '../widgets/address_card.dart';
import '../widgets/add_edit_address_sheet.dart';

class ManageAddressesView extends StatelessWidget {
  const ManageAddressesView({super.key});

  void _showAddAddressSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false, // Makes the sheet non-dismissible
      enableDrag: false,
      builder: (_) => AddEditAddressSheet(
        onSave: (newAddress) {
          context.read<AddressViewModel>().addAddress(newAddress);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddressViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Addresses')),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: viewModel.addresses.length,
                itemBuilder: (context, index) {
                  final address = viewModel.addresses[index];
                  return AddressCard(
                    address: address,
                    onDelete: () => viewModel.deleteAddress(address.id),
                    onEdit: () {
                      // TODO: Implement edit functionality
                    },
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddAddressSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('Add New Address'),
      ),
    );
  }
}
