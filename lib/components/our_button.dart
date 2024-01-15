import '../consts/consts.dart';

Widget ourButton({onPress, color, textColor, String? title}) {
  return Container(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        padding: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero
        )
      ),
      onPressed: onPress,
      child: title!.text.color(textColor).fontFamily(bold).make(),
    ),
  );
}
