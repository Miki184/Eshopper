import 'dart:io';

import 'package:eshop_app/components/CustomAppBar.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../consts/consts.dart';
import '../../controllers/profile_controller.dart';
import '../../components/custom_textfield.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(100, 100),
        child: CustomAppBar(
          pageTitle: Text(
            'Uredite Nalog',
            style: Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: FontWeight.w500,
              color: darkFontGrey,
            ),
          ),
          fIcon: const Icon(TablerIcons.arrow_left, size: 30),
          fIconFunction: () {
            Navigator.pop(context);
          },
          isCenter: true,
          horizontalMargin: 0.04,
          sIcon: const Icon(
            Icons.circle,
            color: Colors.transparent,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Column(
                    children:[ data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                        ? Image.asset(
                      placeholder,
                      width: 130,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                        : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                        ? Image.network(
                      data['imageUrl'],
                      width: 130,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.file(File(controller.profileImgPath.value),
                        width: 130, fit: BoxFit.cover)
                        .box
                        .roundedFull
                        .clip(Clip.antiAlias)
                        .make(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: redColor,
                          padding: EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          controller.changeImage(context);
                        },
                        child: "Promijeni sliku".text.white.fontFamily(bold).make(),
                      ),
                   ]
                  )
                ).box
                  .white
                  .shadowSm
                  .rounded
                  .padding(EdgeInsets.all(5))
                  .width(double.infinity)
                  .make(),
                // Divider(),
                20.heightBox,
                customTextField(
                    hint: nameHint,
                    title: name,
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    isPass: false,
                    controller: controller.nameController),
                10.heightBox,
                customTextField(
                    hint: passwordHint,
                    title: oldpass,
                    inputType: TextInputType.visiblePassword,
                    inputAction: TextInputAction.next,
                    isPass: true,
                    controller: controller.oldpassController),
                10.heightBox,
                customTextField(
                    hint: passwordHint,
                    title: newpass,
                    inputType: TextInputType.visiblePassword,
                    inputAction: TextInputAction.done,
                    isPass: true,
                    controller: controller.newpassController),
                20.heightBox,
                controller.isLoading.value
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : SizedBox(
                        width: context.screenWidth - 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: redColor,
                            padding: EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            controller.isLoading(true);

                            if (controller.profileImgPath.value.isNotEmpty) {
                              await controller.uploadProfileImage();
                            } else {
                              controller.profileImageLink = data['imageUrl'];
                            }

                            if (data['password'] ==
                                controller.oldpassController.text) {
                              await controller.changeAuthPassword(
                                  email: data['email'],
                                  password: controller.oldpassController.text,
                                  newpassword:
                                  controller.newpassController.text);

                              await controller.updateProfile(
                                  imgUrl: controller.profileImageLink,
                                  name: controller.nameController.text,
                                  password: controller.newpassController.text);
                              VxToast.show(context, msg: "Vaš profil je ažuriran");
                            } else {
                              VxToast.show(context, msg: "Pogrešna stara lozinka");
                              controller.isLoading(false);
                            }
                          },
                          child: "Sačuvaj".text.white.fontFamily(bold).make(),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
