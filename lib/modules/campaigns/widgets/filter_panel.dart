import 'package:flutter/material.dart';

class FilterPanel extends StatefulWidget {
  final String? initialCampaignFilter;
  final String? initialLikeSortOrder;

  const FilterPanel({
    super.key,
    this.initialCampaignFilter,
    this.initialLikeSortOrder,
  });

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  String? _selectedCampaign;
  String? _selectedSort;

  final List<String> _campaignFilters = [
    'New Launches',
    'Closing Soon',
    'Expiring Soon',
  ];
  final List<String> _likeSortOrders = ['high-low', 'low-high'];

  @override
  void initState() {
    super.initState();
    _selectedCampaign = widget.initialCampaignFilter;
    _selectedSort = widget.initialLikeSortOrder;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          Text(
            'Filter By',
            style: TextStyle(
              fontFamily: 'FlockFont',
              fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
            ),
          ),
          const SizedBox(height: 18),
          Text('Categories', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 10),
          _buildCategoryList(),
          const SizedBox(height: 28),
          Text('Campaigns', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            children: _campaignFilters.map((filter) {
              return ChoiceChip(
                label: Text(filter),
                selected: _selectedCampaign == filter,
                onSelected: (selected) {
                  setState(() {
                    _selectedCampaign = selected ? filter : null;
                  });
                },
                selectedColor: Colors.black,
                labelStyle: TextStyle(
                  color: _selectedCampaign == filter
                      ? Colors.white
                      : Colors.black,
                ),
                backgroundColor: Theme.of(context).primaryColor,
                showCheckmark: false,
              );
            }).toList(),
          ),
          const SizedBox(height: 28),
          Text('Sort by Likes', style: Theme.of(context).textTheme.titleSmall),
          ..._likeSortOrders.map((order) {
            return RadioListTile<String>(
              title: Text(order == 'high-low' ? 'High to Low' : 'Low to High'),
              value: order,
              groupValue: _selectedSort,
              onChanged: (value) {
                setState(() {
                  _selectedSort = value;
                });
              },
              activeColor: Colors.black,
            );
          }).toList(),
          const SizedBox(height: 36),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedCampaign = null;
                      _selectedSort = null;
                    });
                  },
                  child: const Text('Clear Filters'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'campaign': _selectedCampaign,
                      'sort': _selectedSort,
                    });
                  },
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    final categories = [
      {'icon': Icons.lightbulb_outline, 'name': 'Tech'},
      {'icon': Icons.brush, 'name': 'Art'},
      {'icon': Icons.music_note, 'name': 'Music'},
      {'icon': Icons.movie_creation_outlined, 'name': 'Film'},
      {'icon': Icons.games_outlined, 'name': 'Games'},
      {'icon': Icons.book_outlined, 'name': 'Books'},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(
                    categories[index]['icon'] as IconData,
                    color: Color(0xFF232122),
                    size: 30,
                  ),
                ),
                const SizedBox(height: 8),
                Text(categories[index]['name'] as String),
              ],
            ),
          );
        },
      ),
    );
  }
}
