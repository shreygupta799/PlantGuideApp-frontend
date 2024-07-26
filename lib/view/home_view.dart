import 'package:flutter/material.dart';
import 'package:frontend/res/colors.dart';
import 'package:frontend/utils/drawer.dart';
import 'package:frontend/utils/routes/routesNames.dart';
import 'package:frontend/view_model/login_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _selectedIndex = index;
      });
      switch (index) {
        case 0:
          Navigator.pushNamed(context, RoutesName.home);
          break;
        case 1:
          Navigator.pushNamed(
              context, RoutesName.search); // Add search screen route
          break;
        case 2:
          Navigator.pushNamed(context, RoutesName.myPlant);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            color: AppColor.greenColor,
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Fun Fact',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Save',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onNavItemTapped,
      ),
    );
  }
}
