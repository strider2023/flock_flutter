import 'package:flutter/material.dart';
import '../models/category_model.dart';

class CategoryRepository {
  final String authToken;
  CategoryRepository({required this.authToken});

  Future<List<CategoryModel>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      CategoryModel(id: 'tech', name: 'Tech', icon: Icons.lightbulb_outline),
      CategoryModel(id: 'art', name: 'Art', icon: Icons.brush),
      CategoryModel(id: 'music', name: 'Music', icon: Icons.music_note),
      CategoryModel(
        id: 'film',
        name: 'Film',
        icon: Icons.movie_creation_outlined,
      ),
      CategoryModel(id: 'games', name: 'Games', icon: Icons.games_outlined),
      CategoryModel(id: 'books', name: 'Books', icon: Icons.book_outlined),
    ];
  }
}
