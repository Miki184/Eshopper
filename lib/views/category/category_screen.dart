import 'package:eshop_app/controllers/product_controller.dart';
import 'package:eshop_app/components/CustomAppBar.dart';

import '../../consts/lists.dart';
import '../../views/category/category_details.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(100, 100),
        child: CustomAppBar(
          pageTitle: Text(
            'Kategorije',
            style: Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: bold,
              color: darkFontGrey,
            ),
          ),
          isCenter: false,
          horizontalMargin: 0.04,
        ),
      ),
        backgroundColor: lightGrey,
        body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 190
            ),
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  Image.asset(
                    categoryImages[index],
                    height: 120,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  25.heightBox,
                  "${categoriesList[index]}".text.color(darkFontGrey).bold.size(14).align(TextAlign.center).make(),
                ],
              ).box.white.rounded.clip(Clip.antiAlias).shadowSm.margin(EdgeInsets.only(bottom: 3.0)).make()
                  .onTap(() {
                    controller.getSubcategories(categoriesList[index]);
                    Get.to(
                      () => CategotyDeatils(
                        title: categoriesList[index],
                      ),
                    );
                },
              );
            }),
          ),
        ),
      );
  }
}
