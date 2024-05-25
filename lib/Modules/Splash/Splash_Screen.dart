import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../shared/network/local/cache_helper.dart';
import '../Home/Home.dart';
import '../On_Boarding/on_boarding_screen.dart';
import '../Sign_In/Sign_In_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateTo();
  }

  navigateTo() async {
    Widget widget = const OnBoardingScreen();
    bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
    String? token = CacheHelper.getData(key: 'token');
    if (onBoarding != null) {
      if (token != null) {
        widget = const Home();
      } else {
        widget = const SignInScreen();
      }
    } else {
      widget = const OnBoardingScreen();
    }
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HexColor("#5F33E1"),
      ),
      child: const Center(
        child: Image(
          image: AssetImage('assets/images/logo.png'),
        ),
      ),
    );
  }
}
