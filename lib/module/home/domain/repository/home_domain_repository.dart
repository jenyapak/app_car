import 'package:flutter_application_1_app_car/module/home/domain/entity/car_entity.dart';

abstract class HomeDomainRepository {
  Future<List<CarEntity>> getAllCars();
}
