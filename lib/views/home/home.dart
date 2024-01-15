import 'package:eshop_app/components/exit_dialog.dart';

import '../../consts/consts.dart';
import '../../controllers/home_controller.dart';
import '../../views/cart/cart_screen.dart';
import '../../views/category/category_screen.dart';
import '../../views/home/home_screen.dart';
import '../../views/profile/profile_screen.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navbarItem = [
      const BottomNavigationBarItem(
          icon: Icon(TablerIcons.home, size: 30),
          label: home
      ),
      const BottomNavigationBarItem(
          icon: Icon(TablerIcons.category, size: 30),
          label: categories),
      const BottomNavigationBarItem(
          icon: Icon(TablerIcons.shopping_cart, size: 30),
          label: cart),
      const BottomNavigationBarItem(
          icon: Icon(TablerIcons.user_circle, size: 30),
          label: account
      ),
    ];

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen()
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(
              () => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              currentIndex: controller.currentNavIndex.value,
              items: navbarItem,
              backgroundColor: whiteColor,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: redColor,
              unselectedItemColor: iconColor,
              selectedLabelStyle: const TextStyle(fontFamily: semibold),
              selectedIconTheme: const IconThemeData(color: redColor),
              onTap: (value) {
                controller.currentNavIndex.value = value;
              }),
        ),
      ),
    );
  }
}
