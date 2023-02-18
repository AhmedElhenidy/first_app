import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nobel/models/product_model.dart';
import 'package:nobel/presentation/PLoH/favourite_cubit/favourite_cubit.dart';

class ProductDetailsScreen extends StatefulWidget {
   const ProductDetailsScreen({required this.product,Key? key}) : super(key: key);
  final ProductModel product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Color redColor = const Color(0xffA71E27);
  int _quantity=1;
  bool _isFavourite =false;
  void _increment(){
    _quantity++;
    setState(() {

    });
  }
  void _decrement(){
    if(_quantity==1){

    }else{
      _quantity--;
      setState(() {

      });
    }

  }
  void toggleFavourite(){
    _isFavourite=!_isFavourite;
    if(_isFavourite){
      BlocProvider.of<FavouriteCubit>(context).
      addToFavourite(widget.product);
    }else{
      BlocProvider.of<FavouriteCubit>(context).
      removeFromFavourite(widget.product);
    }
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(BlocProvider.of<FavouriteCubit>(context).
    favouriteProducts.any((element)=>element.id==widget.product.id)){
      _isFavourite = true;
      if(mounted){
        setState(() {
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.category),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    height: 340,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: redColor,
                    ),
                    child: Column(
                      children: [
                        // image
                        Container(
                          height: 280,
                          width: 800,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Image.network(
                            widget.product.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(height: 8,),
                        //price and name
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 16,),
                            Text(
                              widget.product.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: (){
                                toggleFavourite();
                              },
                              child: Icon(
                                _isFavourite?Icons.favorite:Icons.favorite_border,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            SizedBox(width: 16,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomLeft: Radius.circular(16),
                                )
                              ),
                              child:Text(
                                "${widget.product.price}\tSAR",
                                style: TextStyle(
                                    color: redColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      SizedBox( width: 8,),
                      Icon(Icons.shopping_cart,
                        color: redColor,
                      ),
                      Text("100",
                        style: TextStyle(
                          color: redColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox( width: 16,),
                      Icon(Icons.favorite,
                        color: redColor,
                      ),
                      Text("100",
                        style: TextStyle(
                          color: redColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )
        ),
        child: Row(
          children: [
            // add to cart text
            Expanded(
                child:Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: redColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "add to cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
            ),
            SizedBox(width: 8,),
            Expanded(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // minus button
                  InkWell(
                    onTap:(){
                      _decrement();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: redColor,
                            width: 2
                        ),
                      ),
                      child: Center(
                          child: Icon(Icons.remove,
                            color: redColor,
                          )
                      ),
                    ),
                  ),
                  //quantity text
                  Text(
                    "$_quantity",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //add button
                  InkWell(
                    onTap: (){
                      _increment();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: redColor,
                            width: 2
                        ),
                      ),
                      child: Center(
                          child: Icon(Icons.add,
                            color: redColor,
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
