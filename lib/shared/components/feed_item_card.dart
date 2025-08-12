import 'package:flock_flutter/models/feed_item.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/icon_park_outline.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:iconify_flutter/icons/majesticons.dart';

class FeedCard extends StatefulWidget {
  final FeedItem item;
  const FeedCard({super.key, required this.item});

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 0.5,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 12),
          _buildImageCarousel(),
          const SizedBox(height: 12),
          _buildInteractionBar(),
          const SizedBox(height: 12),
          _buildContentSection(),
          const SizedBox(height: 8),
          _buildDateStamp(),
        ],
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
                color: Colors.black,
                fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the image carousel with rounded corners and an overlay chip.
  Widget _buildImageCarousel() {
    final daysPending = widget.item.campaignEndDate
        .difference(DateTime.now())
        .inDays;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 200,
              viewportFraction: 1.0, // Full width images
              autoPlay: false,
            ),
            items: widget.item.imageUrls.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[200],
                      child: const Center(child: Icon(Icons.error)),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Chip(
            shape: const StadiumBorder(),
            avatar: const Icon(
              Icons.rocket_launch,
              size: 16,
              color: Colors.white,
            ),
            label: Text(
              '$daysPending days to go',
              style: TextStyle(
                color: Colors.white,
                fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
              ),
            ),
            backgroundColor: Colors.black45,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
              icon: IconParkOutline.like,
              label: '${widget.item.likeCount}',
            ),
            const SizedBox(width: 16),
            _buildInteractionButton(
              icon: Uil.comment_dots,
              label: '${widget.item.commentCount}',
            ),
            const SizedBox(width: 16),
            _buildInteractionButton(icon: Majesticons.share, label: ''),
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
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                ),
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
          Text(
            label,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}
