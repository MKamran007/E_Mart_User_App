import 'package:e_mart/consts/consts.dart';

class FireStoreServices {
  static getUser(uid){
    return firestore.collection(usersCollection).where('id', isEqualTo: uid).snapshots();
  }

//  get the producta collections

static getProduct(category){
    return firestore.collection(productsCollection).where('p_category', isEqualTo: category).snapshots();
}

//  get the subcategory product

  static getSubCategoryProducts(title){
    return firestore.collection(productsCollection).where('p_subcategory', isEqualTo: title).snapshots();
  }

//  get the Cart collections
  static getCart(uid){
    return firestore.collection(cartCollection).where('added_by', isEqualTo: uid).snapshots();
  }

  //  get the Cart delete
  static deleteDocument(docId){
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  //  get the Chat message
  static getChatMessages(docId){
    return firestore.collection(chatCollection).doc(docId).collection(messageCollection).orderBy('created_on', descending: false).snapshots();
  }

  //  get the My Orders
  static getMyOrders(){
    return firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).snapshots();
  }

  //  get the My Wishlist
  static getMyWishlist(){
    return firestore.collection(productsCollection).where('p_wishlist',arrayContains: currentUser!.uid).snapshots();
  }

  //  get the all messages
  static getAllMessages(){
    return firestore.collection(chatCollection).where('fromId',isEqualTo: currentUser!.uid).snapshots();
  }

  static getCounts() async{
    var res = await Future.wait([
     firestore.collection(cartCollection).where('added_by',isEqualTo: currentUser!.uid).get().then((value) {
       return value.docs.length;
    }),
    ////////
      firestore.collection(productsCollection).where('p_wishlist',arrayContains: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
    //////////
      firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  //  get all product
  static getAllProduct(){
    return firestore.collection(productsCollection).snapshots();
  }

  //  get all featured product
  static getFeaturedProduct(){
    return firestore.collection(productsCollection).where('is_featured', isEqualTo: true).get();
  }

  //  get all search product
  static getSearchProduct(title){
    return firestore.collection(productsCollection).get();
  }
}