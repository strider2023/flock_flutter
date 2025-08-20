// viewmodels/search_viewmodel.dart

import 'dart:async';

import '../../../common/models/product_model.dart';
import '../repositories/search_repository.dart';
import 'package:flutter/material.dart';

enum SearchState { initial, loading, loaded, error }

class SearchViewModel extends ChangeNotifier {
  final SearchRepository _repository;
  Timer? _debounce;

  SearchViewModel({required SearchRepository repository})
    : _repository = repository {
    _fetchInitialData();
  }

  // --- STATE ---
  SearchState _state = SearchState.initial;
  List<ProductModel> _searchResults = [];
  List<String> _lastSearched = [];
  List<String> _trendingItems = [];
  List<String> _suggestions = []; // ✨ NEW: State for suggestions
  bool _isSearchResultsShown = false;

  // --- GETTERS ---
  SearchState get state => _state;
  List<ProductModel> get searchResults => _searchResults;
  List<String> get lastSearched => _lastSearched;
  List<String> get trendingItems => _trendingItems;
  List<String> get suggestions => _suggestions; // ✨ NEW: Getter for suggestions
  bool get isSearchResultsShown => _isSearchResultsShown;

  Future<void> _fetchInitialData() async {
    _lastSearched = await _repository.getLastSearched();
    _trendingItems = await _repository.getTrendingItems();
    notifyListeners(); // Notify UI to update with initial chip data
  }

  // ✨ UPDATED: Debounced method now fetches suggestions
  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.length > 2) {
        _suggestions = await _repository.getSearchSuggestions(query);
      } else {
        _suggestions.clear();
      }
      notifyListeners();
    });
  }

  Future<void> performSearch(String query) async {
    if (query.isEmpty) return;

    _suggestions.clear(); // Hide suggestions when a search is performed
    _state = SearchState.loading;
    _isSearchResultsShown = true;
    notifyListeners();

    try {
      _searchResults = await _repository.searchProducts(query);
      _state = SearchState.loaded;
    } catch (e) {
      _state = SearchState.error;
    }
    notifyListeners();
  }

  void clearSearch() {
    _suggestions.clear(); // Hide suggestions on clear
    _isSearchResultsShown = false;
    _searchResults.clear();
    _state = SearchState.initial;
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
