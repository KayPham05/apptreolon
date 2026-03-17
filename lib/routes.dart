import 'package:flutter/material.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/board/presentation/pages/board_list_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const LoginPage(),
    '/boards': (context) => const BoardListPage(),
  };
}
