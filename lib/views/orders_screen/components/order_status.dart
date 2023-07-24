import 'package:e_mart/consts/consts.dart';

Widget orderStatus({icon, color, title, showDone}){
  return ListTile(
      leading: Icon(icon, color: color,).box.roundedSM.padding(const EdgeInsets.all(4)).border(color: color).make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title".text.color(darkFontGrey).make(),
          showDone ? const Icon(Icons.cloud_done, color: redColor,): Container(),
        ],
      ),
    ),
  );
}