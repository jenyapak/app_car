import 'package:flutter_application_1_app_car/core/base/base_usecase.dart';
import 'package:flutter_application_1_app_car/module/authorization/domain/repository/auth_domain_repository.dart';

class SignUpUsecase extends BaseUsecase<bool, SignUpParams> {
  final AuthDomainRepository _authDomainRepository;

  SignUpUsecase({required AuthDomainRepository authDomainRepository})
    : _authDomainRepository = authDomainRepository;
  @override
  Future<bool> call(SignUpParams params) {
    return _authDomainRepository.signUp(params);
  }
}

class SignUpParams extends BaseParams {
  final String fullname;
  final String phone;
  final String password;

  SignUpParams({
    required this.fullname,
    required this.phone,
    required this.password,
  });
  @override
  Map<String, dynamic> toJson() {
    return {'phone': phone, 'fullname': fullname, 'password': password};
  }
}
