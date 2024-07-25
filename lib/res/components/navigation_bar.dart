import 'package:flutter/material.dart';
import 'package:frontend/res/colors.dart';
import 'package:frontend/view/home_view.dart';
import 'package:frontend/view/search_view.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int screenIndex = 0;
  final screens = [const SearchView(), const HomeView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[screenIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: screenIndex,
        //backgroundColor: AppColor.greenColor,
        onDestinationSelected: (value) {
          setState(() {
            screenIndex = value;
          });
        },
        indicatorColor: AppColor.whiteColor,
        destinations: const [
          NavigationDestination(
              icon: Icon(
                Icons.search,
              ),
              label: 'Search'),
          NavigationDestination(
            icon: Icon(Icons.home_filled),
            label: 'home',
          )
        ],
      ),
    );
  }
}
