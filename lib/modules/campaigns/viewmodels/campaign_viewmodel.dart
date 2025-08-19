// lib/feed/viewmodels/feed_viewmodel.dart

import 'package:flutter/foundation.dart';

import '../models/carousel_item.dart';
import '../models/campaign_item.dart';
import '../repositories/campaign_repository.dart';

class FeedViewModel extends ChangeNotifier {
  final CampaignRepository _repository;

  FeedViewModel({required CampaignRepository repository})
    : _repository = repository {
    // Fetch initial data when the ViewModel is created
    fetchFeedData();
  }

  // --- STATE ---
  bool _isLoading = true;
  List<CarouselItem> _carouselItems = [];
  List<FeedItem> _feedItems = [];
  String? _activeCampaignFilter;
  String? _activeLikeSortOrder;

  // --- GETTERS ---
  bool get isLoading => _isLoading;
  List<CarouselItem> get carouselItems => _carouselItems;
  List<FeedItem> get feedItems => _feedItems;
  String? get activeCampaignFilter => _activeCampaignFilter;
  String? get activeLikeSortOrder => _activeLikeSortOrder;

  // --- PUBLIC METHODS ---
  Future<void> fetchFeedData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Fetch both sets of data in parallel
      final results = await Future.wait([
        _repository.getCarouselItems(),
        _repository.getFeedItems(
          campaignFilter: _activeCampaignFilter,
          likeSortOrder: _activeLikeSortOrder,
        ),
      ]);
      _carouselItems = results[0] as List<CarouselItem>;
      _feedItems = results[1] as List<FeedItem>;
    } catch (e) {
      debugPrint("Error fetching feed data: $e");
      // Handle error state if necessary
    }

    _isLoading = false;
    notifyListeners();
  }

  // Called by the view when the filter panel returns results
  void applyFilters(Map<String, String?> filters) {
    _activeCampaignFilter = filters['campaign'];
    _activeLikeSortOrder = filters['sort'];
    // Re-fetch the feed data with the new filters
    fetchFeedData();
  }
}
