import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop_app/controllers/cart_controller.dart';
import 'package:eshop_app/services/firestore_services.dart';
import 'package:eshop_app/views/cart/shipping_screen.dart';
import 'package:eshop_app/components/CustomAppBar.dart';
import 'package:eshop_app/components/loading_indicator.dart';
import 'package:eshop_app/components/our_button.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: lightGrey,
        bottomNavigationBar: SizedBox(
          height: 50,
          // child: ourButton(
          //     color: redColor,
          //     onPress: () {
          //       Get.to(() => const ShippingDetails());
          //     },
          //     textColor: whiteColor,
          //     title: "Nastavi sa isporukom"
          // ),
          child: Container(
            // padding: EdgeInsets.symmetric(horizontal: 10.0),
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: redColor,
                padding: EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Get.to(() => const ShippingDetails());
              },
              child: "Nastavi sa isporukom".text.white.fontFamily(bold).make(),
            ),
          ),
        ),
      appBar: PreferredSize(
        preferredSize: const Size(100, 100),
        child: CustomAppBar(
          pageTitle: Text(
            'Korpa za kupovinu',
            style: Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: FontWeight.w500,
              color: darkFontGrey,
            ),
          ),
          isCenter: false,
          horizontalMargin: 0.04,
        ),
      ),
        body: StreamBuilder(
          stream: FirestorServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Korpa je prazna".text.size(20).color(darkFontGrey).makeCentered(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.productSnapshot = data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Image.network(
                                "${data[index]['img']}",
                                width: 90,
                                fit: BoxFit.cover,
                              ).box.roundedSM.clip(Clip.antiAlias).make(),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data[index]['title']}".text.fontFamily(semibold).size(16).make(),
                                  Row(
                                    children: [
                                      "Količina: ".text.fontFamily(semibold).size(14).make(),
                                      "${data[index]['qty']}".text.fontFamily(semibold).color(redColor).size(14).make(),
                                      const SizedBox(width: 4),
                                    ],
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  "${data[index]['tprice']}".numCurrency.text.color(redColor).fontFamily(semibold).make(),
                                  2.widthBox,
                                  "€".text.color(redColor).fontFamily(semibold).size(16).make()
                                ],
                              ),
                              trailing: const Icon(
                                TablerIcons.trash,
                                size: 27,
                                color: redColor,
                              ).onTap(() {
                                FirestorServices.deleteDocument(data[index].id);
                              }),
                            ).box.white.rounded.margin(const EdgeInsets.all(5)).shadowSm.make();
                          },),
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Ukupno: ".text.fontFamily(semibold).color(darkFontGrey).make(),
                        Obx(
                          () => "${controller.totalP.value.toStringAsFixed(2)}€".text.fontFamily(semibold).color(redColor).make(),
                        ),
                      ],
                    ).box.padding(const EdgeInsets.all(13)).color(Colors.grey.shade300).width(context.screenWidth - 25).roundedSM.make(),
                    5.heightBox,
                  ],
                ),
              );
            }
          },
        ),
    );
  }


}
