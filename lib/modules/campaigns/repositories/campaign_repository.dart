// lib/feed/data/repositories/feed_repository.dart

import 'dart:math';
import 'package:flutter/material.dart'; // For Color
import '../../../common/models/product_model.dart';
import '../models/campaign_detail_model.dart';
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
          'https://blog-static.userpilot.com/blog/wp-content/uploads/2024/07/16-best-product-marketing-campaigns-to-inspire-your-own_e14b5a501710a24ed1169705a0e91905_2000.png',
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

  Future<CampaignDetailModel> getCampaignDetails(int campaignId) async {
    await Future.delayed(const Duration(milliseconds: 600));
    // In a real app, you would make an API call with the campaignId.
    // Here we return dummy data.
    return CampaignDetailModel(
      id: campaignId,
      mediaUrls: [
        'https://blog-static.userpilot.com/blog/wp-content/uploads/2024/07/16-best-product-marketing-campaigns-to-inspire-your-own_e14b5a501710a24ed1169705a0e91905_2000.png',
        'https://picsum.photos/id/101/800/600',
        'https://picsum.photos/id/102/800/600',
      ],
      vendorName: 'Vendor ${campaignId % 3 + 1}',
      vendorAvatarUrl:
          'https://i.pravatar.cc/150?u=vendor${campaignId % 3 + 1}',
      vendorDetails: 'Passionate creator of fine goods.',
      pledgeCount: 150 + (campaignId * 50),
      pledgeGoal: 1000,
      likeCount: 200 + (campaignId * 20),
      commentCount: 45 + (campaignId * 5),
      title: 'Detailed Campaign Title #$campaignId',
      campaignEndDate: DateTime.now().add(const Duration(days: 25)),
      totalFundAmount: 500000,
      description:
          'This is the full, detailed description of the campaign, explaining its goals, vision, and the impact of your funding. It is longer and more comprehensive than the summary shown on the feed card.',
      associatedProducts: _getMockProducts(3, offset: campaignId * 3),
    );
  }

  // Helper to generate mock products for the details page
  List<ProductModel> _getMockProducts(int count, {int offset = 0}) {
    return List.generate(count, (i) {
      final index = i + offset;
      return ProductModel(
        imageUrl: 'https://picsum.photos/id/${200 + index}/400/400',
        vendorName: 'Associated Vendor',
        category: 'Merchandise',
        itemName: 'Exclusive Product #${index + 1}',
        purchasePrice: 1999.00,
        rating: 4.5,
        ratingCount: 50 + index,
      );
    });
  }
}
