import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialLoginButton extends StatelessWidget {
  final String type;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.type,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: const StadiumBorder(),
        side: BorderSide(color: Colors.grey.shade400),
      ),
      child: Row(
        children: [
          // Using an icon as a placeholder.
          SvgPicture.asset(
            type == 'Google'
                ? 'assets/icons/google_logo.svg'
                : 'assets/icons/apple_logo.svg',
            width: 28,
            height: 28,
            semanticsLabel: 'Dart Logo',
          ),
          const SizedBox(width: 12),
          Text(
            type,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
