import 'package:flutter/material.dart';
import 'package:flutter_application_1_app_car/core/config/router/router.dart';

final appRouter = AppRouter();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: appRouter.config());
  }
}
