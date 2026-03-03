import 'package:flutter_application_1_app_car/core/base/base_usecase.dart';
import 'package:flutter_application_1_app_car/module/home/domain/entity/car_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(cartCount: 0));

  List<CarEntity> cartItems = [];

  bool addCart(CarEntity newCard) {
    if (!cartItems.contains(newCard)) {
      cartItems.add(newCard);
      emit(CartState(cartCount: cartItems.length));

      return true;
    }
    return false;
  }

  void addHour(int index) {
    List<CarEntity> newList = [];
    for (var i = 0; i < cartItems.length; i++) {
      if (index == i) {
        final hour = cartItems[i].hours;
        newList.add(cartItems[i].copyWith(hours: hour + 1));
      } else {
        newList.add(cartItems[i]);
      }
    }
    cartItems = newList;
  }

  void removeHour(int index) {
    List<CarEntity> newList = [];
    for (var i = 0; i < cartItems.length; i++) {
      if (index == i) {
        final hour = cartItems[i].hours;
        int newHour = hour > 0 ? hour - 1 : 0;
        newList.add(cartItems[i].copyWith(hours: newHour));
      } else {
        newList.add(cartItems[i]);
      }
    }
    cartItems = newList;
  }

  void deleteFromCart(int index) {
    cartItems.removeAt(index);
    emit(CartState(cartCount: cartItems.length));
  }
}

class CartParams extends BaseParams {
  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}

class CartState {
  final int cartCount;

  CartState({required this.cartCount});
}
