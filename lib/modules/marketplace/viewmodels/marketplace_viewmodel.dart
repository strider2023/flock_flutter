// lib/marketplace/viewmodels/marketplace_viewmodel.dart

import 'package:flutter/foundation.dart';

import '../models/marketplace_feed_model.dart';
import '../repositories/marketplace_repository.dart';

class MarketplaceViewModel extends ChangeNotifier {
  final MarketplaceRepository _repository;

  MarketplaceViewModel({required MarketplaceRepository repository})
    : _repository = repository {
    fetchMarketplaceFeed();
  }

  // --- STATE ---
  bool _isLoading = true;
  List<FeedSection> _feedItems = [];

  // --- GETTERS --- (The View will listen to these)
  bool get isLoading => _isLoading;
  List<FeedSection> get feedItems => _feedItems;

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
}
