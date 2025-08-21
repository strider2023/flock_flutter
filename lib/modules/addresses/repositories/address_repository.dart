// lib/modules/addresses/repositories/address_repository.dart

import '../models/address_model.dart';

class AddressRepository {
  final String authToken;
  AddressRepository({required this.authToken});

  // Mock database
  final List<AddressModel> _addresses = [
    AddressModel(
      id: '1',
      recipientName: 'Jane Doe',
      addressDetails: '123, Sunshine Apartments, Green Valley',
      pincode: '411028',
      state: 'Maharashtra',
      type: AddressType.home,
    ),
  ];

  Future<List<AddressModel>> getAddresses() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _addresses;
  }

  Future<void> addAddress(AddressModel address) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _addresses.add(address);
  }

  Future<void> deleteAddress(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _addresses.removeWhere((addr) => addr.id == id);
  }
}
