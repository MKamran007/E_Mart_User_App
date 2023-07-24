import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/services/firestore_services.dart';

import 'order_details.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FireStoreServices.getMyOrders(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            }else if(snapshot.data!.docs.isEmpty){
              return Center(
                child: "No Order yet".text.color(darkFontGrey).makeCentered(),
              );
            }else{
              var data = snapshot.data!.docs;
              return ListView.builder(
                itemCount: data.length,
                  itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    leading: "${[index + 1]}".text.color(darkFontGrey).fontFamily(bold).make(),
                    title:  data[index]['order_code'].toString().text.color(redColor).fontFamily(semibold).make(),
                    subtitle: data[index]['total_amount'].toString().numCurrency.text.fontFamily(bold).make(),
                    trailing: IconButton(onPressed: (){
                      Get.to(()=>OrdersDetails(data: data[index],));
                    }, icon: const Icon(Icons.arrow_forward_ios,color: darkFontGrey,)),
                  );
                  },
              );
            }
          }

      ),
    );
  }
}
