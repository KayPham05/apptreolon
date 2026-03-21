import 'package:flutter/material.dart';
import 'core/common_widgets/main_shell.dart';
import 'features/board/presentation/pages/board_detail_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String boardDetail = '/board-detail';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const MainShell(),
    boardDetail: (context) => const BoardDetailPage(),
  };
}
