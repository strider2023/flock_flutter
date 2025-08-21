import 'package:flutter/foundation.dart';
import '../models/category_model.dart';
import '../repositories/category_repository.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository _repository;

  CategoryViewModel({required CategoryRepository repository})
    : _repository = repository {
    fetchCategories();
  }

  bool _isLoading = true;
  List<CategoryModel> _categories = [];

  bool get isLoading => _isLoading;
  List<CategoryModel> get categories => _categories;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();
    try {
      _categories = await _repository.getCategories();
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    }
    _isLoading = false;
    notifyListeners();
  }
}
