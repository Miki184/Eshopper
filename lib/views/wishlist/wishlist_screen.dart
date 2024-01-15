import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop_app/consts/consts.dart';
import 'package:eshop_app/services/firestore_services.dart';
import 'package:eshop_app/components/CustomAppBar.dart';
import 'package:eshop_app/components/loading_indicator.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: PreferredSize(
        preferredSize: Size(100, 100),
        child: CustomAppBar(
          pageTitle: Text(
            'Moja Lista Želja',
            style: Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: FontWeight.w500,
              color: darkFontGrey,
            ),
          ),
          fIcon: Icon(Icons.arrow_back),
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
      body: StreamBuilder(
        stream: FirestorServices.getWishlists(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "Još nema liste želja".text.size(20).color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return Container(
              margin: EdgeInsets.only(top: 15.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network(
                              "${data[index]['p_imgs'][0]}",
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                            title: "${data[index]['p_name']}".text.fontFamily(semibold).size(16).make(),
                            subtitle: Row(
                              children: [
                                "${data[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(semibold).make(),
                                2.widthBox,
                                "€".text.color(redColor).fontFamily(semibold).size(16).make()
                              ],
                            ),
                            trailing: Icon(
                              Icons.favorite,
                              color: redColor,
                            ).onTap(() async {
                              await firestore.collection(productsCollection).doc(data[index].id)
                                  .set({
                                      'p_wishlist':
                                      FieldValue.arrayRemove([currentUser!.uid])
                              }, SetOptions(merge: true));
                            }),
                          ).box.white.rounded.shadowSm.margin(const EdgeInsets.symmetric(horizontal: 15, vertical: 5)).make();
                        }),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
