import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_app_car/core/base/base_state.dart';
import 'package:flutter_application_1_app_car/core/config/router/router.gr.dart';
import 'package:flutter_application_1_app_car/core/enum/state_status.dart';
import 'package:flutter_application_1_app_car/core/resources/app_images.dart';
import 'package:flutter_application_1_app_car/module/authorization/presentation/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _isPasswordVisible = ValueNotifier<bool>(false);
  final _nameController = TextEditingController();
  final _validationKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _isPasswordVisible.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _validationKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 38),
          children: [
            SizedBox(height: mq.height * 0.0844),
            Text('Sign Up', style: TextStyle(fontSize: 48)),
            SizedBox(height: mq.height * 0.097),

            Text('FULL NAME', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Поле не должно быть пустым';
                }
                final nameRegExp = RegExp(r"^[a-zA-Z\s\-]+$");
                if (value.length < 3) {
                  return 'Имя должно быть не короче 3-х символов';
                }

                if (!nameRegExp.hasMatch(value)) {
                  return 'Имя не должно содержать цифры или спецсимволы';
                }
                return null;
              },
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.symmetric(vertical: 0),
                hint: Text(
                  'Enter your full name',
                  style: TextStyle(fontSize: 16, color: Color(0xffA1A1A1)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('EMAIL OR PHONE', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            TextFormField(
              controller: _phoneController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Поле не должно быть пустым';
                }
                final phoneRegExp = RegExp(r'^[0-9]{10}$');
                if (!phoneRegExp.hasMatch(value)) {
                  return 'Введите 10 цифр без пробелов';
                }

                return null;
              },
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.symmetric(vertical: 0),
                hint: Text(
                  'Enter your email or phone',
                  style: TextStyle(fontSize: 16, color: Color(0xffA1A1A1)),
                ),
              ),
            ),
            SizedBox(height: 32),
            Text('PASSWORD', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: _isPasswordVisible,
              builder: (context, isVisible, child) {
                return TextFormField(
                  controller: _passwordController,
                  obscureText: isVisible == false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Поле не должно быть пустым';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hint: Text(
                      '**********',
                      style: TextStyle(fontSize: 16, color: Color(0xffA1A1A1)),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _isPasswordVisible.value = !_isPasswordVisible.value;
                      },
                      icon: Icon(
                        isVisible ? Icons.remove_red_eye : Icons.visibility_off,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            Text('Forgot password?', style: TextStyle(fontSize: 11)),
            SizedBox(height: 34),
            BlocConsumer<AuthBloc, BaseState<bool>>(
              listener: (context, state) {
                if (state.status == StateStatus.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Вы успешно зарегестрировались')),
                  );
                  context.router.popAndPush(SignInRoute());
                }
                if (state.status == StateStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ошибка при регистрации')),
                  );
                }
              },
              builder: (context, state) {
                return SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff2B4C59),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (_validationKey.currentState?.validate() ?? false) {
                        context.read<AuthBloc>().add(
                          SignUpEvent(
                            fullname: _nameController.text,
                            phone: _phoneController.text,
                            password: _passwordController.text,
                          ),
                        );
                      } else {
                        debugPrint('Форма заполнена не верно');
                      }
                    },
                    child: state.status == StateStatus.loading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            Center(child: Text('OR')),
            SizedBox(height: 16),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                    side: BorderSide(color: Color(0xff2B4C59)),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(AppImages.googleLogo, scale: 4),
                    Text(
                      'Continue With Google',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Color(0xff2B4C59)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(AppImages.fbLogo, scale: 4),
                    Text(
                      'Continue With Facebook',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: mq.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Have an account Already?',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),
                GestureDetector(
                  onTap: () {
                    context.router.popAndPush(SignInRoute());
                  },
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: Color(0xffFCC21B),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
