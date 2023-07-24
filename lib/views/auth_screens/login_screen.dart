import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/views/auth_screens/signup_screen.dart';
import 'package:e_mart/widgets_common/applogo_widget.dart';
import 'package:e_mart/widgets_common/bg_widget.dart';

import '../../controllers/auth_controller.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';
import '../home_screen/home.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Login in to $appname".text.fontFamily(bold).size(20).white.make(),
              15.heightBox,
              Obx(
                  ()=> Column(
                  children: [
                    customTextFiled(hint: emailHint, title: email, isPass: false, controller: controller.emailController),
                    customTextFiled(hint: passwordHint, title: password, isPass: true, controller: controller.passwordController),
                    Align(alignment: Alignment.centerRight, child: TextButton(onPressed: (){}, child: forgetPass.text.make())),
                    5.heightBox,
                   controller.isloading.value? const CircularProgressIndicator(
                     valueColor: AlwaysStoppedAnimation(redColor),
                   ): ourButton(color: redColor, title: login, textColor: whiteColor, onPress: () async{
                      controller.isloading(true);
                      await controller.loginMethod(context: context).then((value) {
                        if(value != null){
                          VxToast.show(context, msg: loggedin);
                        Get.to(()=>const Home());
                        }else{
                          controller.isloading(false);
                        }
                      });
                    }).box.width(context.screenWidth - 50).make(),
                    5.heightBox,
                    createNewAccount.text.color(fontGrey).make(),
                    5.heightBox,
                    ourButton(color: lightGolden, title: signup, textColor: redColor, onPress: (){Get.to(()=> SignupScreen()); }).box.width(context.screenWidth - 50).make(),
                    10.heightBox,
                    loginwith.text.color(fontGrey).make(),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: lightGrey,
                          radius: 23,
                          child: Image.asset(socialIconList[index],width: 30,),
                        ),
                      )),
                    ),
                  ],
                ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
              ),
            ],
          ),
        ),
      )
    );

  }
}
