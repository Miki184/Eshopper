import 'package:eshop_app/consts/consts.dart';
import 'package:eshop_app/controllers/cart_controller.dart';
import 'package:eshop_app/views/cart/payment_method.dart';
import 'package:eshop_app/components/CustomAppBar.dart';
import 'package:eshop_app/components/custom_textfield.dart';
import 'package:eshop_app/components/our_button.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: Size(100, 100),
        child: CustomAppBar(
          pageTitle: Text(
            'Informacije o dostavi',
            style: Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: FontWeight.w500,
              color: darkFontGrey,
            ),
          ),
          fIcon: const Icon(TablerIcons.arrow_left, size: 30),
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
      bottomNavigationBar: SizedBox(
        height: 50,
        child: ourButton(
          onPress: () {
            if (controller.addressController.text.length > 5) {
              Get.to(() => const PaymentMethods());
            } else {
              VxToast.show(context, msg: "Molimo Vas popunite formu!");
            }
          },
          color: redColor,
          textColor: whiteColor,
          title: "Nastavi",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              customTextField(
                  hint: "Adresa",
                  isPass: false,
                  title: "Adresa",
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  controller: controller.addressController
              ),
              customTextField(
                  hint: "Grad",
                  isPass: false,
                  title: "Grad",
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  controller: controller.cityController
              ),
              customTextField(
                  hint: "Država",
                  isPass: false,
                  title: "Država",
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  controller: controller.stateController
              ),
              customTextField(
                  hint: "Poštanski kod",
                  isPass: false,
                  title: "Poštanski kod",
                  inputType: TextInputType.number,
                  inputAction: TextInputAction.next,
                  controller: controller.postalcodeController
              ),
              customTextField(
                  hint: "Telefon",
                  isPass: false,
                  title: "Telefon",
                  inputType: TextInputType.phone,
                  inputAction: TextInputAction.done,
                  controller: controller.phoneController
              ),
            ],
          ),
        ),
      ),
    );
  }
}
