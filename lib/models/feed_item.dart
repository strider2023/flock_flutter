import 'dart:convert';

class FeedItem {
  final int id;
  final String title;
  final String description;
  final List<String> imageUrls;
  final int pledgeCount;
  final int pledgeGoal;
  final int likeCount;
  final int commentCount;
  final String vendorName;
  final String vendorAvatarUrl;
  final DateTime campaignEndDate;
  final DateTime postedDate;

  FeedItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.pledgeCount,
    required this.pledgeGoal,
    required this.likeCount,
    required this.commentCount,
    required this.vendorName,
    required this.vendorAvatarUrl,
    required this.campaignEndDate,
    required this.postedDate,
  });

  // Updated for new fields
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      // Storing list as a JSON string for simple DB storage
      'imageUrls': jsonEncode(imageUrls),
      'pledgeCount': pledgeCount,
      'pledgeGoal': pledgeGoal,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'vendorName': vendorName,
      'vendorAvatarUrl': vendorAvatarUrl,
      'campaignEndDate': campaignEndDate.toIso8601String(),
      'postedDate': postedDate.toIso8601String(),
    };
  }

  // Updated for new fields
  factory FeedItem.fromMap(Map<String, dynamic> map) {
    return FeedItem(
      id: map['id'] is int ? map['id'] : int.parse(map['id']),
      title: map['title'],
      description: map['description'],
      imageUrls: map['imageUrls'] is String
          ? List<String>.from(jsonDecode(map['imageUrls']))
          : List<String>.from(map['imageUrls']),
      pledgeCount: map['pledgeCount'],
      pledgeGoal: map['pledgeGoal'],
      likeCount: map['likeCount'] ?? 0,
      commentCount: map['commentCount'] ?? 0,
      vendorName: map['vendorName'],
      vendorAvatarUrl: map['vendorAvatarUrl'],
      campaignEndDate: DateTime.parse(map['campaignEndDate']),
      postedDate: DateTime.parse(map['postedDate']),
    );
  }
}
