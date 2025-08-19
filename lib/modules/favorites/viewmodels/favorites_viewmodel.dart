// lib/modules/favorites/viewmodels/favorites_viewmodel.dart

import 'package:flutter/foundation.dart';
import '../models/favorite_item_model.dart';
import '../repositories/favorites_repository.dart';

enum FavoritesTab { favorites, pledges }

class FavoritesViewModel extends ChangeNotifier {
  final FavoritesRepository _repository;

  FavoritesViewModel({required FavoritesRepository repository})
    : _repository = repository {
    // Initially load the data for the default tab
    fetchItemsForCurrentTab();
  }

  // --- STATE ---
  bool _isLoading = true;
  FavoritesTab _selectedTab = FavoritesTab.favorites;
  List<FavoriteItemModel> _items = [];

  // --- GETTERS ---
  bool get isLoading => _isLoading;
  FavoritesTab get selectedTab => _selectedTab;
  List<FavoriteItemModel> get items => _items;

  // --- PUBLIC METHODS ---
  void selectTab(FavoritesTab tab) {
    if (_selectedTab == tab)
      return; // Do nothing if the tab is already selected
    _selectedTab = tab;
    // Fetch the data for the newly selected tab
    fetchItemsForCurrentTab();
  }

  Future<void> fetchItemsForCurrentTab() async {
    _isLoading = true;
    notifyListeners();

    try {
      if (_selectedTab == FavoritesTab.favorites) {
        _items = await _repository.getFavoriteItems();
      } else {
        _items = await _repository.getPledgedItems();
      }
    } catch (e) {
      debugPrint("Error fetching items: $e");
      _items = []; // Clear items on error
    }

    _isLoading = false;
    notifyListeners();
  }
}
