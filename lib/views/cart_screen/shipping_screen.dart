import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/views/cart_screen/payment_method.dart';
import 'package:e_mart/widgets_common/custom_textfield.dart';

import '../../controllers/cart_controller.dart';
import '../../widgets_common/our_button.dart';

class ShippinDetails extends StatelessWidget {
  const ShippinDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shopping Info".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: ourButton(
            color: redColor,
            title: "Continue",
            textColor: whiteColor,
            onPress: (){
           if(controller.addressController.text.length > 10){
             Get.to(()=>PaymentMethod());
           }else{
             VxToast.show(context, msg: "Please fill all field");
           }
            }
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextFiled(hint: "Address",isPass: false, title: "Address", controller: controller.addressController),
            customTextFiled(hint: "City", isPass: false, title: "City", controller: controller.cityController),
            customTextFiled(hint: "State",isPass: false, title: "State", controller: controller.stateController),
            customTextFiled(hint: "Postel code",isPass: false, title: "Postel code", controller: controller.postalController),
            customTextFiled(hint: "Phone",isPass: false, title: "Phone", controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
