import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Make sure you have the flutter_svg package

class CampaignPromoCard extends StatelessWidget {
  final int count;
  final String headline;
  final VoidCallback onTap;

  const CampaignPromoCard({
    super.key,
    required this.count,
    required this.headline,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Card(
          color: Color(0xffea6c56),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: 140,
            child: Row(
              children: [
                // Left side: Text content
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '$count ',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                              ),
                              TextSpan(
                                text: headline,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text('Active funding campaigns'),
                      ],
                    ),
                  ),
                ),
                // Right side: SVG Image
                Expanded(
                  flex: 2,
                  child: SvgPicture.asset(
                    'assets/images/lets-start.svg', // Ensure you have this SVG asset
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomRight,
                    colorFilter: ColorFilter.mode(
                      Color(0xff5c0f24),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
