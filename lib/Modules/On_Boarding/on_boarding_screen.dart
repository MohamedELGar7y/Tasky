import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tasky/Modules/Sign_In/Sign_In_Screen.dart';
import '../../shared/network/local/cache_helper.dart';
import '../Home/Home.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: buildBoardingItem(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0, left: 16, right: 16),
              child: MaterialButton(
                onPressed: () {
                  submit();
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: HexColor('#5F33E1'),
                      borderRadius: BorderRadius.circular(12)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Let’s Start",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image(
                        image: AssetImage('assets/images/Arrow - Left.png'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const SignInScreen(),
            ),
            (route) => false);
      }
    });
  }

  Widget buildBoardingItem() => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            Expanded(child: Image.asset('assets/images/board.png')),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 270,
                  child: Text(
                    'Task Management & To-Do List',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: HexColor('#24252C'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 270,
                  child: Text(
                    'This productive tool is designed to help you better manage your task project-wise conveniently!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: HexColor('#6E6A7C'),
                      height: 2,
                    ),
                    //maxLines: 3,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
