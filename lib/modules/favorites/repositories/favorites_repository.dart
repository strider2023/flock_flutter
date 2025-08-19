// lib/modules/favorites/repositories/favorites_repository.dart

import '../models/favorite_item_model.dart';

class FavoritesRepository {
  final String authToken;
  FavoritesRepository({required this.authToken});

  // Simulates fetching the user's favorited items.
  Future<List<FavoriteItemModel>> getFavoriteItems() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.generate(8, (i) {
      return FavoriteItemModel(
        name: 'Favorited Item ${i + 1}',
        imageUrl: 'https://picsum.photos/id/${400 + i}/400/400',
      );
    });
  }

  // Simulates fetching the user's pledged items.
  Future<List<FavoriteItemModel>> getPledgedItems() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return List.generate(6, (i) {
      return FavoriteItemModel(
        name: 'Pledged Item ${i + 1}',
        imageUrl: 'https://picsum.photos/id/${500 + i}/400/400',
      );
    });
  }
}
