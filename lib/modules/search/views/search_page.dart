// views/search_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/search_viewmodel.dart';
import '../widgets/chip_row.dart';
import '../widgets/product_grid.dart';
import '../widgets/sort_filter_buttons.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // ✨ CHANGED: We now create and manage the controller ourselves.
  late final TextEditingController _searchController;

  // We still need a FocusNode to pass to RawAutocomplete
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchViewModel = context.watch<SearchViewModel>();

    return PopScope(
      canPop: !searchViewModel.isSearchResultsShown,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        context.read<SearchViewModel>().clearSearch();
      },
      child: Scaffold(
        appBar: AppBar(
          // ✨ CHANGED: Switched to RawAutocomplete for more control
          title: RawAutocomplete<String>(
            textEditingController: _searchController, // Pass our own controller
            focusNode: _focusNode, // Pass our own focus node
            optionsBuilder: (TextEditingValue textEditingValue) {
              searchViewModel.onSearchChanged(textEditingValue.text);
              return searchViewModel.suggestions;
            },
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
                  // This builder now uses the controller we created (_searchController)
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: 'Search for products...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: textEditingController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                textEditingController.clear();
                                searchViewModel.clearSearch();
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.zero,
                    ),
                    onSubmitted: (query) {
                      onFieldSubmitted(); // Important to call this from the builder
                      FocusManager.instance.primaryFocus?.unfocus();
                      searchViewModel.performSearch(query);
                    },
                  );
                },
            onSelected: (String selection) {
              FocusManager.instance.primaryFocus?.unfocus();
              searchViewModel.performSearch(selection);
            },
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4.0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 32,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: options.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final String option = options.elementAt(index);
                        return ListTile(
                          title: Text(option),
                          onTap: () {
                            onSelected(option);
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: searchViewModel.isSearchResultsShown
            ? _buildResultsView(searchViewModel)
            : _buildInitialView(searchViewModel),
      ),
    );
  }

  Widget _buildInitialView(SearchViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChipRow(
            title: 'Last Searched',
            items: viewModel.lastSearched,
            onChipTap: (item) {
              _handleChipTap(item, viewModel);
            },
          ),
          ChipRow(
            title: 'Trending Items',
            items: viewModel.trendingItems,
            onChipTap: (item) {
              _handleChipTap(item, viewModel);
            },
          ),
        ],
      ),
    );
  }

  // ✨ CHANGED: This method is now much simpler.
  void _handleChipTap(String item, SearchViewModel viewModel) {
    // We can directly access the controller we own. No GlobalKey needed!
    _searchController.text = item;
    _searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: _searchController.text.length),
    );
    FocusManager.instance.primaryFocus?.unfocus();
    viewModel.performSearch(item);
  }

  Widget _buildResultsView(SearchViewModel viewModel) {
    return Column(
      children: [
        const SortFilterButtons(),
        Expanded(
          child: Consumer<SearchViewModel>(
            builder: (context, vm, child) {
              if (vm.state == SearchState.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (vm.state == SearchState.error) {
                return const Center(child: Text('Something went wrong!'));
              }
              if (vm.searchResults.isEmpty) {
                return const Center(child: Text('No results found.'));
              }
              return ProductGrid(products: vm.searchResults);
            },
          ),
        ),
      ],
    );
  }
}
