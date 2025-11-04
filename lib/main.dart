import 'package:flutter/material.dart';
import 'package:stockly/presentation/screens/home_screen.dart';
import 'package:stockly/routes/routes.dart';
import 'package:stockly/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stockly Jaime Calderon',
      theme: AppTheme.lightTheme(context),
      initialRoute: HomeScreen.routeName,
      routes: routes,
    );
  }
}
