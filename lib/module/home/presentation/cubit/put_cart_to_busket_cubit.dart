import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1_app_car/module/home/domain/entity/car_entity.dart';

class CartState {
  final List<CarEntity> cartItems;

  CartState({required this.cartItems});

  factory CartState.initial() {
    return CartState(cartItems: []);
  }
}

class PutCartToBusketCubit extends Cubit<CartState> {
  PutCartToBusketCubit() : super(CartState.initial());

  void addToCart(CarEntity car) {
    final updatedList = List<CarEntity>.from(state.cartItems)..add(car);

    emit(CartState(cartItems: updatedList));
  }

  void removeFromCart(CarEntity car) {
    final updatedList = List<CarEntity>.from(state.cartItems)..remove(car);
    emit(CartState(cartItems: updatedList));
  }
}
