import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_app_car/core/base/base_state.dart';
import 'package:flutter_application_1_app_car/core/enum/state_status.dart';
import 'package:flutter_application_1_app_car/module/home/domain/entity/car_entity.dart';
import 'package:flutter_application_1_app_car/module/home/presentation/cubit/get_all_cars_cubit.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Home',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
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
                        height: 120,
                        width: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(8),
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
                              Text('Year: ${(cars?.year)}'),
                              const SizedBox(height: 2),
                              Text('Price/min: ${(cars?.pricePerMinute)}'),
                              const SizedBox(height: 2),
                              Text('Fuel: ${(cars?.fuel)}%'),
                              const SizedBox(height: 2),

                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Status: '),
                                    TextSpan(
                                      text: cars?.available == true
                                          ? 'Available'
                                          : 'Booked',
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
