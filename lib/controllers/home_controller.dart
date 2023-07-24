import 'package:e_mart/consts/consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  @override
  void onInit() {
    getUsername();
    super.onInit();
  }
  var currentNavIndex = 0.obs;

  var username= '';

  var searchProductController = TextEditingController();

  getUsername() async {
    var n = await firestore.collection(usersCollection).where('id', isEqualTo: currentUser!.uid).get().then((value){
      if(value.docs.isNotEmpty){
        return value.docs.single['name'];
      }
    });
    username = n;
  }
}