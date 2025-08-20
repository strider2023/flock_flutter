// lib/marketplace/viewmodels/marketplace_viewmodel.dart

import 'package:flutter/foundation.dart';

import '../models/marketplace_feed_model.dart';
import '../repositories/marketplace_repository.dart';

class MarketplaceViewModel extends ChangeNotifier {
  final MarketplaceRepository _repository;

  MarketplaceViewModel({required MarketplaceRepository repository})
    : _repository = repository {
    fetchMarketplaceData();
  }

  // --- STATE ---
  bool _isLoading = true;
  List<FeedSection> _feedItems = [];
  int _activeCampaignsCount = 0;

  // --- GETTERS --- (The View will listen to these)
  bool get isLoading => _isLoading;
  List<FeedSection> get feedItems => _feedItems;
  int get activeCampaignsCount => _activeCampaignsCount;

  // --- PUBLIC METHODS --- (The View will call these)
  Future<void> fetchMarketplaceFeed() async {
    _isLoading = true;
    notifyListeners(); // Notify UI that we are loading

    try {
      _feedItems = await _repository.getMarketplaceFeed();
    } catch (e) {
      // In a real app, handle errors properly (e.g., show a message)
      debugPrint("Error fetching feed: $e");
    }

    _isLoading = false;
    notifyListeners(); // Notify UI that data is ready or an error occurred
  }

  Future<void> fetchMarketplaceData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Fetch both sets of data in parallel
      final results = await Future.wait([
        _repository.getMarketplaceFeed(),
        _repository.getActiveCampaignsCount(),
      ]);
      _feedItems = results[0] as List<FeedSection>;
      _activeCampaignsCount = results[1] as int;
    } catch (e) {
      debugPrint("Error fetching marketplace data: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
