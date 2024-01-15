import '../consts/consts.dart';

Widget customTextField({String? title, String? hint, controller, isPass, inputType, inputAction}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(regular).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: isPass,
        controller: controller,
        keyboardType: inputType,
        textInputAction: inputAction,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 15, bottom: 15, top: 15),
          hintText: hint,
          isDense: true,
          hintStyle: const TextStyle(fontFamily: regular, color: textfieldGrey),
          filled: true,
          fillColor: lightGrey,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: redColor, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          )
        ),
      ),
      5.heightBox,
    ],
  );
}
