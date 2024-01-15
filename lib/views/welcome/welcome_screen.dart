import 'package:eshop_app/views/auth/signup_screen.dart';

import '../../consts/colors.dart';
import '../../consts/consts.dart';
import '../../views/auth/login_screen.dart';
import '../../components/applogo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.05).heightBox,
              Align(
                alignment: Alignment.topLeft,
                child: "Dobro došli u eShopper".text.color(darkFontGrey).fontFamily(bold).size(30).make(),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: "Vrijeme je za kupovinu!".text.color(fontGrey).fontFamily(regular).size(15).make(),
              ),
              50.heightBox,
              applogoWidget(),
              // 10.heightBox,
              // appname.text.fontFamily(bold).size(22).color(darkFontGrey).make(),
              // 5.heightBox,
              // appversion.text.color(darkFontGrey).make(),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  primary: redColor,
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Get.to(() => SignUpScreen());
                },
                child: "Registrujte se".text.white.fontFamily(bold).make(),
              ).box.width(context.screenWidth - 45).make(),
              10.heightBox,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  primary: Colors.white,
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: redColor)
                  ),
                ),
                onPressed: () {
                  Get.to(() => LoginScreen());
                },
                child: "Prijavite se".text.color(redColor).fontFamily(bold).make(),
              ).box.width(context.screenWidth - 45).make(),
              30.heightBox
            ],
          ).box.padding(EdgeInsets.symmetric(horizontal: 20)).make(),
        ),
      ),
    );
  }
}
