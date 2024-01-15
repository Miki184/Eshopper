import 'package:eshop_app/controllers/auth_controller.dart';

import '../../consts/consts.dart';
import '../../views/auth/signup_screen.dart';
import '../../views/home/home.dart';
import '../../components/custom_textfield.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    bool areFieldsEmpty() {
      return controller.emailController.text.isEmpty ||
          controller.passwordController.text.isEmpty;
    }

    bool isValidEmail(String email) {
      final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
      return emailRegex.hasMatch(email);
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.17).heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    "Prijavite se".text.color(darkFontGrey).fontFamily(bold).size(35).makeCentered(),
                  ],
                ),
                40.heightBox,
                Obx(
                  () => Column(
                    children: [
                      customTextField(
                          hint: emailHint,
                          title: email,
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          isPass: false,
                          controller: controller.emailController
                      ),
                      customTextField(
                          hint: password,
                          title: password,
                          inputAction: TextInputAction.done,
                          isPass: true,
                          controller: controller.passwordController
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {}, child: forgetPassword.text.fontFamily(regular).color(redColor).make()
                          )
                      ),
                      5.heightBox,
                      controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                         : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            primary: Colors.white,
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: redColor)
                            ),
                          ),
                        onPressed: () async {
                              if(areFieldsEmpty()) {
                                VxToast.show(context, msg: "Molimo Vas popunite polja!");
                              } else if(!isValidEmail(controller.emailController.text)){
                                VxToast.show(context, msg: "Unesite ispravnu email adresu!");
                              } else {
                                controller.isLoading(true);
      
                                await controller
                                    .loginMethod(context: context)
                                    .then((value) {
                                  if (value != null) {
                                    VxToast.show(context, msg: loggedin);
                                    Get.offAll(() => Home());
                                  } else {
                                    controller.isLoading(false);
                                  }
                                });
                              }
                        },
                        child: "Prijavite se".text.color(redColor).fontFamily(bold).make(),
                      ).box.width(context.screenWidth - 45).make(),
                      15.heightBox,
                      createNewAccount.text.color(fontGrey).make(),
                      15.heightBox,
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
                    ],
                  )
                )
              ],
            ).box.padding(EdgeInsets.symmetric(horizontal: 20)).make(),
          ),
        ),
      ),
    );
  }
}
