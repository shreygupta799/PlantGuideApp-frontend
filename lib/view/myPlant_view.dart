import 'package:flutter/material.dart';
import 'package:frontend/model/currentUser_model.dart';
import 'package:frontend/res/colors.dart';
import 'package:frontend/utils/routes/routesNames.dart';
import 'package:frontend/view/plantDetails_view.dart';
import 'package:frontend/view_model/login_view_model.dart';
import 'package:frontend/view_model/splash_view_model.dart';
import 'package:provider/provider.dart';

class MyplantView extends StatefulWidget {
  const MyplantView({super.key});

  @override
  State<MyplantView> createState() => _MyplantViewState();
}

class _MyplantViewState extends State<MyplantView> {
  List<String> _savedPlants = [];
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    fetchPlant();
    setState(() {});
  }

  Future<void> fetchPlant() async {
    final splashProvider = context.read<SplashViewModel>();
    CurrentUserModel? currentUser = await splashProvider.currentUser;
    print(currentUser?.toJson());
    print(_savedPlants);
    if (currentUser != null && currentUser.savedPlant != null) {
      _savedPlants = currentUser.savedPlant!;
      print("fetch plant success");
      setState(() {});
    }
  }

  Future<void> _logout(BuildContext context) async {
    final loginProvider = context.read<LoginViewModel>();
    await loginProvider.logout();
    Navigator.pushNamed(context, RoutesName.login);
  }

  Future<void> refresh() async {
    final loginProvider = context.read<LoginViewModel>();
    final splashProvider = context.read<SplashViewModel>();
    final token = await loginProvider.loadToken();
    await splashProvider.getCurrentUser(token);
    fetchPlant();
  }

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
    final loginProvider = Provider.of<LoginViewModel>(context);
    final splashProvider = Provider.of<SplashViewModel>(context);
    return Scaffold(
      backgroundColor: AppColor.greenColor,
      appBar: AppBar(
        backgroundColor: AppColor.greenColor,
        title: Text('My Plants',
            style: TextStyle(color: Colors.white, fontSize: 30)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            color: Colors.white,
            onPressed: () => refresh(),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pushNamed(context, RoutesName.home),
        ),
      ),
      body: _savedPlants.isNotEmpty
          ? Column(
              children: [
                // SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 60, 85, 100),
                    child: ListView.builder(
                      itemCount: _savedPlants.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                              opaque: false, // Set to false
                              pageBuilder: (_, __, ___) => PlantdetailsView(
                                  plantName: _savedPlants[index]),
                            ));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  40.0), // Rounded corners
                            ),
                            elevation: 10, // Shadow effect
                            margin:
                                EdgeInsets.all(8), // Margin around each card
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40),
                                    bottomRight: Radius.circular(40)),
                                // Rounded corners
                              ),
                              title: Text(_savedPlants[index],
                                  style: TextStyle(
                                      color: Colors.black)), // Text color
                              tileColor: Colors
                                  .white, // Background color of the ListTile
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Text('You have no saved plants'),
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
