import 'package:flutter/widgets.dart';
import 'package:stockly/presentation/screens/add_product_screen.dart';
import 'package:stockly/presentation/screens/home_screen.dart';
import 'package:stockly/presentation/screens/product_detail_screen.dart';
import 'package:stockly/presentation/screens/product_list_screen.dart';
import 'package:stockly/presentation/screens/saved_products_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProductListScreen.routeName: (context) => const ProductListScreen(),
  AddProductScreen.routeName: (context) => const AddProductScreen(),
  SavedProductsScreen.routeName: (context) => const SavedProductsScreen(),
  ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
};
