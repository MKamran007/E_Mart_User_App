import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Widget exitDialogBox(context){
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(mainAxisSize: MainAxisSize.min,
      children: [
        "Conform".text.fontFamily(bold).size(16).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Are yo sure want to exit?".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
              title: "yes",
              color: redColor,
              textColor: whiteColor,
              onPress: (){
              SystemNavigator.pop();
              }
            ),
            ourButton(
                title: "No",
                color: redColor,
                textColor: whiteColor,
                onPress: (){
                Navigator.pop(context);
                }
            ),
          ],
        )
      ],
    ).box.color(lightGrey).padding(EdgeInsets.all(12)).rounded.make(),
  );
}
