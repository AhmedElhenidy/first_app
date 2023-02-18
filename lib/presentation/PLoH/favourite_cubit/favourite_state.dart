part of 'favourite_cubit.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();
}

class FavouriteInitial extends FavouriteState {
  @override
  List<Object> get props => [];
}

class FavouriteChange extends FavouriteState {
  int length;
  FavouriteChange(this.length);
  @override
  List<Object> get props => [length];
}
