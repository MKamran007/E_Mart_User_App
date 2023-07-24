import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controllers/auth_controller.dart';
import 'package:e_mart/views/auth_screens/login_screen.dart';
import 'package:e_mart/views/orders_screen/orders_screen.dart';
import 'package:e_mart/views/wishlist_screen/wishlist_screen.dart';import '../../controllers/profile_controller.dart';


import '../../services/firestore_services.dart';
import '../../widgets_common/bg_widget.dart';
import '../chats_screen/messaging_screen.dart';
import 'components/details_card.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
      Scaffold(
        body: StreamBuilder(
            stream: FireStoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else {
                var data = snapshot.data!.docs[0];
                return SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Align(
                              alignment: Alignment.topRight,
                              child: Icon(Icons.edit, color: whiteColor,)
                          ).onTap(() {
                            controller.nameController.text =data['name'];
                            Get.to(() => EditProfileScreen(data: data,));
                          }),
                        ),
                        10.heightBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              data['imageUrl'] == ''?
                              Image
                                  .asset(
                                imgProfile2, width: 90, fit: BoxFit.cover,)
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make():Image
                                  .network(
                                data['imageUrl'], width: 80, height: 80, fit: BoxFit.cover,)
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make(),
                              5.widthBox,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "${data['name']}".text.white.fontFamily(semibold)
                                        .make(),
                                    "${data['email']}".text.white.fontFamily(
                                        semibold).make(),
                                  ],
                                ),
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Colors.white
                                    )
                                ),
                                onPressed: () async {
                                  Get.put(AuthController()).signupMethod(
                                      context: context);
                                  Get.offAll(() => const LoginScreen());
                                }, child: logout.text
                                  .fontFamily(semibold)
                                  .white
                                  .make(),
                              ),
                            ],
                          ),
                        ),
                        20.heightBox,
                        FutureBuilder(
                            future: FireStoreServices.getCounts(),
                         builder: (BuildContext context, AsyncSnapshot snapshot){
                              if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                     valueColor: AlwaysStoppedAnimation(redColor),
                                    ),
                                  );
                              }else{
                                     var countData = snapshot.data;
                                    return  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        detailsCard(count: countData[0].toString(),
                                            title: "In your cart",
                                            width: context.screenWidth / 3.4),
                                        detailsCard(count: countData[1].toString(),
                                            title: "In your wishlist",
                                            width: context.screenWidth / 3.4),
                                        detailsCard(count: countData[2].toString(),
                                            title: "yours orders",
                                            width: context.screenWidth / 3.4),
                                      ],
                                    );
                                  }
                              }),

                        ListView
                            .separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: lightGrey,
                            );
                          },
                          itemCount: profileButtonsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              onTap: (){
                                switch(index){
                                  case 0:
                                    Get.to(()=>const MyOrdersScreen());
                                    break;
                                  case 1:
                                    Get.to(()=>const WishlistScreen());
                                    break;
                                  case 2:
                                    Get.to(()=>const MessagingScreen());
                                    break;
                                }
                              },
                              leading: Image.asset(
                                profileButtonsIcon[index], width: 22,),
                              title: profileButtonsList[index].text.fontFamily(
                                  bold).color(darkFontGrey).make(),
                            );
                          },
                        )
                            .box
                            .rounded
                            .margin(const EdgeInsets.all(12))
                            .white
                            .padding(const EdgeInsets.symmetric(horizontal: 16))
                            .shadowSm
                            .make()
                            .box
                            .color(redColor)
                            .make(),
                      ],
                    )
                );
              }
            }),
      ),
    );
  }
}




