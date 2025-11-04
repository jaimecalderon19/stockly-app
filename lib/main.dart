import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stockly/core/api_client.dart';
import 'package:stockly/core/models/product_model.dart';
import 'package:stockly/data/implements/product_local_repository_impl.dart';
import 'package:stockly/data/implements/product_repository_impl.dart';
import 'package:stockly/data/local/product_local_data_source.dart';
import 'package:stockly/data/remote/product_remote_data_source.dart';
import 'package:stockly/logic/api_cubit/api_cubit.dart';
import 'package:stockly/logic/prefs_cubit/preference_cubit.dart';
import 'package:stockly/presentation/screens/home_screen.dart';
import 'package:stockly/routes/routes.dart';
import 'package:stockly/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    // inicializa Hive con soporte para Flutter
  await Hive.initFlutter();

  // registra el adapter si aún no está
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ProductAdapter());
  }

  // abre la box antes de usarla
  await Hive.openBox<Product>('products_box');

  final apiClient = ApiClient();
  final remote = ProductRemoteDataSource(apiClient);
  final local = ProductLocalDataSource();

  await local.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ApiCubit(ProductRepositoryImpl(remote))),
        BlocProvider(create: (_) => PreferenceCubit(ProductLocalRepositoryImpl(local))),
      ],
      child: const MyApp(),
    ),
  );
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
