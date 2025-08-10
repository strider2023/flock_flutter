import 'package:flock_flutter/models/feed_item.dart';
import 'package:flutter/material.dart';

class FeedCard extends StatelessWidget {
  final FeedItem item;
  const FeedCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              item.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: Colors.grey[300],
                child: Center(
                  child: Icon(Icons.image, size: 50, color: Colors.grey[600]),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(item.title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(item.description),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pledge Count: ${item.pledgeCount} / ${item.pledgeGoal}'),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: item.pledgeCount / item.pledgeGoal,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInteractionButton(
                icon: Icons.favorite_border,
                label: '${item.likeCount}',
                onPressed: () {},
              ),
              _buildInteractionButton(
                icon: Icons.comment_outlined,
                label: '${item.commentCount}',
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined, color: Colors.black54),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.black54, size: 20),
      label: Text(label, style: const TextStyle(color: Colors.black54)),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
