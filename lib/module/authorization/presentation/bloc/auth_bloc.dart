import 'package:flutter_application_1_app_car/core/base/base_state.dart';
import 'package:flutter_application_1_app_car/module/authorization/domain/usecase/sign_in_usecase.dart';
import 'package:flutter_application_1_app_car/module/authorization/domain/usecase/sign_up_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, BaseState<bool>> {
  final SignInUsecase _signInUsecase;
  final SignUpUsecase _signUpUsecase;

  AuthBloc({
    required SignInUsecase signInUsecase,
    required SignUpUsecase signUpUsecase,
  }) : _signInUsecase = signInUsecase,
       _signUpUsecase = signUpUsecase,
       super(BaseState.init()) {
    on<SingInEvent>((event, emit) async {
      emit(BaseState.loading());
      Future.delayed(Duration(seconds: 2));

      try {
        final result = await _signInUsecase.call(
          SignInParams(phone: event.phone, password: event.password),
        );
        if (result == true) {
          emit(BaseState.success(model: result));
        } else {
          emit(BaseState.error(message: 'Ошибка при авторизации'));
        }
      } catch (e) {
        emit(BaseState.error(message: e.toString()));
      }
    });
    on<SignUpEvent>((event, emit) async {
      emit(BaseState.loading());
      Future.delayed(Duration(seconds: 2));
      try {
        final result = await _signUpUsecase.call(
          SignUpParams(
            fullname: event.fullname,
            phone: event.phone,
            password: event.password,
          ),
        );
        emit(BaseState.success(model: result));
      } catch (e) {
        emit(BaseState.error(message: 'Ошибка при регистрации'));
      }
    });
  }
}

abstract class AuthEvent {}

class SingInEvent extends AuthEvent {
  final String phone;
  final String password;

  SingInEvent({required this.phone, required this.password});
}

class SignUpEvent extends AuthEvent {
  final String fullname;
  final String phone;
  final String password;

  SignUpEvent({
    required this.fullname,
    required this.phone,
    required this.password,
  });
}
