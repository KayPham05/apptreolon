import 'package:flutter/material.dart';
import 'init_dependencies.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trello Clone',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: AppRoutes.routes,
      initialRoute: '/',
    );
  }
}
