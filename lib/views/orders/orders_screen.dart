import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop_app/consts/consts.dart';
import 'package:eshop_app/services/firestore_services.dart';
import 'package:eshop_app/views/orders/orders_details.dart';
import 'package:eshop_app/components/CustomAppBar.dart';
import 'package:eshop_app/components/loading_indicator.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: PreferredSize(
        preferredSize: Size(100, 100),
        child: CustomAppBar(
          pageTitle: Text(
            'Moje Narudžbine',
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
      body: Container(
        margin: EdgeInsets.only(top: 15.0),
        child: StreamBuilder(
          stream: FirestorServices.getAllOrders(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "Još nema narudžbi".text.size(20).color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: "${index + 1}".text.fontFamily(bold).color(darkFontGrey).xl.make(),
                      title: data[index]['order_code'].toString().text.color(redColor).fontFamily(semibold).make(),
                      subtitle: Row(
                        children: [
                          data[index]['total_amount'].toString().numCurrency.text.fontFamily(bold).make(),
                          2.widthBox,
                          "€".text.fontFamily(bold).size(16).make()
                        ],
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            Get.to(() => OrdersDetails(
                                  data: data[index],
                                ));
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: darkFontGrey,
                          )),
                    ).box.rounded.white.margin(const EdgeInsets.symmetric(horizontal: 15, vertical: 5)).make();
                  });
            }
          },
        ),
      ),
    );
  }
}
