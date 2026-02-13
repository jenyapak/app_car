import 'package:flutter_application_1_app_car/module/authorization/domain/usecase/sign_in_usecase.dart';
import 'package:flutter_application_1_app_car/module/authorization/domain/usecase/sign_up_usecase.dart';

abstract class AuthDomainRepository {
  Future<bool> signIn(SignInParams params);

  Future<bool> signUp(SignUpParams params);
}
