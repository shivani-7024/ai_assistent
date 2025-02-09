import 'package:ai_assistent/Helper/pref.dart';
import 'package:ai_assistent/Screens/home_screen.dart';
import 'package:ai_assistent/Screens/on_boarding_screen.dart';
import 'package:ai_assistent/custom/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Helper/global.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate based on the value of showOnboard
      Get.off(() => Pref.showOnboard ? const OnBoardingScreen() : HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {

    mq = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            const Spacer(flex: 2),
            Card(
              child: Image.asset('assets/images/logo.png',
                  width: mq.width * .45)
            ),
            const Spacer(),
            const CustomLoading(),
            const Spacer()
          ],
        ),
      )
    );
  }
}
