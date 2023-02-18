import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/product_model.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());
  List<ProductModel> favouriteProducts = [];
  
  void addToFavourite(ProductModel product){
    favouriteProducts.add(product);
  }
  
  void removeFromFavourite(ProductModel product){
    favouriteProducts.removeWhere((element) => element.id==product.id);
    emit(FavouriteChange(favouriteProducts.length));
  }
}
