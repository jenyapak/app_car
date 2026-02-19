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
            return Center(child: Text(state.message ?? 'ПРоизошла ошибка'));
          }
          if (state.status == StateStatus.success) {
            return ListView.builder(
              itemCount: state.model?.length ?? 0,
              itemBuilder: (context, index) {
                final cars = state.model?[index];
                return ListTile(
                  leading: Image.network(state.model?[index].image ?? ''),
                  title: Text('${cars?.brand}, ${cars?.model}'),
                  trailing: Text((cars?.available).toString()),
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
