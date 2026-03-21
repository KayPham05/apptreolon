import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/board_mock_data.dart';
import '../../domain/entities/board_entity.dart';
import '../../domain/entities/workspace_entity.dart';
import '../widgets/board_card_item.dart';
import 'board_detail_page.dart';

class BoardListPage extends StatefulWidget {
  const BoardListPage({super.key});

  @override
  State<BoardListPage> createState() => _BoardListPageState();
}

class _BoardListPageState extends State<BoardListPage> {
  final List<WorkspaceEntity> _workspaces = BoardMockData.workspaces;
  final Set<String> _expandedWorkspaces = {'ws-1', 'ws-2'};
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── App Bar ──────────────────────────────────────────────────
            SliverAppBar(
              backgroundColor: AppColors.background,
              pinned: true,
              title: const Text(
                'Bảng',
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: AppColors.textPrimary),
                  onPressed: () {},
                ),
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 18,
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Search Bar ──────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: AppColors.textPrimary),
                        decoration: const InputDecoration(
                          hintText: 'Bảng',
                          hintStyle: TextStyle(color: AppColors.textSecondary),
                          prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),

                  // ── Inbox Quick Access ──────────────────────────────────
                  _buildInboxCard(),

                  const SizedBox(height: 20),

                  // ── Workspace Section Header ────────────────────────────
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text(
                      'KHÔNG GIAN LÀM VIỆC CỦA BẠN',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Workspaces List ─────────────────────────────────────────
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildWorkspaceSection(_workspaces[index]),
                childCount: _workspaces.length,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }

  Widget _buildInboxCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {},
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    const Icon(Icons.inbox_outlined, color: AppColors.textPrimary, size: 20),
                    const SizedBox(width: 10),
                    const Text(
                      'Hộp thư đến',
                      style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                    const Spacer(),
                    const Icon(Icons.edit_outlined, color: AppColors.textSecondary, size: 18),
                  ],
                ),
              ),
            ),
            Container(height: 0.5, color: AppColors.border),
            InkWell(
              onTap: () {},
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    const Text('Thêm thẻ', style: TextStyle(color: AppColors.textSecondary)),
                    const Spacer(),
                    const Icon(Icons.attachment, color: AppColors.textSecondary, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkspaceSection(WorkspaceEntity workspace) {
    final isExpanded = _expandedWorkspaces.contains(workspace.id);
    return Column(
      children: [
        // Workspace header row
        InkWell(
          onTap: () {
            setState(() {
              if (isExpanded) {
                _expandedWorkspaces.remove(workspace.id);
              } else {
                _expandedWorkspaces.add(workspace.id);
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.people_outline, color: AppColors.primary, size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    workspace.name,
                    style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ),
                Text(
                  'Bảng',
                  style: TextStyle(color: AppColors.primary.withOpacity(0.8), fontSize: 13),
                ),
                const SizedBox(width: 4),
                Icon(
                  isExpanded ? Icons.chevron_right : Icons.expand_more,
                  color: AppColors.textSecondary,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
        // Boards
        if (isExpanded)
          ...workspace.boards.map((board) => _buildBoardRow(board)),
      ],
    );
  }

  Widget _buildBoardRow(BoardEntity board) {
    final color = _hexToColor(board.coverColor ?? '#0079BF');
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BoardDetailPage(board: board),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 32,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                board.name,
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _hexToColor(String hex) {
    final h = hex.replaceAll('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }
}
