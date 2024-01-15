import 'package:eshop_app/views/category/category_details.dart';
import 'package:get/get.dart';

import '../../../consts/consts.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .width(200)
      .margin(EdgeInsets.symmetric(horizontal: 4))
      .padding(EdgeInsets.all(8))
      .roundedSM
      .outerShadowSm
      .make()
      .onTap(() {
    Get.to(() => CategotyDeatils(title: title));
  });
}
