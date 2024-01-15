import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop_app/controllers/product_controller.dart';
import 'package:eshop_app/services/firestore_services.dart';
import 'package:eshop_app/components/CustomAppBar.dart';
import 'package:eshop_app/components/loading_indicator.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../consts/consts.dart';
import '../../views/category/item_details.dart';
import '../../components/bg_widget.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CategotyDeatils extends StatefulWidget {
  final String? title;
  const CategotyDeatils({super.key, required this.title});

  @override
  State<CategotyDeatils> createState() => _CategotyDeatilsState();
}

class _CategotyDeatilsState extends State<CategotyDeatils> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestorServices.getSubCategoryProducts(title);
    } else {
      productMethod = FirestorServices.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();

  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
            appBar: PreferredSize(
              preferredSize: const Size(100, 100),
              child: CustomAppBar(
                pageTitle: Text(
                  '${widget.title}',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: darkFontGrey,
                  ),
                ),
                fIcon: const Icon(TablerIcons.arrow_left, size: 30,),
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
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: "Izaberite podkategoriju: ".text.size(17).color(darkFontGrey).make(),
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        controller.subcat.length,
                        (index) => "${controller.subcat[index]}".text.bold.size(15).color(Colors.red).makeCentered().box.white.rounded.size(150, 60).margin(const EdgeInsets.only(left: 15)).make()
                                .onTap(() {
                                    switchCategory("${controller.subcat[index]}");
                                    setState(() {}
                                );
                            },
                        ),
                    ),
                  ),
                ),
                10.heightBox,
                Divider(),
                10.heightBox,
                StreamBuilder(
                  stream: productMethod,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        child: Center(
                          child: loadingIndicator(),
                        ),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Expanded(
                        child: "Nema pronadjenih prozivoda!".text.size(20).color(darkFontGrey).makeCentered(),
                      );
                    } else {
                      var data = snapshot.data!.docs;

                      return Expanded(
                          child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 230,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 0
                                  ),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      data[index]['p_imgs'][0],
                                      height: 140,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ).box.topRounded(value: 7.5).clip(Clip.antiAlias).make(),
                                    10.heightBox,
                                    // Container(padding: EdgeInsets.symmetric(horizontal: 10),child: "${data[index]['p_name']}".text.bold.size(14).color(darkFontGrey).make()),
                                    // 5.heightBox,
                                    // Container(padding: EdgeInsets.symmetric(horizontal: 10), child: "${data[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make())
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6),
                                      child: Row(
                                        children: [
                                          "${data[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make(),
                                          2.widthBox,
                                          "€".text.color(redColor).fontFamily(bold).size(16).make()
                                        ],
                                      ),
                                    ),
                                    4.heightBox,
                                    Container(padding: EdgeInsets.symmetric(horizontal: 6), child: "${data[index]['p_name']}".text.fontFamily(semibold).size(16).color(darkFontGrey).make()),
                                    4.heightBox,
                                    // Container(padding: EdgeInsets.symmetric(horizontal: 10), child: "Ocjena: ${allproductsData[index]['p_rating']}".text.size(13).color(darkFontGrey).make()),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: golden,
                                            size: 15,
                                          ),
                                          // SizedBox(width: 5),
                                          1.widthBox,
                                          "${data[index]['p_rating']}".text.size(13).color(darkFontGrey).make(),
                                        ],
                                      ),
                                    ),
                                    5.heightBox,
                                  ],
                                ).box.white.margin(const EdgeInsets.symmetric(horizontal: 15)).shadowSm.padding(const EdgeInsets.all(0)).roundedSM.make()
                                    .onTap(() {
                                        controller.checkedIfFav(data[index]);
                                        Get.to(() => ItemDetails(
                                          title: "${data[index]['p_name']}",
                                          data: data[index]
                                        ),);
                                });
                              },
                          ),
                      );
                    }
                  },
                ),
              ],
            )
    );
  }
}
