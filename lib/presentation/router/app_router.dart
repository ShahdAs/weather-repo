import 'package:flutter/material.dart';
import 'package:project/presentation/screens/first_screen.dart';
import 'package:project/presentation/screens/home_screen.dart';
import 'package:project/presentation/screens/loading_screen.dart';
import 'package:project/presentation/router/node.dart';
import 'package:project/presentation/screens/splash_screen.dart';
import '../screens/searchedRegion_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home_screen':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/first_screen':
        return MaterialPageRoute(builder: (_) => const FirstPage());
      case '/node':
        return MaterialPageRoute(builder: (_) => const Node());
      case '/searchedRegion_screen':
        return MaterialPageRoute(builder: (_) => const SearchedRegionPage());
      case '/loading_screen':
        return MaterialPageRoute(builder: (_) => const LoadingPage());
      case '/splash_screen':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      default:
        return null;
    }
  }
}
