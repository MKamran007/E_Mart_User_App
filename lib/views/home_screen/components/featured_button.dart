import 'package:e_mart/consts/consts.dart';

import '../../categorie_screen/categories_details.dart';

Widget featuredButtons({String? title, icon}){
  return Row(
    children: [
      Image.asset(icon,width: 60,fit: BoxFit.fill,),
      10.widthBox,
      title!.text.color(darkFontGrey).fontFamily(semibold).make()
    ],
  ).box.white.width(200).roundedSM.margin(const EdgeInsets.symmetric(horizontal: 4)).outerShadow.padding(const EdgeInsets.all(4)).make().onTap(() {
    Get.to(()=>CategoriesDetails(title: title,));
  });
}