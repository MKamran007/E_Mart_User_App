import 'package:e_mart/consts/consts.dart';

import '../../controllers/product_controller.dart';
import '../../widgets_common/our_button.dart';
import '../chats_screen/chat_screen.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({Key? key, required this.title,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async{
        controller.reSetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            controller.reSetValues();
            Get.back();
          }, icon: const Icon(Icons.arrow_back)),
          title: title!.text.fontFamily(bold).color(darkFontGrey).make(),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            Obx(()=>
               IconButton(
                  onPressed: () {
                    if(controller.isFav.value){
                      controller.removeFromWishlist(data.id, context);
                    }else{
                      controller.addToWishlist(data.id, context);
                    }
                  }, icon: Icon(Icons.favorite, color: controller.isFav.value ? redColor : darkFontGrey,)),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                          autoPlay: true,
                          height: 300,
                          itemCount: data['p_image'].length,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data['p_image'][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }),
                      10.heightBox,
                      //  title and details section
                      title!.text.color(darkFontGrey).fontFamily(semibold).make(),
                      //  ratting
                      VxRating(
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        isSelectable: false,
                        count: 5,
                        maxRating: 5,
                        size: 25,
                        stepInt: false,
                      ),
                      10.heightBox,
                      "${data['p_price']}".numCurrency
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(18)
                          .make(),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seler".text.fontFamily(semibold).white.make(),
                              5.heightBox,
                              "${data['p_seller']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .size(18)
                                  .make(),
                            ],
                          )),
                           const CircleAvatar(
                            backgroundColor: whiteColor,
                            child: Icon(
                              Icons.message_rounded,
                              color: darkFontGrey,
                            ),
                          ).onTap(() {
                            Get.to(()=>ChatScreen(),
                            arguments: [
                              data['p_seller'], data['vendor_id']
                            ],
                            );
                          }),
                        ],
                      )
                          .box
                          .color(textfieldGrey)
                          .padding(EdgeInsets.symmetric(horizontal: 15))
                          .height(60)
                          .make(),
                      10.heightBox,
                      //  colors section
                      Obx(
                        ()=> Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child:
                                      "Colors : ".text.color(textfieldGrey).make(),
                                ),
                                Row(
                                  children: List.generate(
                                      data['p_colors'].length,
                                      (index) =>Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          VxBox()
                                              .size(30, 30)
                                              .margin(
                                              const EdgeInsets.symmetric(horizontal: 8))
                                              .roundedFull
                                              .color(Color(data['p_colors'][index]))
                                              .make().onTap(() {
                                                controller.changeColorIndex(index);
                                          }),
                                         Visibility(
                                           visible: index == controller.colorIndex.value,
                                             child:  const Icon(Icons.done,color: Colors.white,))
                                        ],
                                      )),
                                ),
                              ],
                            ).box.padding(EdgeInsets.all(8)).make(),

                            // Quentity Row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child:
                                  "Quentity : ".text.color(textfieldGrey).make(),
                                ),
                                Obx(()=>
                                   Row(
                                    children: [
                                      IconButton(
                                          onPressed: (){
                                            controller.decraseQuentity();
                                            controller.calculateTotalPrice(int.parse(data['p_price']));
                                          },
                                          icon: Icon(Icons.remove)
                                      ),
                                      controller.quentity.value.text.color(darkFontGrey).size(16).fontFamily(bold).make(),
                                      IconButton(
                                          onPressed: (){
                                            controller.increaseQuentity(int.parse(data['p_quentity']));
                                            controller.calculateTotalPrice(int.parse(data['p_price']));
                                          },
                                          icon: Icon(Icons.add)
                                      ),
                                      "(${data['p_quentity']} available)".text.color(textfieldGrey).make(),
                                    ],
                                  ),
                                ),
                              ],
                            ).box.padding(EdgeInsets.all(8)).make(),

                            // Totals
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child:
                                  "Total : ".text.color(textfieldGrey).make(),
                                ),
                               "${controller.totalPrice.value}".numCurrency.text.color(redColor).size(16).fontFamily(bold).make(),
                              ],
                            ).box.padding(EdgeInsets.all(8)).make(),
                          ],
                        ).box.white.shadowSm.make(),
                      ),
                    10.heightBox,
                    //////Descriptions
                      "Descriptions".text.color(darkFontGrey).fontFamily(semibold).make(),
                      10.heightBox,
                      "${data['p_desc']}".text.color(darkFontGrey).make(),
                      10.heightBox,
                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(ItemsDetailButtonsList.length, (index) => ListTile(
                          title: "${ItemsDetailButtonsList[index]}".text.fontFamily(semibold).color(darkFontGrey).make(),
                          trailing: Icon(Icons.arrow_forward),
                        )),
                      ),
                    20.heightBox,
                    //  Products you may like
                      productyoumaylike.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
                      10.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(6, (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(imgP1, width: 150,fit: BoxFit.cover,),
                              10.heightBox,
                              "Laptop 4GB/64GB".text.fontFamily(semibold).color(redColor).make(),
                              10.heightBox,
                              "\$600".text.color(darkFontGrey).fontFamily(bold).size(16).make(),
                            ],
                          ).box.white.margin(EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(EdgeInsets.all(8)).make(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ourButton(
                  color: redColor,
                  onPress: (){
                    if(controller.quentity.value > 0){
                      controller.addTocart(
                        color: data['p_colors'][controller.colorIndex.value],
                        context: context,
                        img: data['p_image'][0],
                        qty: controller.quentity.value,
                        vendorID: data['vendor_id'],
                        sellername: data['p_seller'],
                        title: data['p_name'],
                        tprice: controller.totalPrice.value,
                      );
                      VxToast.show(context, msg: "Added to cart");
                    }else{
                      VxToast.show(context, msg: "Minimum 1 product is required");
                    }
                  },
                  textColor: whiteColor,
                  title: "Add to cart"),
            ),
          ],
        ),
      ),
    );
  }
}
