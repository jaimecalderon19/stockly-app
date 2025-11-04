import 'package:flutter/widgets.dart';
import 'package:stockly/presentation/screens/home_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
};
