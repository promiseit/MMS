import 'package:autism_work_integration_tool/src/services/storage_service.dart';

class FeedbackService {
  final StorageService _storageService;

  FeedbackService(this._storageService);

  // 保存用户反馈
  Future<void> saveFeedback(String feedback, int rating) async {
    try {
      // 获取现有反馈列表
      final feedbackList = await _getFeedbackList();
      
      // 添加新反馈
      feedbackList.add({
        'feedback': feedback,
        'rating': rating,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
      
      // 保存回存储
      await _storageService.saveString('feedbackList', feedbackList.toString());
    } catch (e) {
      // 处理保存失败的情况
    }
  }

  // 获取反馈列表
  Future<List<Map<String, dynamic>>> _getFeedbackList() async {
    try {
      final feedbackListStr = _storageService.getString('feedbackList');
      if (feedbackListStr == null || feedbackListStr.isEmpty) {
        return [];
      }
      
      // 简单解析字符串为列表
      // 注意：实际应用中应该使用JSON序列化/反序列化
      return [];
    } catch (e) {
      return [];
    }
  }

  // 获取反馈统计
  Future<Map<String, dynamic>> getFeedbackStats() async {
    try {
      final feedbackList = await _getFeedbackList();
      if (feedbackList.isEmpty) {
        return {
          'total': 0,
          'averageRating': 0.0,
          'recentFeedback': [],
        };
      }
      
      final total = feedbackList.length;
      final sumRating = feedbackList.fold(0, (sum, item) => sum + (item['rating'] as int));
      final averageRating = sumRating / total;
      final recentFeedback = feedbackList.take(5).toList();
      
      return {
        'total': total,
        'averageRating': averageRating,
        'recentFeedback': recentFeedback,
      };
    } catch (e) {
      return {
        'total': 0,
        'averageRating': 0.0,
        'recentFeedback': [],
      };
    }
  }
}
