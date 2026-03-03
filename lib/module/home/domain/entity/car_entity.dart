class CarEntity {
  final int id;
  final String brand;
  final String model;
  final int year;
  final int pricePerMinute;
  final int fuel;
  final double latitude;
  final double longitude;
  final String image;
  final bool available;
  final int hours;

  CarEntity({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.pricePerMinute,
    required this.fuel,
    required this.latitude,
    required this.longitude,
    required this.image,
    required this.available,
    this.hours = 0,
  });

  CarEntity copyWith({
    int? id,
    String? brand,
    String? model,
    int? year,
    int? pricePerMinute,
    int? fuel,
    double? latitude,
    double? longitude,
    String? image,
    bool? available,
    int? hours,
  }) {
    return CarEntity(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      pricePerMinute: pricePerMinute ?? this.pricePerMinute,
      fuel: fuel ?? this.fuel,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      image: image ?? this.image,
      available: available ?? this.available,
      hours: hours ?? this.hours,
    );
  }
}
