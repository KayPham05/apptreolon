import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/activity_entity.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  // Empty for demo (như trong ảnh)
  final List<ActivityEntity> _activities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── App Bar ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Hoạt động',
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.check_box_outlined, color: AppColors.textPrimary),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz, color: AppColors.textPrimary),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // ── Body ─────────────────────────────────────────────────────
            if (_activities.isEmpty)
              _buildEmptyState()
            else
              Expanded(child: _buildActivityList()),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Cute dog illustration 
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.15),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Text('🐺', style: TextStyle(fontSize: 64)),
                  // sparkle icons
                  Positioned(
                    top: 10,
                    right: 18,
                    child: Icon(Icons.auto_awesome, color: AppColors.accent.withOpacity(0.8), size: 16),
                  ),
                  Positioned(
                    top: 16,
                    left: 14,
                    child: Icon(Icons.auto_awesome, color: AppColors.accent.withOpacity(0.5), size: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Bạn không có thông báo nào.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // refresh demo
                setState(() {});
              },
              child: const Text(
                'Kiểm tra lại',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _activities.length,
      separatorBuilder: (_, __) => Container(height: 0.5, color: AppColors.border),
      itemBuilder: (ctx, i) {
        final item = _activities[i];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          leading: CircleAvatar(
            backgroundColor: AppColors.primary.withOpacity(0.2),
            child: Text(
              item.userName.isNotEmpty ? item.userName[0].toUpperCase() : '?',
              style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
          ),
          title: RichText(
            text: TextSpan(
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
              children: [
                TextSpan(text: item.userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                const TextSpan(text: ' '),
                TextSpan(text: item.action),
                const TextSpan(text: ' '),
                TextSpan(text: item.cardTitle, style: const TextStyle(color: AppColors.primary)),
              ],
            ),
          ),
          subtitle: Text(
            _formatTime(item.createdAt),
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
        );
      },
    );
  }

  String _formatTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes} phút trước';
    if (diff.inHours < 24) return '${diff.inHours} giờ trước';
    return '${diff.inDays} ngày trước';
  }
}
