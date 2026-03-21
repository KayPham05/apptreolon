import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/board_mock_data.dart';
import '../../domain/entities/board_entity.dart';
import '../../domain/entities/list_entity.dart';
import '../../domain/entities/card_entity.dart';

class BoardDetailPage extends StatelessWidget {
  final BoardEntity? board;

  const BoardDetailPage({super.key, this.board});

  @override
  Widget build(BuildContext context) {
    final boardData = board;
    final coverColor = _hexToColor(boardData?.coverColor ?? '#0079BF');
    final lists = BoardMockData.getListsForBoard(boardData?.id ?? 'board-1');

    return Scaffold(
      backgroundColor: coverColor.withOpacity(0.85),
      appBar: AppBar(
        backgroundColor: coverColor.withOpacity(0.7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          boardData?.name ?? 'Board Detail',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(12),
        itemCount: lists.length + 1,
        itemBuilder: (context, index) {
          if (index == lists.length) {
            return _buildAddListButton();
          }
          return _buildListColumn(context, lists[index]);
        },
      ),
    );
  }

  Widget _buildListColumn(BuildContext context, ListEntity list) {
    return Container(
      width: 272,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // List header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    list.name,
                    style: const TextStyle(
                      color: AppColors.textWhite,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                Icon(Icons.more_horiz, color: AppColors.textSecondary, size: 20),
              ],
            ),
          ),
          // Cards
          Container(
            decoration: const BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.65,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (list.cards.isNotEmpty)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.cards.length,
                    separatorBuilder: (_, __) => Container(height: 0.5, color: AppColors.border),
                    itemBuilder: (ctx, i) => _buildCardItem(ctx, list.cards[i]),
                  ),
                // Add card button
                InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.add, color: AppColors.textSecondary, size: 18),
                        SizedBox(width: 6),
                        Text('Thêm thẻ', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardItem(BuildContext context, CardEntity card) {
    return GestureDetector(
      onTap: () => _showCardDetail(context, card),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              card.title,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
            ),
            if (card.description != null) ...[
              const SizedBox(height: 4),
              Text(
                card.description!,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (card.dueDate != null) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.schedule, color: AppColors.warning, size: 12),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(card.dueDate!),
                    style: const TextStyle(color: AppColors.warning, fontSize: 11),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAddListButton() {
    return Container(
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Row(
            children: [
              Icon(Icons.add, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text('Thêm danh sách khác', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  void _showCardDetail(BuildContext context, CardEntity card) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 16),
            Text(card.title, style: const TextStyle(color: AppColors.textWhite, fontSize: 18, fontWeight: FontWeight.bold)),
            if (card.description != null) ...[
              const SizedBox(height: 12),
              Text(card.description!, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                _statusChip(card.status),
                if (card.dueDate != null) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.schedule, color: AppColors.warning, size: 14),
                        const SizedBox(width: 4),
                        Text(_formatDate(card.dueDate!), style: const TextStyle(color: AppColors.warning, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _statusChip(String status) {
    Color color;
    switch (status) {
      case 'In Progress': color = AppColors.warning; break;
      case 'Done': color = AppColors.success; break;
      case 'Review': color = AppColors.accent; break;
      default: color = AppColors.textSecondary;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(status, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500)),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}';
  }

  Color _hexToColor(String hex) {
    final h = hex.replaceAll('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }
}
