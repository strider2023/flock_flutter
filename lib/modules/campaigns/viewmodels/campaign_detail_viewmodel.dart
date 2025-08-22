import 'package:flutter/foundation.dart';
import '../models/campaign_detail_model.dart';
import '../repositories/campaign_repository.dart';

class CampaignDetailViewModel extends ChangeNotifier {
  final CampaignRepository _repository;
  final int _campaignId;

  CampaignDetailViewModel({
    required CampaignRepository repository,
    required int campaignId,
  }) : _repository = repository,
       _campaignId = campaignId {
    fetchCampaignDetails();
  }

  bool _isLoading = true;
  CampaignDetailModel? _campaignDetails;

  bool get isLoading => _isLoading;
  CampaignDetailModel? get campaignDetails => _campaignDetails;

  Future<void> fetchCampaignDetails() async {
    _isLoading = true;
    notifyListeners();
    try {
      _campaignDetails = await _repository.getCampaignDetails(_campaignId);
    } catch (e) {
      debugPrint("Error fetching campaign details: $e");
    }
    _isLoading = false;
    notifyListeners();
  }
}
