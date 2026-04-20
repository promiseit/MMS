import 'package:autism_work_integration_tool/src/services/storage_service.dart';
import 'package:autism_work_integration_tool/src/services/feedback_service.dart';
import 'package:autism_work_integration_tool/src/services/analytics_service.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  late StorageService _storageService;
  late FeedbackService _feedbackService;
  late AnalyticsService _analyticsService;

  factory ServiceLocator() {
    return _instance;
  }

  ServiceLocator._internal();

  Future<void> init() async {
    _storageService = await StorageService.instance;
    _feedbackService = FeedbackService(_storageService);
    _analyticsService = AnalyticsService(_storageService);
  }

  StorageService get storageService => _storageService;
  FeedbackService get feedbackService => _feedbackService;
  AnalyticsService get analyticsService => _analyticsService;
}

// 全局服务定位器实例
final serviceLocator = ServiceLocator();
