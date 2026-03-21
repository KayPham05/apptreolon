import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/planner_entity.dart';

class PlannerPage extends StatefulWidget {
  const PlannerPage({super.key});

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  late List<PlannerDayEntity> _days;
  late DateTime _today;

  @override
  void initState() {
    super.initState();
    _today = DateTime.now();
    _days = _generateDays();
  }

  List<PlannerDayEntity> _generateDays() {
    final now = _today;
    final lastDay = DateTime(now.year, now.month + 1, 0); // last day of month
    final List<PlannerDayEntity> days = [];

    // Mock tasks cho một số ngày
    final Map<int, List<String>> mockTasks = {
      now.day: ['Implement Board Screen', 'Code Review'],
      now.day + 2: ['Meeting nhóm', 'Demo sản phẩm'],
      now.day + 5: ['Deadline nộp bài'],
    };

    for (int d = now.day; d <= lastDay.day; d++) {
      final date = DateTime(now.year, now.month, d);
      days.add(PlannerDayEntity(
        date: date,
        taskTitles: mockTasks[d] ?? [],
      ));
    }
    // Add a couple days from next month
    for (int d = 1; d <= 3; d++) {
      final date = DateTime(now.year, now.month + 1, d);
      days.add(PlannerDayEntity(date: date, taskTitles: []));
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    final monthName = _getMonthName(_today.month);

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
                  Expanded(
                    child: Text(
                      monthName,
                      style: const TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: AppColors.textPrimary, size: 22),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz, color: AppColors.textPrimary),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            // ── Days List ────────────────────────────────────────────────
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _days.length,
                itemBuilder: (ctx, i) => _buildDayRow(_days[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayRow(PlannerDayEntity day) {
    final bool isToday = day.date.year == _today.year &&
        day.date.month == _today.month &&
        day.date.day == _today.day;

    final weekday = _getShortWeekday(day.date.weekday);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date circle
              SizedBox(
                width: 48,
                child: Column(
                  children: [
                    Text(
                      weekday,
                      style: TextStyle(
                        color: isToday ? AppColors.accent : AppColors.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isToday ? AppColors.accent : Colors.transparent,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.date.day}',
                        style: TextStyle(
                          color: isToday ? Colors.white : AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Tasks or empty state
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (day.hasTask)
                      ...day.taskTitles.map((task) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.border.withOpacity(0.5)),
                          ),
                          child: Text(
                            task,
                            style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
                          ),
                        ),
                      ))
                    else
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Chưa lên kế hoạch nào',
                          style: TextStyle(
                            color: AppColors.textSecondary.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Today separator line
        if (isToday)
          Container(height: 1.5, color: AppColors.accent.withOpacity(0.5)),
        if (!isToday && day.date != _days.last.date)
          Container(height: 0.3, margin: const EdgeInsets.only(left: 60), color: AppColors.border.withOpacity(0.3)),
      ],
    );
  }

  String _getMonthName(int month) {
    const names = ['Tháng 1','Tháng 2','Tháng 3','Tháng 4','Tháng 5','Tháng 6','Tháng 7','Tháng 8','Tháng 9','Tháng 10','Tháng 11','Tháng 12'];
    return names[month - 1];
  }

  String _getShortWeekday(int weekday) {
    const days = ['Th 2','Th 3','Th 4','Th 5','Th 6','Th 7','CN'];
    return days[weekday - 1];
  }
}
