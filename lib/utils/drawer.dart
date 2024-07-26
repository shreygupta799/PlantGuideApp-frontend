import 'package:flutter/material.dart';
import 'package:frontend/res/colors.dart';
import 'package:frontend/utils/routes/routesNames.dart';
import 'package:frontend/view_model/login_view_model.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.read<LoginViewModel>();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColor.greenColor,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              loginProvider.logout();
              Navigator.pushNamed(context, RoutesName.login);
            },
          ),
        ],
      ),
    );
  }
}
