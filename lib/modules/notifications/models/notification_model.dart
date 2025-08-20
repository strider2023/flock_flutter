import 'package:flutter/material.dart';

class NotificationModel {
  final IconData icon;
  final String title;
  final String description;
  final DateTime timestamp;

  NotificationModel({
    required this.icon,
    required this.title,
    required this.description,
    required this.timestamp,
  });
}
