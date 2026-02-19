import 'package:dio/dio.dart';
import 'package:flutter_application_1_app_car/module/home/data/model/car_model.dart';
import 'package:flutter_application_1_app_car/module/home/domain/entity/car_entity.dart';
import 'package:flutter_application_1_app_car/module/home/domain/repository/home_domain_repository.dart';

class HomeRepository implements HomeDomainRepository {
  @override
  Future<List<CarEntity>> getAllCars() async {
    final result = await Dio().get(
      'https://eocx5h5csmmf4d0.m.pipedream.net/get_all_cars',
    );
    final cars = result.data['data'] as List;
    return cars.map((e) => CarModel.fromJson(e)).toList();
  }
}
