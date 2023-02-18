import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nobel/models/product_model.dart';
import 'package:nobel/presentation/view/product_details_screen.dart';

class CategoryProductsScreen extends StatelessWidget {
  final num catId;
  final String catName;
  const CategoryProductsScreen({required this.catId,required this.catName,Key? key}) : super(key: key);
  final Color redColor = const Color(0xffA71E27);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: redColor,
        title: Text(catName),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String,dynamic>>>(
        future: FirebaseFirestore.instance.collection("products")
            .where("cat_id",isEqualTo:catId ).get(),
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
                List<ProductModel> products = [];
                connection.data?.docs.forEach((element) {
                  products.add(
                      ProductModel(
                          name: "${element['productName']}",
                          image: "${element['productImage']}",
                          price: "${element['price']}",
                          category: "${element['category']}",
                        id: element['id']
                      ),
                  );
                });
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                    scrollDirection: Axis.vertical,
                    itemCount: connection.data?.docs.length,
                    itemBuilder: (context,index){
                      //"${connection.data?.docs[index]['image']}"
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (builder)=>ProductDetailsScreen(
                                      product: products[index],
                                    )),
                            );
                          },
                          child: Container(
                            height: 110,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: redColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child:Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration:BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ) ,
                                    child: Image.network(
                                        products[index].image,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                      products[index].name,
                                    textAlign:TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ) ,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }else{
                return const Center(child: Text("Error!"),);
              }
          }
        },
      ),
    );
  }
}
