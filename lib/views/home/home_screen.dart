import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop_app/controllers/product_controller.dart';
import 'package:eshop_app/services/firestore_services.dart';
import 'package:eshop_app/views/category/item_details.dart';
import 'package:eshop_app/views/home/search_screen.dart';
import 'package:eshop_app/components/loading_indicator.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

import '../../consts/lists.dart';
import '../../controllers/home_controller.dart';
import '../../components/home_buttons.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../consts/consts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    //var controller = Get.find<ProductController>();
    Get.put(ProductController());
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    Get.to(
                          () => SearchScreen(
                        title: value,
                      ),
                    );
                  }
                },
                controller: controller.searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blue
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: const Icon(TablerIcons.search).onTap(() {
                      if (controller
                          .searchController.text.isNotEmptyAndNotNull) {
                        Get.to(
                          () => SearchScreen(
                            title: controller.searchController.text,
                          ),
                        );
                      }
                    },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: whiteColor,
                    hintText: searchany,
                    hintStyle: const TextStyle(color: textfieldGrey)),
              ),
            ),
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                      aspectRatio: 14 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Container(
                            child: Image.asset(
                          slidersList[index],
                          fit: BoxFit.fill,
                        ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make()
                        );
                      },
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2,
                        (index) => homeButtons(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 2.5,
                            icon: index == 0 ? icTodaysDeal : icFlashDeal,
                            title: index == 0 ? todaysDeal : flashsale),
                      ),
                    ),
                    10.heightBox,
                    VxSwiper.builder(
                      aspectRatio: 14 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSlidersList.length,
                      itemBuilder: (context, index) {
                        return Container(
                            child: Image.asset(
                          secondSlidersList[index],
                          fit: BoxFit.fill,
                        ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make()
                        );
                      },
                    ),
                    20.heightBox,
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(169, 169, 169, 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.color(darkFontGrey).fontFamily(bold).size(18).make(),
                          5.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: FutureBuilder(
                              future: FirestorServices.getFeaturedProducts(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: loadingIndicator(),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "Nema najnovijih proizvoda!".text.fontFamily(regular).white.makeCentered();
                                } else {
                                  var featuredData = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                      featuredData.length,
                                      (index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            featuredData[index]['p_imgs'][0],
                                            width: 155,
                                            height: 140,
                                            fit: BoxFit.cover,
                                          ).box.topRounded(value: 7.5).clip(Clip.antiAlias).make(),
                                          10.heightBox,
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 6),
                                            child: Row(
                                              children: [
                                                "${featuredData[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make(),
                                                2.widthBox,
                                                "€".text.color(redColor).fontFamily(bold).size(16).make()
                                              ],
                                            ),
                                          ),
                                          4.heightBox,
                                          Container(padding: EdgeInsets.symmetric(horizontal: 6), child: "${featuredData[index]['p_name']}".text.fontFamily(semibold).size(16).color(darkFontGrey).make()),
                                          4.heightBox,
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 6),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(child: "${featuredData[index]['p_subcategory']}".text.size(12).fontFamily(regular).color(darkFontGrey).make()),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      color: golden,
                                                      size: 15,
                                                    ),
                                                    1.widthBox,
                                                    "${featuredData[index]['p_rating']}".text.size(13).fontFamily(regular).color(darkFontGrey).make(),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          5.heightBox,
                                        ],
                                      ).box.color(Colors.white).margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(0)).make()
                                          .onTap(() {
                                          Get.to(() => ItemDetails(
                                              title: "${featuredData[index]['p_name']}",
                                              data: featuredData[index]));
                                        },
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                              (index) => homeButtons(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth / 3.5,
                                icon: index == 0 ? icTopCategories : index == 1 ? icBrands : icTopSeller,
                                title: index == 0 ? topCategories : index == 1 ? brand : topSellers,
                          ),
                      ),
                    ),
                    20.heightBox,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: "Svi proizvodi".text.color(darkFontGrey).fontFamily(bold).size(19).bold.make(),
                    ),
                    10.heightBox,
                    StreamBuilder(
                      stream: FirestorServices.allProducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return loadingIndicator();
                        } else {
                          var allproductsData = snapshot.data!.docs;
                          return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allproductsData.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 0,
                                      mainAxisExtent: 290
                                  ),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      allproductsData[index]['p_imgs'][0],
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ).box.topRounded(value: 7.5).clip(Clip.antiAlias).make(),
                                    10.heightBox,
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6),
                                      child: Row(
                                        children: [
                                          "${allproductsData[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make(),
                                          2.widthBox,
                                          "€".text.color(redColor).fontFamily(bold).size(16).make()
                                        ],
                                      ),
                                    ),
                                    4.heightBox,
                                    Container(padding: EdgeInsets.symmetric(horizontal: 6), child: "${allproductsData[index]['p_name']}".text.fontFamily(semibold).size(16).color(darkFontGrey).make()),
                                    4.heightBox,
                                    // Container(padding: EdgeInsets.symmetric(horizontal: 10), child: "Ocjena: ${allproductsData[index]['p_rating']}".text.size(13).color(darkFontGrey).make()),
                                    Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(child: "${allproductsData[index]['p_subcategory']}".text.size(12).color(darkFontGrey).make()),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: golden,
                                              size: 15,
                                            ),
                                            // SizedBox(width: 5),
                                            1.widthBox,
                                            "${allproductsData[index]['p_rating']}".text.size(13).color(darkFontGrey).make(),
                                          ],
                                        )
                                        ],
                                      ),
                                    ),
                                    5.heightBox,
                                  ],
                                ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).shadowSm.roundedSM.make()
                                    .onTap(() {
                                      Get.to(() => ItemDetails(
                                          title:
                                              "${allproductsData[index]['p_name']}",
                                          data: allproductsData[index]));
                                    });
                              });
                        }
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
