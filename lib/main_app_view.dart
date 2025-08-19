import 'package:flock_flutter/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/viewmodels/navigation_viewmodel.dart';
import 'modules/auth/viewmodels/auth_viewmodel.dart';
import 'modules/campaigns/repositories/campaign_repository.dart';
import 'modules/campaigns/viewmodels/campaign_viewmodel.dart';
import 'modules/favorites/repositories/favorites_repository.dart';
import 'modules/favorites/viewmodels/favorites_viewmodel.dart';
import 'modules/marketplace/repositories/marketplace_repository.dart';
import 'modules/marketplace/viewmodels/marketplace_viewmodel.dart';
import 'modules/profile/repositories/profile_repository.dart';
import 'modules/profile/viewmodels/profile_viewmodel.dart';
import 'modules/search/repositories/search_repository.dart';
import 'modules/search/viewmodels/search_viewmodel.dart';

class MainAppView extends StatelessWidget {
  final String token;
  const MainAppView({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    // This MultiProvider is only created for authenticated users.
    return MultiProvider(
      providers: [
        Provider<MarketplaceRepository>(
          create: (_) => MarketplaceRepository(authToken: token),
        ),
        Provider<SearchRepository>(
          create: (_) => SearchRepository(authToken: token),
        ),
        Provider<CampaignRepository>(
          create: (_) => CampaignRepository(authToken: token),
        ),
        Provider<ProfileRepository>(
          create: (_) => ProfileRepository(authToken: token),
        ),
        Provider<FavoritesRepository>(
          create: (_) => FavoritesRepository(authToken: token),
        ),

        ChangeNotifierProvider<NavigationViewModel>(
          create: (_) => NavigationViewModel(),
        ),
        ChangeNotifierProvider<MarketplaceViewModel>(
          create: (context) => MarketplaceViewModel(
            repository: context.read<MarketplaceRepository>(),
          ),
        ),
        ChangeNotifierProvider<SearchViewModel>(
          create: (context) =>
              SearchViewModel(repository: context.read<SearchRepository>()),
        ),
        ChangeNotifierProvider<FeedViewModel>(
          create: (context) =>
              FeedViewModel(repository: context.read<CampaignRepository>()),
        ),
        ChangeNotifierProvider<ProfileViewModel>(
          create: (context) => ProfileViewModel(
            repository: context.read<ProfileRepository>(),
            authViewModel: context.read<AuthViewModel>(),
          ),
        ),
        ChangeNotifierProvider<FavoritesViewModel>(
          create: (context) => FavoritesViewModel(
            repository: context.read<FavoritesRepository>(),
          ),
        ),
      ],
      // This child could be a Scaffold with a BottomNavigationBar
      // that switches between your main pages.
      child: HomePage(), // Replace with your actual home UI
    );
  }
}
