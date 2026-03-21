import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Mock user data from User.cs
  static const String _userName = 'Phạm Tấn Kha';
  static const String _userEmail = '6451071030@st.utc2.edu.vn';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── App Bar ────────────────────────────────────────────
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Text(
                  'Tài khoản',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // ── User Card ──────────────────────────────────────────
              _buildUserCard(),
              const SizedBox(height: 20),

              // ── Workspace Section ──────────────────────────────────
              _buildSectionHeader('Không gian làm việc'),
              _buildMenuGroup([
                _MenuItem(
                  icon: Icons.people_outline,
                  label: 'Không gian làm việc của bạn',
                  onTap: () {},
                  trailing: Icons.chevron_right,
                ),
                _MenuItem(
                  icon: Icons.person_outline,
                  label: 'Không gian làm việc của khách',
                  onTap: () {},
                  trailing: Icons.chevron_right,
                ),
              ]),
              const SizedBox(height: 16),

              // ── Settings Section ───────────────────────────────────
              _buildSectionHeader('Cài đặt và công cụ'),
              _buildMenuGroup([
                _MenuItem(icon: Icons.settings_outlined, label: 'Cài đặt ứng dụng', onTap: () {}),
                _MenuItem(icon: Icons.sync_outlined, label: 'Hàng đợi đồng bộ', onTap: () {}),
                _MenuItem(icon: Icons.build_outlined, label: 'Công cụ cho Nhà phát triển', onTap: () {}, trailing: Icons.chevron_right),
                _MenuItem(icon: Icons.help_outline, label: 'Giới thiệu và trợ giúp', onTap: () {}, trailing: Icons.chevron_right),
              ]),
              const SizedBox(height: 16),

              // ── Account Management ─────────────────────────────────
              _buildMenuGroup([
                _MenuItem(
                  icon: Icons.manage_accounts_outlined,
                  label: 'Quản lý tài khoản',
                  onTap: () {},
                  trailingWidget: const Icon(Icons.open_in_new, color: AppColors.textSecondary, size: 16),
                ),
                _MenuItem(
                  icon: Icons.delete_outline,
                  label: 'Xóa tài khoản',
                  color: AppColors.error,
                  onTap: () {},
                  trailingWidget: const Icon(Icons.open_in_new, color: AppColors.textSecondary, size: 16),
                ),
                _MenuItem(
                  icon: Icons.bolt_outlined,
                  label: 'Tham gia thử nghiệm bản beta',
                  onTap: () {},
                  trailingWidget: const Icon(Icons.open_in_new, color: AppColors.textSecondary, size: 16),
                ),
              ]),
              const SizedBox(height: 32),

              // ── Thông tin ứng dụng ─────────────────────────────────
              _buildSectionHeader('Thông tin ứng dụng'),
              _buildMenuGroup([
                _MenuItem(icon: Icons.info_outline, label: 'Phiên bản 1.0.0', onTap: () {}),
              ]),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.15),
                border: Border.all(color: AppColors.border),
              ),
              child: const Icon(Icons.account_circle, color: AppColors.primary, size: 32),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '. $_userName',
                    style: TextStyle(
                      color: AppColors.textWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    _userEmail,
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                ],
              ),
            ),
            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildMenuGroup(List<_MenuItem> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: List.generate(items.length, (i) {
            final item = items[i];
            final isLast = i == items.length - 1;
            return Column(
              children: [
                InkWell(
                  onTap: item.onTap,
                  borderRadius: BorderRadius.vertical(
                    top: i == 0 ? const Radius.circular(12) : Radius.zero,
                    bottom: isLast ? const Radius.circular(12) : Radius.zero,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Icon(item.icon, color: item.color ?? AppColors.textPrimary, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item.label,
                            style: TextStyle(color: item.color ?? AppColors.textPrimary, fontSize: 15),
                          ),
                        ),
                        if (item.trailingWidget != null)
                          item.trailingWidget!
                        else if (item.trailing != null)
                          Icon(item.trailing, color: AppColors.textSecondary, size: 18),
                      ],
                    ),
                  ),
                ),
                if (!isLast)
                  Container(height: 0.5, margin: const EdgeInsets.only(left: 48), color: AppColors.border),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final IconData? trailing;
  final Widget? trailingWidget;
  final Color? color;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
    this.trailingWidget,
    this.color,
  });
}
