import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';

import '../models/campaign_item.dart';

class FeedCard extends StatefulWidget {
  final FeedItem item;
  final VoidCallback onTap;

  const FeedCard({super.key, required this.item, required this.onTap});

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              _buildImage(), // ✨ CHANGED: Swapped carousel for a single image
              const SizedBox(height: 12),
              _buildInteractionBar(),
              const SizedBox(height: 12),
              _buildContentSection(),
              const SizedBox(height: 8),
              _buildDateStamp(),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the top header with vendor info and follow button.
  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(widget.item.vendorAvatarUrl),
          radius: 20,
        ),
        const SizedBox(width: 10),
        Text(
          widget.item.vendorName,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Spacer(),
        SizedBox(
          child: OutlinedButton(
            onPressed: () {},
            child: Text(
              'Follow',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    final daysPending = widget.item.campaignEndDate
        .difference(DateTime.now())
        .inDays;

    return Stack(
      children: [
        // Ensure the list is not empty before accessing the first image
        if (widget.item.imageUrls.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              widget.item.imageUrls.first, // Display the first image
              height: 200,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: Colors.grey[200],
                child: const Center(child: Icon(Icons.error)),
              ),
            ),
          ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Chip(
            avatar: Icon(Icons.rocket_launch, size: 16, color: Colors.black),
            label: Text(
              '$daysPending days to go',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the bar with like/comment/share and the progress pill.
  Widget _buildInteractionBar() {
    final progress = (widget.item.pledgeCount / widget.item.pledgeGoal).clamp(
      0.0,
      1.0,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side: Like, Comment, Share
        Row(
          children: [
            _buildInteractionButton(
              icon: Ri.hand_heart_line,
              label: '${widget.item.likeCount}',
            ),
            const SizedBox(width: 16),
            _buildInteractionButton(icon: Ri.share_forward_line, label: ''),
          ],
        ),
        // Right side: Pledge progress pill
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${widget.item.pledgeCount} / ${widget.item.pledgeGoal}',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 100,
              height: 8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(value: progress),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Builds the title and expandable description section.
  Widget _buildContentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.item.title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        Text(
          widget.item.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  /// Builds the small date stamp at the bottom.
  Widget _buildDateStamp() {
    return Text(
      'Posted on ${DateFormat('d MMM').format(widget.item.postedDate)}',
      style: Theme.of(context).textTheme.bodySmall,
    );
  }

  /// Helper for creating interaction buttons.
  Widget _buildInteractionButton({
    required String icon,
    required String label,
  }) {
    return Row(
      children: [
        Iconify(icon, color: Colors.grey),
        if (label.isNotEmpty) ...[
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ],
    );
  }
}
