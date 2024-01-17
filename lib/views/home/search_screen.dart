import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop_app/consts/consts.dart';
import 'package:eshop_app/services/firestore_services.dart';
import 'package:eshop_app/components/CustomAppBar.dart';
import 'package:eshop_app/components/loading_indicator.dart';
import 'package:get/get.dart';

import '../category/item_details.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size(100, 100),
        child: CustomAppBar(
          pageTitle: Text(
            '${title}',
            style: Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: FontWeight.w500,
              color: darkFontGrey,
            ),
          ),
          fIcon: const Icon(Icons.arrow_back),
          fIconFunction: () {
            Navigator.pop(context);
          },
          isCenter: false,
          horizontalMargin: 0.04,
          sIcon: const Icon(
            Icons.circle,
            color: Colors.transparent,
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirestorServices.searchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(child: "Nema pronađenih proizvoda".text.make());
          } else {
            var data = snapshot.data!.docs;

            var filtered = data
                .where((element) => element['p_name']
                    .toString()
                    .toLowerCase()
                    .contains(title!.toLowerCase()))
                .toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 290
                ),
                children: filtered
                    .mapIndexed(
                      (currentValue, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            filtered[index]['p_imgs'][0],
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ).box.topRounded(value: 7.5).clip(Clip.antiAlias).make(),
                          10.heightBox,
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Row(
                              children: [
                                "${filtered[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make(),
                                2.widthBox,
                                "€".text.color(redColor).fontFamily(bold).size(16).make()
                              ],
                            ),
                          ),
                          4.heightBox,
                          Container(padding: EdgeInsets.symmetric(horizontal: 6), child: "${filtered[index]['p_name']}".text.fontFamily(semibold).size(16).color(darkFontGrey).make()),
                          4.heightBox,
                          // Container(padding: EdgeInsets.symmetric(horizontal: 10), child: "Ocjena: ${allproductsData[index]['p_rating']}".text.size(13).color(darkFontGrey).make()),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(child: "${filtered[index]['p_subcategory']}".text.size(12).color(darkFontGrey).make()),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: golden,
                                      size: 15,
                                    ),
                                    1.widthBox,
                                    "${filtered[index]['p_rating']}".text.size(13).color(darkFontGrey).make(),
                                  ],
                                )
                              ],
                            ),
                          ),
                          5.heightBox,
                        ],
                      ).box.color(lightGrey).outerShadowMd.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.make()
                          .onTap(() {
                              Get.to(() => ItemDetails(
                                  title: "${filtered[index]['p_name']}",
                                  data: filtered[index]));
                            }),
                    )
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
