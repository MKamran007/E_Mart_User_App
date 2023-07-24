import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controllers/home_controller.dart';

class CartController extends GetxController{
  var totalP= 0.obs;

  // Controller for shipping text field
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex = 0.obs;
  late dynamic productSnapshot;
  var vendors = [];

  var products= [];
  var placingOrder= false.obs;

  late int orderProductlength;

  calculate(data){
    totalP.value=0;
    for(var i=0; i< data.length; i++){
      totalP.value= totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index){
    paymentIndex.value = index;
  }

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async{
    placingOrder(true);
    await getProductDetails();
    Future.delayed(const Duration(seconds: 2),() async {
      await firestore.collection(ordersCollection).doc().set({
        'order_code' : "2763547236576",
        'order_date' : FieldValue.serverTimestamp(),
        'order_by' : currentUser!.uid,
        'order_by_name' : Get.find<HomeController>().username,
        'order_by_email' : currentUser!.email,
        'order_by_address' : addressController.text,
        'order_by_state' : stateController.text,
        'order_by_city' : cityController.text,
        'order_by_phone' : phoneController.text,
        'order_by_postalcode' : postalController.text,
        'shipping_method' : "Home Delivery",
        'payment_method' : orderPaymentMethod,
        'order_confirmed' : false,
        'order_delivered' : false,
        'order_on_delivered' : false,
        'order_placed' : true,
        'total_amount' : totalAmount,
        'order' : FieldValue.arrayUnion(products),
        'vendors' : FieldValue.arrayUnion(vendors),
      });
      placingOrder(false);
    });
  }

  getProductDetails(){
    products.clear();
    vendors.clear();
    for(var i=0; i < orderProductlength; i++){
      products.add({
        'color': productSnapshot[i]['color'],
        'img' : productSnapshot[i]['img'],
        'vendor_id' : productSnapshot[i]['vendor_id'],
        'tprice' : productSnapshot[i]['tprice'],
        'qty' : productSnapshot[i]['qty'],
        'title' : productSnapshot[i]['title'],
      });
      vendors.add(productSnapshot[i]['vendor_id']);
    }
  }

  cleanCart(){
    for(var i=0; i < orderProductlength; i++){
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}