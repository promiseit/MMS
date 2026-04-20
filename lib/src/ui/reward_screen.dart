import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autism_work_integration_tool/src/providers/game_provider.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    
    // 定义奖励商品
    final List<RewardItem> rewards = [
      RewardItem(
        id: 1,
        name: '职场技能手册',
        description: '包含各种职场技能的详细说明和练习方法',
        price: 500,
        image: Icons.book,
      ),
      RewardItem(
        id: 2,
        name: '办公软件教程',
        description: 'Office、Excel等办公软件的使用教程',
        price: 800,
        image: Icons.computer,
      ),
      RewardItem(
        id: 3,
        name: '职场礼仪指南',
        description: '详细的职场礼仪和沟通技巧指南',
        price: 600,
        image: Icons.people,
      ),
      RewardItem(
        id: 4,
        name: '时间管理工具',
        description: '帮助你更好地管理时间和任务',
        price: 400,
        image: Icons.access_time,
      ),
      RewardItem(
        id: 5,
        name: '面试技巧视频',
        description: '专业的面试技巧和常见问题解答',
        price: 1000,
        image: Icons.video_library,
      ),
      RewardItem(
        id: 6,
        name: '职场英语课程',
        description: '针对职场场景的英语学习课程',
        price: 1200,
        image: Icons.language,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('积分商城'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              '积分商城',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '当前积分: ${gameProvider.totalScore}',
              style: const TextStyle(
                fontSize: 20.0,
                color: Color(0xFF4CAF50),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: rewards.length,
                itemBuilder: (context, index) {
                  final reward = rewards[index];
                  final canPurchase = gameProvider.totalScore >= reward.price;
                  
                  return Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFE8F5E9),
                            ),
                            child: Icon(
                              reward.image,
                              size: 48.0,
                              color: const Color(0xFF4CAF50),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            reward.name,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            reward.description,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF666666),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                size: 20.0,
                                color: const Color(0xFFFFC107),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${reward.price} 积分',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: canPurchase
                                ? () => _purchaseReward(context, gameProvider, reward)
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: canPurchase
                                  ? const Color(0xFF4CAF50)
                                  : const Color(0xFFBDBDBD),
                            ),
                            child: Text(
                              canPurchase ? '兑换' : '积分不足',
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _purchaseReward(BuildContext context, GameProvider gameProvider, RewardItem reward) {
    // 扣除积分
    // 这里简化处理，实际应该添加确认对话框和错误处理
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('成功兑换 ${reward.name}！'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class RewardItem {
  final int id;
  final String name;
  final String description;
  final int price;
  final IconData image;

  RewardItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });
}
