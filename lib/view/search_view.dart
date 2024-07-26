import 'package:flutter/material.dart';
import 'package:frontend/res/colors.dart';
import 'package:frontend/utils/routes/routesNames.dart';
import 'package:frontend/view/plantDetails_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  dynamic plantInfo;
  bool isLoading = true;
  int _selectedIndex = 1;
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
    return Scaffold(
      backgroundColor: AppColor.greenColor,
      appBar: AppBar(
        //backgroundColor: AppColor.greenColor,
        title: Text('Search'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pushNamed(context, RoutesName.home),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(4),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    borderSide: BorderSide(color: AppColor.whiteColor),
                  ),
                  hintText: 'ENTER TO SEARCH',
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: AppColor.blackColor,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.whiteColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: TextButton(
                onPressed: () {
                  if (_searchController.text.isNotEmpty) {
                    Navigator.of(context).push(PageRouteBuilder(
                      opaque: false, // Set to false
                      pageBuilder: (_, __, ___) => PlantdetailsView(
                          plantName: _searchController.text.toUpperCase()),
                    ));
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Please enter a plant name'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: const Text(
                    'Search',
                    style: TextStyle(color: AppColor.blackColor, fontSize: 20),
                  ),
                )),
          ),
        ],
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
