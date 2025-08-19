// lib/feed/data/repositories/feed_repository.dart

import 'dart:math';
import 'package:flutter/material.dart'; // For Color
import '../models/carousel_item.dart';
import '../models/campaign_item.dart';

class CampaignRepository {
  final String authToken;

  CampaignRepository({required this.authToken});

  // Simulates fetching the top carousel items from an API.
  Future<List<CarouselItem>> getCarouselItems() async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate latency
    return [
      CarouselItem(
        title: 'Project Alpha',
        description: 'A revolutionary new way to\nmanage your daily tasks.',
        imageUrl:
            'https://static.vecteezy.com/system/resources/thumbnails/034/630/930/small_2x/elegant-decorative-vases-and-planters-with-succulents-and-other-plants-on-transparent-background-interior-accessories-cut-out-home-decor-front-view-ai-generated-png.png',
        backgroundColor: Colors.amber,
      ),
      CarouselItem(
        title: 'Creative Hub',
        description:
            'Connect with artists and creators\nfrom around the world.',
        imageUrl:
            'https://images.squarespace-cdn.com/content/v1/64370d26da28bc38144ca6e4/1682645870375-GUGT050JBKU3S7JL9G99/5.png',
        backgroundColor: Colors.lightBlue.shade200,
      ),
      CarouselItem(
        title: 'Eco-Friendly Tech',
        description: 'Sustainable gadgets that help\nprotect our planet.',
        imageUrl:
            'https://images.squarespace-cdn.com/content/v1/64370d26da28bc38144ca6e4/1682645870375-GUGT050JBKU3S7JL9G99/5.png',
        backgroundColor: Colors.teal.shade200,
      ),
    ];
  }

  // Simulates fetching the main feed items from an API.
  Future<List<FeedItem>> getFeedItems({
    String? campaignFilter,
    String? likeSortOrder,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate latency

    List<FeedItem> items = List.generate(10, (index) {
      return FeedItem(
        id: index,
        imageUrls: [
          'https://images.squarespace-cdn.com/content/v1/64370d26da28bc38144ca6e4/1682645870375-GUGT050JBKU3S7JL9G99/5.png',
          'https://picsum.photos/id/${300 + index}/400/400',
        ],
        title: 'Campaign Title #${index + 1}',
        description: 'This is a compelling description for item ${index + 1}.',
        likeCount: 10 + Random().nextInt(500),
        pledgeCount: 100 + Random().nextInt(900),
        pledgeGoal: 1000,
        commentCount: 5 + Random().nextInt(100),
        vendorName: 'Vendor ${index % 3 + 1}',
        vendorAvatarUrl: 'https://i.pravatar.cc/150?u=vendor${index % 3 + 1}',
        campaignEndDate: DateTime.now().add(
          Duration(days: 5 + Random().nextInt(25)),
        ),
        postedDate: DateTime.now().subtract(
          Duration(days: 1 + Random().nextInt(5)),
        ),
      );
    });

    // --- Apply filtering and sorting logic ---
    if (likeSortOrder == 'high-low') {
      items.sort((a, b) => b.likeCount.compareTo(a.likeCount));
    } else if (likeSortOrder == 'low-high') {
      items.sort((a, b) => a.likeCount.compareTo(b.likeCount));
    }

    // Add campaign filter logic here if needed.

    return items;
  }
}
