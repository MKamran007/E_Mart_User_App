import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  var isloading = false.obs;
  // text Filed controller
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

//  Login Method

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

//  SignUp method

  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // Storing data method
  storeUserData({name, email, password}) async{
    DocumentReference store = await firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set(
        {
          'name': name,
          'email': email,
          'password': password,
          'imageUrl': '',
          'id': currentUser!.uid,
          'order_count': '00',
          'cart_count': '00',
          'wishlist_count': '00',
        }
    );
  }

  // segnout Method

 signoutMethod(context) async{
    try{
   await auth.signOut();
    }catch(e){
    VxToast.show(context, msg: e.toString());
    }
 }
}
