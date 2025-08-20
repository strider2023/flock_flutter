// lib/modules/favorites/views/favorites_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/home_header.dart';
import '../viewmodels/favorites_viewmodel.dart';
import '../widgets/item_grid_card.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the ViewModel for state changes
    final viewModel = context.watch<FavoritesViewModel>();

    return Scaffold(
      appBar: HomeHeader(
        showBackButton: true,
        actions: [],
        onActionPressed: (actionName) {},
      ),
      body: Column(
        children: [
          _buildPillTabBar(context, viewModel),
          Expanded(
            child: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildItemsGrid(viewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildPillTabBar(BuildContext context, FavoritesViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.grey.shade200
            : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Row(
        children: [
          _buildTabOption(
            context,
            viewModel,
            FavoritesTab.favorites,
            'Favorites',
          ),
          _buildTabOption(
            context,
            viewModel,
            FavoritesTab.pledges,
            'My Pledges',
          ),
        ],
      ),
    );
  }

  Widget _buildTabOption(
    BuildContext context,
    FavoritesViewModel viewModel,
    FavoritesTab tab,
    String title,
  ) {
    final bool isSelected = viewModel.selectedTab == tab;
    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<FavoritesViewModel>().selectTab(tab),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? Colors.black
                  : Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemsGrid(FavoritesViewModel viewModel) {
    if (viewModel.items.isEmpty) {
      return const Center(child: Text('No items to display.'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.8,
      ),
      itemCount: viewModel.items.length,
      itemBuilder: (context, index) {
        return ItemGridCard(item: viewModel.items[index]);
      },
    );
  }
}
