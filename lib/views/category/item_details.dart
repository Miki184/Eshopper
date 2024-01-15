import 'package:eshop_app/controllers/product_controller.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../../components/our_button.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValues();
                Get.back();
              },
              icon: const Icon(TablerIcons.arrow_left, size: 30,)
          ),
          title: title!.text.color(darkFontGrey).fontFamily(bold).makeCentered(),
          actions: [
            GestureDetector(
              onTap: () {
                if(controller.isFav.value){
                  controller.removeFromWishlist(data.id, context);
                } else {
                  controller.addToWishlist(data.id, context);
                }
              },
              child: Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(
                      controller.isFav.value ? TablerIcons.heart_filled : TablerIcons.heart,
                      color: controller.isFav.value ? redColor : darkFontGrey,
                      size: 30,
                    ),
                  )
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VxSwiper.builder(
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1.0,
                            height: 300,
                            itemCount: data['p_imgs'].length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                data['p_imgs'][index],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ).box.roundedSM.clip(Clip.antiAlias).make();
                            }).box.roundedSM.clip(Clip.antiAlias).make(),
                        10.heightBox,
                        "Naziv: ${title!}".text.size(19).color(darkFontGrey).bold.make(),
                        10.heightBox,
                        VxRating(
                          isSelectable: false,
                          value: double.parse(data['p_rating']),
                          onRatingUpdate: (value) {},
                          normalColor: textfieldGrey,
                          selectionColor: golden,
                          count: 5,
                          maxRating: 5,
                          size: 34,
                        ),
                        10.heightBox,
                        "Cijena: ${data['p_price']}€".text.color(redColor).fontFamily(bold).size(18).make(),
                        10.heightBox,
                        Obx(
                          () => Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 110,
                                    child:
                                        "Izaberite boju: ".text.bold.color(darkFontGrey).size(15).make(),
                                  ),
                                  Row(
                                    children: List.generate(
                                        data['p_colors'].length,
                                        (index) => Stack(
                                          alignment: Alignment.center,
                                            children: [
                                              VxBox().size(40, 40).roundedFull.color(Color(data['p_colors'][index]).withOpacity(1.0)).margin(const EdgeInsets.symmetric(horizontal: 4)).make()
                                                  .onTap(()
                                              {controller.changeColorIndex(index);}
                                              ),
                                              Visibility(
                                                  visible: index == controller.colorIndex.value,
                                                  child: Icon(
                                                      Icons.done,
                                                      color: Color(data['p_colors'][index]) == Colors.white ? Colors.black : Colors.white
                                                  )
                                              )
                                            ],
                                      ),
                                    ),
                                  ),
                                ],
                              ).box.color(Color.fromRGBO(245, 245, 245, 1)).roundedSM.padding(const EdgeInsets.symmetric(horizontal: 8, vertical: 10)).make(),
                              10.heightBox,
                              Row(
                                children: [
                                  SizedBox(
                                    width: 65,
                                    child: "Količina: ".text.bold.color(darkFontGrey).size(15).make(),
                                  ),
                                  Obx(
                                    () => Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              controller.decreaseQuantity();
                                              controller.calculateTotalPrice(int.parse(data['p_price']));
                                            },
                                            icon: const Icon(Icons.remove)),
                                        controller.quantity.value.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                        IconButton(
                                            onPressed: () {
                                              controller.increaseQuantity(
                                                  int.parse(data['p_quantity']
                                                  ));
                                              controller.calculateTotalPrice(
                                                  int.parse(data['p_price']));
                                            },
                                            icon: const Icon(Icons.add)),
                                        10.widthBox,
                                        "(${data['p_quantity']} dostupno)".text.color(textfieldGrey).make()
                                      ],
                                    ),
                                  ),
                                ],
                              ).box.white.outerShadowSm.roundedSM.padding(const EdgeInsets.symmetric(horizontal: 8, vertical: 6)).make(),
                              10.heightBox,
                              Container(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 70,
                                      child: "Ukupno: ".text.bold.color(darkFontGrey).size(15).make()
                                    ),
                                    "${controller.totalprice.value}".numCurrency.text.color(redColor).size(16).fontFamily(bold).make(),
                                    2.widthBox,
                                    "€".text.color(redColor).fontFamily(bold).size(16).make()
                                  ],
                                ).box.white.outerShadowSm.roundedSM.padding(const EdgeInsets.symmetric(horizontal: 8, vertical: 18)).make(),
                              ),
                            ],
                          )
                        ),
                        15.heightBox,
                        Container(padding: const EdgeInsets.symmetric(horizontal: 2), child: "Opis: ".text.bold.color(darkFontGrey).size(19).make()),
                        5.heightBox,
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "${data['p_desc']}",
                            style: const TextStyle(
                              color: darkFontGrey,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        10.heightBox,
                        "Prodavac: ${data['p_seller']}".text.color(redColor).fontFamily(bold).size(18).make(),
                        10.heightBox,
            ]),
            ),
              )
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ourButton(
                    color: redColor,
                    onPress: () {
                      if (controller.quantity.value > 0) {
                        controller.addToCart(
                            color: data['p_colors'][controller.colorIndex.value],
                            context: context,
                            vendorID: data['vendor_id'],
                            img: data['p_imgs'][0],
                            qty: controller.quantity.value,
                            sellername: data['p_seller'],
                            title: data['p_name'],
                            tprice: controller.totalprice.value);
                        VxToast.show(context, msg: "Dodato u korpu");
                      } else {
                        VxToast.show(context, msg: "Potreban je minimum 1 proizvod!");
                      }
                    },
                    textColor: whiteColor,
                    title: "Dodaj u korpu"
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
