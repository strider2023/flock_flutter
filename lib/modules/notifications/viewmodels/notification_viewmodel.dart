import 'package:flutter/foundation.dart';
import '../models/notification_model.dart';
import '../repositories/notification_repository.dart';

class NotificationViewModel extends ChangeNotifier {
  final NotificationRepository _repository;

  NotificationViewModel({required NotificationRepository repository})
    : _repository = repository {
    fetchNotifications();
  }

  bool _isLoading = true;
  List<NotificationModel> _notifications = [];

  bool get isLoading => _isLoading;
  List<NotificationModel> get notifications => _notifications;

  Future<void> fetchNotifications() async {
    _isLoading = true;
    notifyListeners();
    try {
      _notifications = await _repository.getNotifications();
    } catch (e) {
      debugPrint("Error fetching notifications: $e");
    }
    _isLoading = false;
    notifyListeners();
  }
}
