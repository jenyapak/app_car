import 'package:flutter_application_1_app_car/core/base/base_usecase.dart';
import 'package:flutter_application_1_app_car/module/authorization/domain/repository/auth_domain_repository.dart';

class SignInUsecase extends BaseUsecase<bool, SignInParams> {
  final AuthDomainRepository _authDomainRepository;

  SignInUsecase({required AuthDomainRepository authDomainRepository})
    : _authDomainRepository = authDomainRepository;

  @override
  Future<bool> call(SignInParams params) {
    return _authDomainRepository.signIn(params);
  }
}

class SignInParams extends BaseParams {
  final String phone;
  final String password;

  SignInParams({required this.phone, required this.password});
  @override
  Map<String, dynamic> toJson() {
    return {'phone': phone, 'password': password};
  }
}
