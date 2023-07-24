import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/views/home_screen/home.dart';

import '../../controllers/cart_controller.dart';
import '../../widgets_common/our_button.dart';
class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      ()=> Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Chose Payment Method".text.color(darkFontGrey).fontFamily(semibold).make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 50,
          child: controller.placingOrder.value? const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ),
          ):ourButton(
              color: redColor,
              title: "Place my Order",
              textColor: whiteColor,
              onPress: () async{
              await controller.placeMyOrder(orderPaymentMethod: paymentMethods[controller.paymentIndex.value],
                   totalAmount: controller.totalP.value);

               await controller.cleanCart();
               VxToast.show(context, msg: "Order placed successfuly");

               Get.offAll(const Home());
              }
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
              ()=> Column(
              children: List.generate(paymentMethodImg.length, (index) {
                return GestureDetector(
                  onTap: (){
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: controller.paymentIndex.value == index ? redColor : Colors.transparent,
                        width: 4,
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 8),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(paymentMethodImg[index], width: double.infinity, height: 120, fit: BoxFit.cover,
                        colorBlendMode: controller.paymentIndex.value == index ? BlendMode.darken : BlendMode.color,
                          color: controller.paymentIndex.value == index ? Colors.black.withOpacity(0.3) : Colors.transparent,
                        ),
                       controller.paymentIndex.value == index? Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            activeColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            value: true,
                            onChanged: (value){},
                          ),
                        ): Container(),

                        Positioned(
                          bottom: 10,
                            right: 10,
                            child: paymentMethods[index].text.fontFamily(semibold).white.size(16).make())
                      ],
                    )
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
