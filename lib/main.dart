import 'package:flutter/material.dart';
import 'package:flutter_application_1_app_car/core/config/router/router.dart';
import 'package:flutter_application_1_app_car/module/authorization/data/auth_repository.dart';
import 'package:flutter_application_1_app_car/module/authorization/domain/usecase/sign_in_usecase.dart';
import 'package:flutter_application_1_app_car/module/authorization/domain/usecase/sign_up_usecase.dart';
import 'package:flutter_application_1_app_car/module/authorization/presentation/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final appRouter = AppRouter();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            signInUsecase: SignInUsecase(
              authDomainRepository: AuthRepository(),
            ),
            signUpUsecase: SignUpUsecase(
              authDomainRepository: AuthRepository(),
            ),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter.config(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
