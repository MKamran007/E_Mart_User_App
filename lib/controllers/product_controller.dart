import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var quentity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var subcat = [];

  var isFav = false.obs;

  getSubCategories(title) async{
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decode = categoryModelFromJson(data);
    var s = decode.categories.where((element) => element.name == title).toList();

    for(var e in s[0].subcategory) {
      subcat.add(e);
    }
  }
  changeColorIndex(index){
    colorIndex.value = index;
  }

  increaseQuentity(totalQuentity){
    if(quentity.value < totalQuentity){
      quentity.value++;
    }
  }

  decraseQuentity(){
    if(quentity.value > 0){
      quentity.value--;
    }
  }

  calculateTotalPrice(price){
    totalPrice.value = price * quentity.value;
  }

  addTocart({
    title,img,sellername,color,qty,tprice,context,vendorID
}) async{
    await firestore.collection(cartCollection).doc().set({
     'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'qty': qty,
      'vendor_id' : vendorID,
      'tprice': tprice,
      'added_by': currentUser!.uid,
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
  }

  reSetValues(){
   totalPrice.value= 0;
   quentity.value= 0;
   colorIndex.value= 0;
  }

  addToWishlist(docId, context) async{
    await firestore.collection(productsCollection).doc(docId).set({
    'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added to wishlist");
  }

  removeFromWishlist(docId, context) async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Remove from wishlist");
  }

  checkIfFav(data){
    if(data['p_wishlist'].contains(currentUser!.uid)){
      isFav(true);
    }else{
      isFav(false);
    }
  }
}