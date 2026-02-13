import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_app_car/core/base/base_state.dart';
import 'package:flutter_application_1_app_car/core/config/router/router.gr.dart';
import 'package:flutter_application_1_app_car/core/enum/state_status.dart';
import 'package:flutter_application_1_app_car/core/resources/app_images.dart';
import 'package:flutter_application_1_app_car/module/authorization/presentation/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _isPasswordVisible = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _isPasswordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 38),
        children: [
          SizedBox(height: mq.height * 0.0844),
          Text('Sign In', style: TextStyle(fontSize: 48)),
          SizedBox(height: mq.height * 0.097),
          Text('EMAIL OR PHONE', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          TextField(
            controller: _phoneController,
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
              return TextField(
                controller: _passwordController,
                obscureText: isVisible == false,

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
                context.router.popAndPush(HomeRoute());
              }
              if (state.status == StateStatus.error) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message ?? '')));
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
                    context.read<AuthBloc>().add(
                      SingInEvent(
                        phone: _phoneController.text,
                        password: _passwordController.text,
                      ),
                    );
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
                  Text('Continue With Google', style: TextStyle(fontSize: 16)),
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
                'Don’t Have an account yet?',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
              GestureDetector(
                onTap: () {
                  context.router.popAndPush(SignUpRoute());
                },
                child: Text(
                  'SIGN UP',
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
    );
  }
}
