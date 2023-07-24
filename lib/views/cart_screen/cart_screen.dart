import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:e_mart/views/cart_screen/shipping_screen.dart';
import 'package:e_mart/widgets_common/our_button.dart';

import '../../controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shopping Cart".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: ourButton(
            color: redColor,
            title: "Proceed to Shipping",
            textColor: whiteColor,
            onPress: (){
              Get.to(()=> ShippinDetails());
            }
        ),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getCart(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
          return const Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),),
          );
          }else if(snapshot.data!.docs.isEmpty){
          return Center(
          child: "Cart is empty".text.color(darkFontGrey).make(),
          );
          }else{
          var data= snapshot.data!.docs;
          print("/////////44//////${data.length}");
          controller.calculate(data);
          controller.productSnapshot = data;
          controller.orderProductlength = data.length;

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Expanded(child: ListView.builder(
                  itemCount: data.length,
                    itemBuilder:(BuildContext context, int index){
                    return ListTile(
                      leading: Image.network("${data[index]['img']}",
                      width: 80,
                        fit: BoxFit.cover,
                      ),
                      title: "${data[index]['title']} (x${data[index]['qty']})".text.fontFamily(semibold).size(16).make(),
                      subtitle: "${data[index]['tprice']}".numCurrency.text.fontFamily(semibold).color(redColor).size(16).make(),
                      trailing: const Icon(Icons.delete,color: redColor,).onTap(() {
                        FireStoreServices.deleteDocument(data[index].id);
                      }),
                    );
                    }
                )),
                Obx(
                ()=> Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price".text.fontFamily(semibold).color(darkFontGrey).make(),
                      "${controller.totalP.value}".numCurrency.text.fontFamily(semibold).color(redColor).make()
                    ],
                  ).box.padding(const EdgeInsets.all(12)).color(lightGolden).width(context.screenWidth - 60).roundedSM.make(),
                ),
                10.heightBox,
                // SizedBox(
                //   width: context.screenWidth - 60,
                //   child: ourButton(
                //       color: redColor,
                //       title: "Proceed to Shipping",
                //       textColor: whiteColor,
                //       onPress: (){
                //         Get.to(()=> ShippinDetails());
                //       }
                //   ),
                // ),
              ],
            ),
          );
          }
        })
        );
  }
}

