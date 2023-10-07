import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/presentation/screens/first_screen.dart';
import 'package:project/presentation/screens/home_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => HomePage()
        );
      case '/first_screen':
        return MaterialPageRoute(
            builder: (_) => FirstScreen()
        );
      default:
        return null;
    }
  }
}
