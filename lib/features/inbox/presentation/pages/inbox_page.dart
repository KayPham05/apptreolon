import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/inbox_entity.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  late List<InboxEntity> _items;
  final TextEditingController _addController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _items = [
      InboxEntity(id: 'i-1', cardTitle: 'Học', isCompleted: false, addedAt: DateTime.now().subtract(const Duration(days: 2))),
      InboxEntity(id: 'i-2', cardTitle: 'Test product', isCompleted: false, addedAt: DateTime.now().subtract(const Duration(days: 1))),
      InboxEntity(id: 'i-3', cardTitle: 'Học Dart', isCompleted: false, addedAt: DateTime.now()),
    ];
  }

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
                      'Hộp thư đến',
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.view_list_outlined, color: AppColors.textPrimary),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz, color: AppColors.textPrimary),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            // ── Search ───────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const TextField(
                  style: TextStyle(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm',
                    hintStyle: TextStyle(color: AppColors.textSecondary),
                    prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // ── Items List ───────────────────────────────────────────────
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _items.length + 1,
                itemBuilder: (ctx, i) {
                  if (i == _items.length) {
                    return const SizedBox(height: 80);
                  }
                  return _buildInboxItem(_items[i], i);
                },
              ),
            ),
            // ── Add Card Bottom Input ────────────────────────────────────
            _buildAddInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildInboxItem(InboxEntity item, int index) {
    final bool isFirst = index == 0;
    final bool isLast = index == _items.length - 1;

    BorderRadius radius = BorderRadius.only(
      topLeft: isFirst ? const Radius.circular(12) : Radius.zero,
      topRight: isFirst ? const Radius.circular(12) : Radius.zero,
      bottomLeft: isLast ? const Radius.circular(12) : Radius.zero,
      bottomRight: isLast ? const Radius.circular(12) : Radius.zero,
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: radius,
        border: !isLast
            ? const Border(bottom: BorderSide(color: AppColors.border, width: 0.5))
            : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        leading: GestureDetector(
          onTap: () {
            setState(() {
              _items[index] = _items[index].copyWith(isCompleted: !item.isCompleted);
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: item.isCompleted ? AppColors.success : AppColors.textSecondary,
                width: 2,
              ),
              color: item.isCompleted ? AppColors.success.withOpacity(0.15) : Colors.transparent,
            ),
            child: item.isCompleted
                ? const Icon(Icons.check, color: AppColors.success, size: 14)
                : null,
          ),
        ),
        title: Text(
          item.cardTitle,
          style: TextStyle(
            color: item.isCompleted ? AppColors.textSecondary : AppColors.textPrimary,
            decoration: item.isCompleted ? TextDecoration.lineThrough : null,
            fontSize: 15,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 16),
      ),
    );
  }

  Widget _buildAddInput() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _addController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                hintText: 'Thêm thẻ',
                hintStyle: TextStyle(color: AppColors.textSecondary),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              onSubmitted: (val) {
                if (val.trim().isNotEmpty) {
                  setState(() {
                    _items.add(InboxEntity(
                      id: 'i-${DateTime.now().millisecondsSinceEpoch}',
                      cardTitle: val.trim(),
                      isCompleted: false,
                      addedAt: DateTime.now(),
                    ));
                    _addController.clear();
                  });
                }
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.attachment, color: AppColors.textSecondary),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
