import 'package:flutter_application_1_app_car/module/home/domain/entity/car_entity.dart';

class CarModel extends CarEntity {
  CarModel({
    required super.id,
    required super.brand,
    required super.model,
    required super.year,
    required super.pricePerMinute,
    required super.fuel,
    required super.latitude,
    required super.longitude,
    required super.image,
    required super.available,
    required super.hours,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] ?? 0,
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      year: json['year'] ?? 0,
      pricePerMinute: json['pricePerMinute'] ?? 0,
      fuel: json['fuel'] ?? 0,
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
      image: json['image'] ?? '',
      available: json['available'] ?? false,
      hours: json['hours'] ?? 0,
    );
  }
}
