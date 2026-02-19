import 'package:flutter_application_1_app_car/core/base/base_usecase.dart';
import 'package:flutter_application_1_app_car/module/home/domain/entity/car_entity.dart';
import 'package:flutter_application_1_app_car/module/home/domain/repository/home_domain_repository.dart';

class GetAllCarsUsecase extends BaseUsecase<List<CarEntity>, GetAllCarsParams> {
  final HomeDomainRepository _repository;

  GetAllCarsUsecase({required HomeDomainRepository repository})
    : _repository = repository;
  @override
  Future<List<CarEntity>> call(GetAllCarsParams params) {
    return _repository.getAllCars();
  }
}

class GetAllCarsParams extends BaseParams {
  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
