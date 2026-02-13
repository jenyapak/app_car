// ignore: avoid_types_as_parameter_names
abstract class BaseUsecase<T, BaseParams> {
  Future<T> call(BaseParams params);
}

abstract class BaseParams {
  Map<String, dynamic> toJson();
}
