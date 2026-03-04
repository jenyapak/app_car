import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_app_car/core/base/base_state.dart';
import 'package:flutter_application_1_app_car/core/config/router/router.gr.dart';
import 'package:flutter_application_1_app_car/core/enum/state_status.dart';
import 'package:flutter_application_1_app_car/module/home/domain/entity/car_entity.dart';
import 'package:flutter_application_1_app_car/module/home/presentation/cart/bloc/cart_cubit.dart';
import 'package:flutter_application_1_app_car/module/home/presentation/cubit/get_all_cars_cubit.dart';
import 'package:flutter_application_1_app_car/module/home/presentation/widgets/map_modal_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<GetAllCarsCubit>().getAllCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actionsPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Home',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  context.router.push(const BasketRoute());
                },
              ),
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return Positioned(
                    top: 0,
                    right: 2,

                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        state.cartCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),

      body: BlocBuilder<GetAllCarsCubit, BaseState<List<CarEntity>>>(
        builder: (context, state) {
          if (state.status == StateStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.status == StateStatus.error) {
            return Center(child: Text(state.message ?? 'Произошла ошибка'));
          }
          if (state.status == StateStatus.success) {
            return ListView.builder(
              itemCount: state.model?.length ?? 0,
              itemBuilder: (context, index) {
                final cars = state.model?[index];
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 160,
                        width: 185,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            state.model?[index].image ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${cars?.brand}, ${cars?.model}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text('Год: ${(cars?.year)}'),
                              const SizedBox(height: 2),
                              Text('Цена/мин: ${(cars?.pricePerMinute)}'),
                              const SizedBox(height: 2),
                              Text('Топливо: ${(cars?.fuel)}%'),
                              const SizedBox(height: 2),

                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Статус: '),
                                    TextSpan(
                                      text: cars?.available == true
                                          ? 'Свободна'
                                          : 'Занята',
                                      style: TextStyle(
                                        color: cars?.available == true
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 2),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: cars?.available == true
                                      ? () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: SizedBox(
                                                width: 400,
                                                height: 400,
                                                child: MapModalContent(
                                                  latitude: cars?.latitude ?? 0,
                                                  longitude:
                                                      cars?.longitude ?? 0,
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    if (state.model?[index] !=
                                                        null) {
                                                      context
                                                          .read<CartCubit>()
                                                          .addCart(
                                                            state.model![index],
                                                          );
                                                      context.router.maybePop();
                                                    }
                                                  },
                                                  child: Text('Add to cart'),
                                                ),
                                              ],
                                            ),
                                          );

                                          // final isAdded = context
                                          //     .read<CartCubit>()
                                          //     .addCart(cars!);

                                          // if (isAdded) {
                                          //   ScaffoldMessenger.of(
                                          //     context,
                                          //   ).showSnackBar(
                                          //     SnackBar(
                                          //       content: Text(
                                          //         '${cars.brand} добавлена в корзину!',
                                          //       ),
                                          //       backgroundColor: Colors.green,
                                          //       duration: const Duration(
                                          //         seconds: 1,
                                          //       ),
                                          //     ),
                                          //   );
                                          // } else {
                                          //   ScaffoldMessenger.of(
                                          //     context,
                                          //   ).showSnackBar(
                                          //     SnackBar(
                                          //       content: Text(
                                          //         '${cars.brand} уже есть в корзине',
                                          //       ),
                                          //       backgroundColor: Colors.orange,
                                          //       duration: const Duration(
                                          //         seconds: 1,
                                          //       ),
                                          //     ),
                                          //   );
                                          // }
                                        }
                                      : null,
                                  child: Text(
                                    cars?.available == true
                                        ? 'Местоположение'
                                        : 'Занята',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
