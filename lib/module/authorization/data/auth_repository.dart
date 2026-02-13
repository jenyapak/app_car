import 'package:flutter_application_1_app_car/module/authorization/domain/usecase/sign_in_usecase.dart';
import 'package:flutter_application_1_app_car/module/authorization/domain/usecase/sign_up_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1_app_car/module/authorization/domain/repository/auth_domain_repository.dart';

class AuthRepository implements AuthDomainRepository {
  @override
  Future<bool> signIn(SignInParams params) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final phone = sharedPrefs.getString('PHONE');
    final password = sharedPrefs.getString('PASSWORD');
    if (phone == null) {
      throw Exception('Wrong number');
    }
    if (phone == params.phone && password == params.password) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> signUp(SignUpParams params) async {
    try {
      final sharedPrefs = await SharedPreferences.getInstance();
      await sharedPrefs.setString('PHONE', params.phone);
      await sharedPrefs.setString('PASSWORD', params.password);
      await sharedPrefs.setString('FULLNAME', params.fullname);
      return true;
    } catch (e) {
      return false;
    }
  }
}
