import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nobel/presentation/PLoH/favourite_cubit/favourite_cubit.dart';
import 'package:nobel/presentation/view/product_details_screen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);
  final Color redColor = const Color(0xffA71E27);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
  builder: (context, state) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
        scrollDirection: Axis.vertical,
        itemCount: BlocProvider.of<FavouriteCubit>(context).favouriteProducts.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (builder)=>ProductDetailsScreen(
                        product:  BlocProvider.of<FavouriteCubit>(context).
                        favouriteProducts[index],
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
                          BlocProvider.of<FavouriteCubit>(context).
                          favouriteProducts[index].image,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        BlocProvider.of<FavouriteCubit>(context).
                        favouriteProducts[index].name,
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
  },
);
  }
}
