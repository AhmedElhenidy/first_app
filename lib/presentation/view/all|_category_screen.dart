import 'package:flutter/material.dart';

import '../../models/category_model.dart';
import 'category_products_screen.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({required this.categoriesList,Key? key}) : super(key: key);
  final List<CategoryModel> categoriesList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        actions: [
        ],
        centerTitle: false,
        title: const Text(
          "Categories",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
         itemCount:categoriesList.length ,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context,index){
          return InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(
                    builder: (builder)=>CategoryProductsScreen(
                      catName: categoriesList[index].name,
                    ),
                  ));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child:  Image.network(
                        categoriesList[index].image,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child:  Container(
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            categoriesList[index].name,
                            style: TextStyle(
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
