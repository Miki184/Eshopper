import 'package:eshop_app/views/home/home.dart';
import 'package:eshop_app/views/welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../consts/colors.dart';
import '../../consts/consts.dart';
import '../../views/auth/login_screen.dart';
import '../../components/applogo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(Duration(seconds: 3), () {
      // Get.to(() => LoginScreen());

      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => WelcomeScreen());
        } else {
          Get.to(() => Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: redColor,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.04).heightBox,
              "Dobro došli u eShopper".text.color(Colors.white).fontFamily(bold).size(30).makeCentered(),
              60.heightBox,
              applogoWidget(),
              10.heightBox,
              "Verzija 1.0.0".text.fontFamily(bold).size(16).white.make(),
              Spacer(),
              "@Milorad Nedović".text.white.fontFamily(semibold).size(16).make(),
              30.heightBox
            ],
          ),
        ),
      ),
    );
  }
}
