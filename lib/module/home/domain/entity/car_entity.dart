class CarEntity {
  final int id;
  final String brand;
  final String model;
  final int year;
  final int pricePerMinute;
  final int fuel;
  final double latitude;
  final double longtitude;
  final String image;
  final bool available;

  CarEntity({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.pricePerMinute,
    required this.fuel,
    required this.latitude,
    required this.longtitude,
    required this.image,
    required this.available,
  });
}
