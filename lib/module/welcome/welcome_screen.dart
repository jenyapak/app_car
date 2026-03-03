import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_app_car/core/config/router/router.gr.dart';
import 'package:flutter_application_1_app_car/core/resources/app_images.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late final SharedPreferences prefs;

  @override
  void initState() {
    checkPhoneNumber();
    super.initState();
  }

  void checkPhoneNumber() async {
    prefs = await SharedPreferences.getInstance();
    final phone = prefs.getString('PHONE');
    if (phone != null && phone.isNotEmpty) {
      // ignore: use_build_context_synchronously
      context.router.popAndPush(HomeRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppImages.welcomeBg, fit: BoxFit.cover),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 26),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: mq.height / 4),
                      Image.asset(AppImages.welcomeLogo, scale: 3),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Rent your dream car from\nthe Best Company',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffF6F6F6).withValues(alpha: 0.81),
                        ),
                      ),
                      SizedBox(height: mq.height * 0.12),
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 50),
                        child: SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffC64949),
                            ),
                            onPressed: () {
                              context.router.push(SignInRoute());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Get Started',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: mq.height * 0.1055),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
