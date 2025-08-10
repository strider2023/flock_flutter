class FeedItem {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final int pledgeCount;
  final int pledgeGoal;
  final int likeCount;
  final int commentCount;

  FeedItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.pledgeCount,
    required this.pledgeGoal,
    required this.likeCount,
    required this.commentCount,
  });

  // For SQLite serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'pledgeCount': pledgeCount,
      'pledgeGoal': pledgeGoal,
      'likeCount': likeCount,
      'commentCount': commentCount,
    };
  }

  // For SQLite and GraphQL deserialization
  factory FeedItem.fromMap(Map<String, dynamic> map) {
    return FeedItem(
      id: map['id'] is int ? map['id'] : int.parse(map['id']),
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      pledgeCount: map['pledgeCount'],
      pledgeGoal: map['pledgeGoal'],
      likeCount: map['likeCount'] ?? 0,
      commentCount: map['commentCount'] ?? 0,
    );
  }
}
