import 'package:e_mart/consts/consts.dart';

Widget customTextFiled({String? title, String? hint, controller, isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.white.fontFamily(semibold).color(redColor).size(16).make(),
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          hintText: hint,
          isDense: false,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: redColor)),
        ),
      ),
     5.heightBox,
    ],
  );
}
