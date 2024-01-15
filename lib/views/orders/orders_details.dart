import 'package:eshop_app/consts/consts.dart';
import 'package:eshop_app/views/orders/components/order_place_details.dart';
import 'package:eshop_app/views/orders/components/order_status.dart';
import 'package:eshop_app/components/CustomAppBar.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: Size(100, 100),
        child: CustomAppBar(
          pageTitle: Text(
            'Detalji Porudžbine',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    orderStatus(
                      color: redColor,
                      icon: Icons.done,
                      title: "Postavljeno",
                      showDone: data['order_placed'],
                    ),

                  ],
                ),
              ),
              orderStatus(
                color: Colors.blue,
                icon: Icons.thumb_up,
                title: "Potvrđeno",
                showDone: data['order_confirmed'],
              ),
              orderStatus(
                color: Colors.yellow,
                icon: Icons.car_crash,
                title: "Pri dostavi",
                showDone: data['order_on_delivery'],
              ),
              orderStatus(
                color: Colors.purple,
                icon: Icons.done_all_rounded,
                title: "Isporučeno",
                showDone: data['order_delivered'],
              ),
              5.heightBox,
              Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlaceDetails(
                    d1: data['order_code'],
                    d2: data['shipping_method'],
                    title1: "Kod narudžbe",
                    title2: "Način kupovine",
                  ),
                  orderPlaceDetails(
                    d1: intl.DateFormat()
                        .add_yMd()
                        .format((data['order_date'].toDate())),
                    d2: data['payment_method'],
                    title1: "Datum porudžbine",
                    title2: "Način plaćanja",
                  ),
                  orderPlaceDetails(
                    d1: "Neplaćeni",
                    d2: "Narudžbina",
                    title1: "Status plaćanja",
                    title2: "Status isporuke",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Informacije za isporuku:".text.fontWeight(FontWeight.bold).make(),
                            "${data['order_by_name']}".text.color(redColor).make(),
                            "${data['order_by_email']}".text.color(redColor).make(),
                            "${data['order_by_address']}".text.color(redColor).make(),
                            "${data['order_by_city']}".text.color(redColor).make(),
                            "${data['order_by_state']}".text.color(redColor).make(),
                            "${data['order_by_phone']}".text.color(redColor).make(),
                            "${data['order_by_postalcode']}".text.color(redColor).make(),
                          ],
                        ),
                        SizedBox(
                          width: 115,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Ukupan iznos: ".text.fontWeight(FontWeight.bold).color(redColor).make(),
                              "${data['total_amount']}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make()
                            ],
                          ).box.rounded.white.padding(EdgeInsets.all(10.0)).make(),
                        ),
                      ],
                    ),
                  )
                ],
              ).box.rounded.outerShadowMd.color(lightGrey).make(),
              10.heightBox,
              Divider(),
              10.heightBox,
              "Naručeni proizvodi"
                  .text
                  .size(18)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .makeCentered(),
              10.heightBox,
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                        title1: "Proizvod: ${data['orders'][index]['title']}",
                        title2: "Cijena: ${data['orders'][index]['tprice']}€",
                        d1: "Količina: ${data['orders'][index]['qty']}",
                        d2: "Refundable",
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 30,
                          height: 20,
                          color: Color(data['orders'][index]['color']),
                        ),
                      ),
                    ],
                  ).box.color(lightGrey).rounded.padding(EdgeInsets.only(bottom: 10)).margin(const EdgeInsets.all(5)).shadowSm.make();
                }).toList(),
              ),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
