import 'package:eshop_app/consts/consts.dart';

Widget loadingIndicator() {
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}
