import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controllers/home_controller.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:e_mart/views/home_screen/search_screen.dart';

import '../../widgets_common/home_buttons.dart';
import '../categorie_screen/item_details.dart';
import 'components/featured_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchProductController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  suffixIcon: const Icon(Icons.search).onTap(() {
                    if(controller.searchProductController.text.isNotEmptyAndNotNull){
                      Get.to(()=> SearchScreen(title: controller.searchProductController.text,));
                    }
                  }),
                  fillColor: whiteColor,
                  hintText: searchanything,
                  hintStyle: const TextStyle(
                    color: textfieldGrey,
                  ),
                ),
              ),
            ),
         Expanded(
           child: SingleChildScrollView(
             physics: const BouncingScrollPhysics(),
             child: Column(
               children: [
                 VxSwiper.builder(
                     aspectRatio: 16/9,
                     autoPlay: true,
                     height: 150,
                     enlargeCenterPage: true,
                     itemCount: slidersList.length,
                     itemBuilder: (context, index){
                       return Image.asset(
                         slidersList[index],
                         fit: BoxFit.fill,
                       ).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make();
                     }),
                 10.heightBox,
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: List.generate(
                       2,
                           (index) => homeButtons(
                         height: context.screenHeight * 0.14,
                         width: context.screenWidth / 2.5,
                         icon: index == 0 ? icTodaysDeal : icFlashDeal,
                         title: index == 0 ? todaydeal : flashsale,
                       )),
                 ),
                 10.heightBox,
                 VxSwiper.builder(
                     aspectRatio: 16 / 9,
                     autoPlay: true,
                     height: 150,
                     enlargeCenterPage: true,
                     itemCount: secondSlidersList.length,
                     itemBuilder: (context, index){
                       return Image.asset(
                         secondSlidersList[index],
                         fit: BoxFit.fill,
                       ).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make();
                     }),
                 10.heightBox,
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: List.generate(
                       3, (index) => homeButtons(
                     height: context.screenHeight * 0.14,
                     width: context.screenWidth / 3.5,
                     icon: index == 0 ? icTopCategories : index == 1 ? icBrands : icTopSeller,
                     title: index == 0 ? topCategories : index == 1 ? brand : topSellers,
                   )
                   ),
                 ),
                 // featured Categories
                 20.heightBox,
                 Align(alignment: Alignment.centerLeft, child: featuredCategories.text.size(18).color(darkFontGrey).fontFamily(semibold).make()),
                 20.heightBox,
                 SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                   child: Row(
                     children: List.generate(3,
                             (index) => Column(
                               children: [
                                 featuredButtons(icon: freaturedImages1[index], title: freaturedTitles1[index]),
                                 10.heightBox,
                                 featuredButtons(icon: freaturedImages2[index], title: freaturedTitles2[index]),
                               ],
                             )),
                   ),
                 ),

                 ///////// Featured Products
                 10.heightBox,
                 Container(
                   padding: const EdgeInsets.all(12),
                   width: double.infinity,
                   decoration: const BoxDecoration(
                     color: redColor,
                   ),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       featuredProdects.text.white.fontFamily(bold).size(18).make(),
                       SingleChildScrollView(
                         scrollDirection: Axis.horizontal,
                         child: FutureBuilder(
                           future: FireStoreServices.getFeaturedProduct(),
                             builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                               if(!snapshot.hasData){
                                 return const Center(
                                   child: CircularProgressIndicator(
                                     valueColor: AlwaysStoppedAnimation(redColor),
                                   ),
                                 );
                               }else if(snapshot.data!.docs.isEmpty){
                                 return "No featured products".text.white.makeCentered();
                               }else{
                                 var featureData = snapshot.data!.docs;
                                 return Row(
                                   children: List.generate(featureData.length, (index) => Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Image.network(featureData[index]['p_image'][0], width: 130,height: 130,fit: BoxFit.cover,),
                                       10.heightBox,
                                       "${featureData[index]['p_name']}".text.fontFamily(semibold).color(redColor).make(),
                                       10.heightBox,
                                       "${featureData[index]['p_price']}".text.color(darkFontGrey).fontFamily(bold).size(16).make(),
                                     ],
                                   ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(EdgeInsets.all(8)).make().onTap(() {
                                     Get.to(()=>ItemDetails(title: "${featureData[index]['p_name']}", data: featureData[index],),);
                                   }),
                                   ),
                                 );
                               }
                             }
                         ),
                       ),
                     ],
                   ),
                 ),

                 // Third Swiper
                 20.heightBox,
                 VxSwiper.builder(
                     aspectRatio: 16 / 9,
                     autoPlay: true,
                     height: 150,
                     enlargeCenterPage: true,
                     itemCount: secondSlidersList.length,
                     itemBuilder: (context, index){
                       return Image.asset(
                         secondSlidersList[index],
                         fit: BoxFit.fill,
                       ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                     }),
                 20.heightBox,
                 StreamBuilder(
                   stream: FireStoreServices.getAllProduct(),
                     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                     if(!snapshot.hasData){
                       return const Center(
                         child: CircularProgressIndicator(
                           valueColor: AlwaysStoppedAnimation(redColor),
                         ),
                       );
                     }else{
                       var allproductData = snapshot.data!.docs;
                       return GridView.builder(
                           physics: const NeverScrollableScrollPhysics(),
                           shrinkWrap: true,
                           itemCount: allproductData.length,
                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8,crossAxisSpacing: 8, mainAxisExtent: 300),
                           itemBuilder: (context, index) {
                             return Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Image.network(allproductData[index]['p_image'][0], width: 200,height: 200,fit: BoxFit.cover,),
                                 const Spacer(),
                                 10.heightBox,
                                 "${allproductData[index]['p_name']}".text.fontFamily(semibold).color(redColor).make(),
                                 10.heightBox,
                                 "${allproductData[index]['p_price']}".text.color(darkFontGrey).fontFamily(bold).size(16).make(),
                               ],
                             ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(12)).make().onTap(() {
                               Get.to(()=>ItemDetails(title: "${allproductData[index]['p_name']}", data: allproductData[index],),);
                             });
                           }
                       );
                       }
                     }
                 ),
               ],
             ),
           ),
         ),
          ],
        ),
      ),
    );
  }
}
