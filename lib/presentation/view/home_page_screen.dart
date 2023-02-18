import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nobel/models/category_model.dart';
import 'package:nobel/presentation/view/all%7C_category_screen.dart';
import 'package:nobel/presentation/view/category_products_screen.dart';
import 'package:nobel/presentation/view/sign_in_screen.dart';

import 'favourite_screen.dart';

class HomePageScreen extends StatefulWidget {

   HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int currentIndex = 0;
  final controller = PageController();
   Color redColor = const Color(0xffA71E27);

   getProducts()async{
     QuerySnapshot<Map<String,dynamic>> products = await FirebaseFirestore.instance.collection("products").get();
     products.docs.forEach((element) { });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: (){
              FirebaseAuth.instance.signOut().then((value) {
                print("logged out");
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder:(co)=>const SignInScreen()),
                      (route)=>false,
                );              });
            },
              child: const Icon(Icons.logout),
          ),
        ],
        leading: InkWell(
          onTap: (){
            if(context.locale.languageCode=="en"){
              context.setLocale(Locale("ar"));
            }else{
              context.setLocale(Locale("en"));
            }
          },
          child: const Icon(Icons.language_rounded),
        ),
        centerTitle: true,
        title: const Text(
          "Home Page",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
      ),
      body:PageView(
        controller: controller,
        onPageChanged: (index){
          setState(() {
            currentIndex = index;
          });
        },
        children: [
          HomeScreenBody(),
          CategoriesBody(),
          FavouriteScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          controller.animateToPage(index,
              duration: Duration(milliseconds: 150),
            curve: Curves.bounceIn,
          );
        },
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "",
          ),
        ],

      ),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String,dynamic>>>(
      future: FirebaseFirestore.instance.collection("category").get(),
      builder: (context,connection){
        switch(connection.connectionState){
          case ConnectionState.none:
            return const Center(child: Text("none!"),);
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
            return const Center(child: Text("active!"),);
          case ConnectionState.done:
            if(connection.hasData){
              List<CategoryModel> categories = [];
              connection.data?.docs.forEach((element) {
                categories.add(
                  CategoryModel(
                      name: context.locale.languageCode=="en"?
                      "${element['name']}": "${element['name_ar']}",
                      image: "${element['image']}",
                      id: element['id']
                  ),
                );
              });
              return ListView(
                padding: EdgeInsets.all(16),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("categories".tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context,
                            MaterialPageRoute(
                                builder: (builder)=>AllCategoriesScreen(
                                  categoriesList: categories,
                                )),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Text(
                            "see all",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8,),
                      scrollDirection: Axis.horizontal,
                      itemCount: connection.data?.docs.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (builder)=>CategoryProductsScreen(
                                      catName: categories[index].name,
                                      catId: categories[index].id,
                                    ),
                                  ));
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 42,
                                  foregroundImage: NetworkImage(
                                      categories[index].image
                                  ),
                                ),
                                const SizedBox(height: 16,),
                                Text(
                                  categories[index].name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }else{
              return const Center(child: Text("Error!"),);
            }
        }
      },
    );
  }
}


class CategoriesBody extends StatelessWidget {
  const CategoriesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Cat body",style: TextStyle(color: Colors.white),),);
  }
}


