// lib/modules/addresses/viewmodels/address_viewmodel.dart

import 'package:flutter/foundation.dart';
import '../models/address_model.dart';
import '../repositories/address_repository.dart';

class AddressViewModel extends ChangeNotifier {
  final AddressRepository _repository;

  AddressViewModel({required AddressRepository repository})
    : _repository = repository {
    fetchAddresses();
  }

  bool _isLoading = true;
  List<AddressModel> _addresses = [];

  bool get isLoading => _isLoading;
  List<AddressModel> get addresses => _addresses;

  Future<void> fetchAddresses() async {
    _isLoading = true;
    notifyListeners();
    try {
      _addresses = await _repository.getAddresses();
    } catch (e) {
      debugPrint("Error fetching addresses: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addAddress(AddressModel address) async {
    await _repository.addAddress(address);
    fetchAddresses(); // Refresh the list
  }

  Future<void> deleteAddress(String id) async {
    await _repository.deleteAddress(id);
    fetchAddresses(); // Refresh the list
  }
}
