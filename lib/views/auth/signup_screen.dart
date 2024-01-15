import '../../consts/consts.dart';
import '../../controllers/auth_controller.dart';
import '../../views/home/home.dart';
import '../../components/custom_textfield.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    return password.length >= 8;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                "Registrujte se".text.color(darkFontGrey).fontFamily(bold).size(35).make(),
                40.heightBox,
                Obx(
                  () => Column(
                    children: [
                      customTextField(
                          hint: nameHint,
                          title: name,
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          controller: nameController,
                          isPass: false
                      ),
                      customTextField(
                          hint: emailHint,
                          title: email,
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          controller: emailController,
                          isPass: false
                      ),
                      customTextField(
                          hint: passwordHint,
                          title: password,
                          controller: passwordController,
                          inputAction: TextInputAction.done,
                          isPass: true
                      ),
                      // customTextField(
                      //     hint: passwordHint,
                      //     title: retypePassword,
                      //     controller: passwordRetypeController,
                      //     inputAction: TextInputAction.done,
                      //     isPass: true
                      // ),
                      20.heightBox,
                      Row(
                        children: [
                          Checkbox(
                            value: isCheck,
                            onChanged: (newValue) {
                              setState(() {
                                isCheck = newValue;
                              });
                            },
                            activeColor: redColor,
                            checkColor: whiteColor,
                          ),
                          10.widthBox,
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Slažem se sa ",
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: fontGrey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Odredbama i Uslovima",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: redColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: fontGrey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Politikom Privatnosti",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: redColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      20.heightBox,
                      controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                             : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  primary: isCheck == true ? redColor : lightGrey,
                                  padding: EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () async {
                                  if (isCheck != false) {
                                    if (nameController.text.isEmpty ||
                                        emailController.text.isEmpty ||
                                        passwordController.text.isEmpty) {
                                      VxToast.show(context, msg: 'Molimo Vas popunite sva polja!');
                                    } else if (!isValidEmail(emailController.text)) {
                                      VxToast.show(context, msg: 'Unesite ispravnu email adresu!');
                                    } else if (!isValidPassword(passwordController.text)) {
                                      VxToast.show(context, msg: 'Šifra mora sadržavati najmanje 8 znakova!');
                                    } else {
                                      controller.isLoading(true);
                                      try {
                                        await controller.signupMethod(
                                            context: context,
                                            email: emailController.text,
                                            password: passwordController.text).then((value) {
                                          return controller.storeUserData(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              name: nameController.text);
                                        }).then((value) {
                                          VxToast.show(context, msg: loggedin);
                                          Get.offAll(() => const Home());
                                        });
                                      } catch (e) {
                                        auth.signOut();
                                        VxToast.show(context, msg: e.toString());
                                        controller.isLoading(false);
                                      }
                                    }
                                  }
                                },
                                child: "Registrujte se".text.white.fontFamily(bold).make(),
                              ).box.width(context.screenWidth - 45).make(),
                          // : ourButton(
                          //     color: isCheck == true ? redColor : lightGrey,
                          //     title: signup,
                          //     textColor: whiteColor,
                            //   onPress: () async {
                            //     if (isCheck != false) {
                            //       if (nameController.text.isEmpty ||
                            //           emailController.text.isEmpty ||
                            //           passwordController.text.isEmpty) {
                            //         VxToast.show(context, msg: 'Molimo Vas popunite sva polja!');
                            //       } else if (!isValidEmail(emailController.text)) {
                            //         VxToast.show(context, msg: 'Unesite ispravnu email adresu!');
                            //       } else if (!isValidPassword(passwordController.text)) {
                            //         VxToast.show(context, msg: 'Šifra mora sadržavati najmanje 8 znakova!');
                            //       } else {
                            //       controller.isLoading(true);
                            //       try {
                            //         await controller.signupMethod(
                            //             context: context,
                            //             email: emailController.text,
                            //             password: passwordController.text).then((value) {
                            //           return controller.storeUserData(
                            //               email: emailController.text,
                            //               password: passwordController.text,
                            //               name: nameController.text);
                            //         }).then((value) {
                            //           VxToast.show(context, msg: loggedin);
                            //           Get.offAll(() => const Home());
                            //         });
                            //       } catch (e) {
                            //         auth.signOut();
                            //         VxToast.show(context, msg: e.toString());
                            //         controller.isLoading(false);
                            //       }
                            //     }
                            //   }
                            // },
                            //   onPress: () async {
                            //     if (isCheck != false) {
                            //       controller.isLoading(true);
                            //       try {
                            //         await controller
                            //             .signupMethod(
                            //                 context: context,
                            //                 email: emailController.text,
                            //                 password: passwordController.text)
                            //             .then((value) {
                            //           return controller.storeUserData(
                            //               email: emailController.text,
                            //               password: passwordController.text,
                            //               name: nameController.text);
                            //         }).then((value) {
                            //           VxToast.show(context, msg: loggedin);
                            //           Get.offAll(() => const Home());
                            //         });
                            //       } catch (e) {
                            //         auth.signOut();
                            //         VxToast.show(context, msg: e.toString());
                            //         controller.isLoading(false);
                            //       }
                            //     }
                            //   },
                            // ).box.width(context.screenWidth - 50).make(),
                      50.heightBox,
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Već imate nalog?",
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: fontGrey,
                              ),
                            ),
                            WidgetSpan(
                                child: SizedBox(width: 5,)
                            ),
                            TextSpan(
                              text: "Prijavite se",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: redColor,
                              ),
                            )
                          ],
                        ),
                      ).onTap(() {
                        Get.back();
                      }),
                      20.heightBox
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
