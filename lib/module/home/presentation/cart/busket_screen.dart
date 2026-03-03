import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_app_car/module/home/domain/entity/car_entity.dart';
import 'package:flutter_application_1_app_car/module/home/presentation/cart/bloc/cart_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    final cartBloc = context.watch<CartCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Корзина',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: cartBloc.cartItems.isEmpty
          ? Center(child: Text('Корзина пуста'))
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartBloc.cartItems.length,
                    itemBuilder: (context, index) {
                      final car = cartBloc.cartItems[index];
                      return ListTile(
                        leading: SizedBox(
                          width: 100,
                          height: 300,
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(8),
                            child: Image.network(
                              car.image,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.car_repair),
                            ),
                          ),
                        ),
                        title: Text(
                          '${car.brand} ${car.model} ${car.year}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          'Цена:${car.pricePerMinute}\$/час',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.green,
                          ),
                        ),

                        trailing: SizedBox(
                          width: 140,
                          child: Row(
                            children: [
                              Flexible(
                                child: IconButton(
                                  onPressed: () {
                                    cartBloc.addHour(index);
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.add, size: 18),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    car.hours.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: IconButton(
                                  onPressed: () {
                                    cartBloc.removeHour(index);
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.remove, size: 18),
                                ),
                              ),

                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  context.read<CartCubit>().deleteFromCart(
                                    index,
                                  );
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Сумма к оплате:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        '${calculate(cartBloc.cartItems)}\$',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  double calculate(List<CarEntity> cars) {
    double sum = 0;
    for (var i = 0; i < cars.length; i++) {
      sum += cars[i].hours * cars[i].pricePerMinute;
    }
    return sum;
  }
}
