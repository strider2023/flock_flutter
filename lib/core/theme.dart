import 'package:flutter/material.dart';

// Part 1: Define Custom Colors using a ThemeExtension
// This is the modern, type-safe way to add custom colors.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.success,
    required this.info,
    required this.warning,
  });

  final Color? success;
  final Color? info;
  final Color? warning;

  @override
  AppColors copyWith({Color? success, Color? info, Color? warning}) {
    return AppColors(
      success: success ?? this.success,
      info: info ?? this.info,
      warning: warning ?? this.warning,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      success: Color.lerp(success, other.success, t),
      info: Color.lerp(info, other.info, t),
      warning: Color.lerp(warning, other.warning, t),
    );
  }
}
