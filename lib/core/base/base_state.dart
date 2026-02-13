import 'package:flutter_application_1_app_car/core/enum/state_status.dart';

class BaseState<T> {
  final T? model;
  final StateStatus status;
  final String? message;

  BaseState({required this.model, required this.status, this.message});

  BaseState.init({this.model, this.status = StateStatus.init, this.message});

  BaseState.loading({
    this.model,
    this.status = StateStatus.loading,
    this.message,
  });

  BaseState.success({
    required this.model,
    this.status = StateStatus.success,
    this.message,
  });

  BaseState.error({
    this.model,
    this.status = StateStatus.error,
    required this.message,
  });
}
