import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/res/colors.dart';
import 'package:frontend/utils/routes/routesNames.dart';
import 'package:frontend/view_model/login_view_model.dart';
import 'package:frontend/view_model/splash_view_model.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    final loginProvider = context.read<LoginViewModel>();
    final splashProvider = context.read<SplashViewModel>();
    final token = await loginProvider.loadToken();
    if (token != null) {
      final res = await splashProvider.getCurrentUser(token);
      if (res != null) {
        Navigator.pushNamed(context, RoutesName.home);
      } else {
        Navigator.pushNamed(context, RoutesName.login);
      }
    } else {
      Navigator.pushNamed(context, RoutesName.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xFF096E0E),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Your own',
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: AppColor.whiteColor),
              ),
            ),
            Center(
              child: Text(
                'Plant Guide',
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: AppColor.whiteColor),
              ),
            ),
          ],
        ));
  }
}
