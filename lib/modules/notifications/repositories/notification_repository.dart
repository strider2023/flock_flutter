import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationRepository {
  final String authToken;
  NotificationRepository({required this.authToken});

  Future<List<NotificationModel>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.generate(10, (i) {
      return NotificationModel(
        icon: Icons.notifications,
        title: 'Notification Title ${i + 1}',
        description:
            'This is a sample notification description for item ${i + 1}.',
        timestamp: DateTime.now().subtract(Duration(hours: i * 2)),
      );
    });
  }
}
