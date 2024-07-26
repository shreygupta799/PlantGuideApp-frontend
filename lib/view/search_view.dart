import 'package:flutter/material.dart';
import 'package:frontend/res/colors.dart';
import 'package:frontend/view_model/plant_view_model.dart';

class SearchView extends StatefulWidget {
  
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  dynamic plant;
  PlantViewModel plantViewModel = PlantViewModel();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: AppColor.greenColor,
        title: const Center(child: Text('Search')),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(4),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                hintText: 'ENTER TO SEARCH',
                prefixIcon: Icon(Icons.search),
                prefixIconColor: AppColor.greenColor,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.greenColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
            ),
          ),

          TextButton(onPressed: () {
           setState(() async {
            plant = await plantViewModel.getPlantsDetails(_searchController.text); 
           });
          }, child: plantViewModel.loading ? const CircularProgressIndicator() : const Text('search')),
          
          // ChangeNotifierProvider<PlantViewModel>(
          //   create: (BuildContext context) => plantViewModel,
          //   child: Consumer<PlantViewModel>(
          //     builder: (context, value, _) {
          //       if (!value.loading) {
          //         return ();
          //           }else{
          //         return(const CircularProgressIndicator());
          //       }
          //     },
          //   ),
          // )
          Center(child: plant != null ? Text(plant.name) : const Text(''))
        ],
      ),
    );
  }
}
