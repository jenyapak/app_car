import 'package:flutter_application_1_app_car/core/base/base_state.dart';
import 'package:flutter_application_1_app_car/module/home/domain/entity/car_entity.dart';
import 'package:flutter_application_1_app_car/module/home/domain/usecase/get_all_cars_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetAllCarsCubit extends Cubit<BaseState<List<CarEntity>>> {
  GetAllCarsCubit({required GetAllCarsUsecase getAllCarsUsecase})
    : _getAllCarsUsecase = getAllCarsUsecase,
      super(BaseState.init());
  final GetAllCarsUsecase _getAllCarsUsecase;

  Future<void> getAllCars() async {
    emit(BaseState.init());
    try {
      final result = await _getAllCarsUsecase.call(GetAllCarsParams());
      emit(BaseState.success(model: result));
    } catch (e) {
      emit(BaseState.error(message: e.toString()));
    }
  }
}
