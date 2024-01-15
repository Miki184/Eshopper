import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop_app/controllers/auth_controller.dart';
import 'package:eshop_app/controllers/profile_controller.dart';
import 'package:eshop_app/services/firestore_services.dart';
import 'package:eshop_app/views/orders/orders_screen.dart';
import 'package:eshop_app/views/profile/edit_profile_screen.dart';
import 'package:eshop_app/views/welcome/splash_screen.dart';
import 'package:eshop_app/views/wishlist/wishlist_screen.dart';
import 'package:eshop_app/components/loading_indicator.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

import '../../consts/lists.dart';
import '../../views/profile/components/details_card.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../consts/consts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    final mediaquery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: lightGrey,
            body: StreamBuilder(
            stream: FirestorServices.getUser(currentUser!.uid),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else {
                var data = snapshot.data!.docs[0];

              return SafeArea(
                child: Column(
                  children: [
                    Container(
                      height: (mediaquery.size.height - mediaquery.padding.top) * 0.09,
                      margin: EdgeInsets.symmetric(horizontal: mediaquery.size.width * 0.04),
                      padding: EdgeInsets.only(
                        top: (mediaquery.size.height - mediaquery.padding.top) * 0.018,
                        bottom: (mediaquery.size.height - mediaquery.padding.top) * 0.010,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Moj Nalog',
                            style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: darkFontGrey,
                            ),
                          ),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                  side: const BorderSide(
                                    color: Colors.black,
                                  ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                )
                              ),
                              onPressed: () async {
                                  await Get.put(
                                  AuthController().signoutMethod(context));
                                  Get.offAll(() => const SplashScreen());
                                  },
                              child: logout.text.fontFamily(semibold).black.make()
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          data['imageUrl'] == ''
                              ? Image.asset(
                                  placeholder,
                                  width: 90,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make()
                              : Image.network(
                                  data['imageUrl'],
                                  width: 80,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make(),
                          10.widthBox,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}".text.fontFamily(semibold).size(16).black.make(),
                              5.heightBox,
                              "${data['email']}".text.black.make(),
                            ],
                          )),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: const Icon(
                              TablerIcons.edit,
                              size: 30,
                              color: Colors.black,
                            ).onTap(() {
                              controller.nameController.text = data['name'];

                              Get.to(() => EditProfileScreen(
                                data: data,
                              ),
                              );
                            },
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.heightBox,
                    FutureBuilder(
                      future: FirestorServices.getCounts(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: loadingIndicator());
                        } else {
                          var countData = snapshot.data;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              detailsCard(
                                  count: countData[0].toString(),
                                  title: "u korpi",
                                  width: context.screenWidth / 3.4),
                              detailsCard(
                                  count: countData[1].toString(),
                                  title: "u listi želja",
                                  width: context.screenWidth / 3.4),
                              detailsCard(
                                  count: countData[2].toString(),
                                  title: "narudžbina",
                                  width: context.screenWidth / 3.4),
                            ],
                          );
                        }
                      },
                    ),
                    ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: lightGrey,
                              );
                            },
                            itemCount: profileButtonsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      Get.to(() => const OrdersScreen());
                                      break;
                                    case 1:
                                      Get.to(() => const WishlistScreen());
                                      break;
                                  }
                                },
                                leading: Image.asset(
                                  profileButtonIcons[index],
                                  width: 22,
                                ),
                                title: profileButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                              );
                            }).box.white.rounded.margin(const EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal: 16)).shadowSm.make()
                  ],
                ),
              );
        }
      },
    ),
        );
  }
}
