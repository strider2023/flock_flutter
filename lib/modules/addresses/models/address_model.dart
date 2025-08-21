// lib/modules/addresses/models/address_model.dart

enum AddressType { home, office, other }

class AddressModel {
  final String id;
  final String recipientName;
  final String addressDetails;
  final String pincode;
  final String state;
  final AddressType type;
  final String? instructions;

  AddressModel({
    required this.id,
    required this.recipientName,
    required this.addressDetails,
    required this.pincode,
    required this.state,
    required this.type,
    this.instructions,
  });
}
