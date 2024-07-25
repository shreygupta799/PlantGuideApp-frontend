import 'package:flutter/material.dart';
import 'package:frontend/utils/routes/routesNames.dart';
import 'package:frontend/view/home_view.dart';
import 'package:frontend/view/login_view.dart';
import 'package:frontend/view/myPlant_view.dart';
import 'package:frontend/view/plantDetails_view.dart';
import 'package:frontend/view/register_view.dart';
import 'package:frontend/view/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.register:
        return MaterialPageRoute(builder: (context) => const RegisterView());
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case RoutesName.home:
        return MaterialPageRoute(builder: (constext) => const HomeView());
      case RoutesName.splash:
        return MaterialPageRoute(builder: (constext) => const SplashView());
      case RoutesName.myPlant:
        return MaterialPageRoute(builder: (constext) => const MyplantView());

      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
