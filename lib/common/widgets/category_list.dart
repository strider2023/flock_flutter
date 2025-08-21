import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/category_viewmodel.dart';

class CategoryList extends StatelessWidget {
  final Function(String categoryId) onCategorySelected;

  const CategoryList({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CategoryViewModel>();

    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: viewModel.categories.length,
        itemBuilder: (context, index) {
          final category = viewModel.categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: InkWell(
              onTap: () => onCategorySelected(category.id),
              borderRadius: BorderRadius.circular(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Icon(category.icon, size: 30),
                  ),
                  const SizedBox(height: 8),
                  Text(category.name),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
