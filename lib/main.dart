// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:quickshop/blocs/product/cubit.dart';
import 'package:quickshop/providers/favourite.dart';
import 'package:quickshop/router/router.dart';
import 'package:quickshop/router/routes.dart';

import 'package:navigation_history_observer/navigation_history_observer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // bloc-initiate-start
        BlocProvider(create: (_) => ProductCubit()),

        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        // bloc-initiate-end
      ],
      child: MaterialApp(
        title: 'Store App',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigator,
        navigatorObservers: [NavigationHistoryObserver(), routeObserver],
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.light(primary: Colors.black),
          textTheme: const TextTheme(
            titleLarge: TextStyle(color: Colors.black),
          ),
        ),
        routes: appRoutes,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: onGenerateRoutes,
      ),
    );
  }
}
