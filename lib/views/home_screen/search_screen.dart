import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/services/firestore_services.dart';

import '../categorie_screen/item_details.dart';

class SearchScreen extends StatelessWidget {
 final String? title;
 const SearchScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${title}".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FireStoreServices.getSearchProduct(title),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return Center(
              child:"No Product Found".text.fontFamily(semibold).color(darkFontGrey).make(),
            );
          }else{
            var data = snapshot.data!.docs;
            var filltered = data.where((element) => element['p_name'].toString().toLowerCase().contains(title!.toLowerCase())).toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8,crossAxisSpacing: 8, mainAxisExtent: 300),
              children: filltered.mapIndexed((currentValue, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(filltered[index]['p_image'][0], width: 200,height: 200,fit: BoxFit.cover,),
                  const Spacer(),
                  10.heightBox,
                  "${filltered[index]['p_name']}".text.fontFamily(semibold).color(redColor).make(),
                  10.heightBox,
                  "${filltered[index]['p_price']}".text.color(darkFontGrey).fontFamily(bold).size(16).make(),
                ],
              ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).shadowMd.roundedSM.padding(const EdgeInsets.all(12)).make().onTap(() {
                Get.to(()=>ItemDetails(title: "${filltered[index]['p_name']}", data: filltered[index],),);
                }),
               ).toList(),
              ),
            );
            }
           }
      ),
    );
  }
}
