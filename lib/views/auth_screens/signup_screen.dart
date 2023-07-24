import 'dart:math';

import 'package:e_mart/consts/consts.dart';

import '../../controllers/auth_controller.dart';
import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';
import '../home_screen/home.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
   bool? isCheck = false;
   var controller = Get.put(AuthController());
   // Controller
   var nameController = TextEditingController();
   var emailController = TextEditingController();
   var passwordController = TextEditingController();
   var passwordretypeController = TextEditingController();

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
                "Join the $appname".text.fontFamily(bold).size(20).white.make(),
                15.heightBox,
                Obx(
                    ()=> Column(
                    children: [
                      customTextFiled(hint: nameHint, title: name, controller: nameController, isPass: false),
                      customTextFiled(hint: emailHint, title: email, controller: emailController, isPass: false),
                      customTextFiled(hint: passwordHint, title: password, controller: passwordController, isPass: true),
                      customTextFiled(hint: passwordHint, title: retypePassword, controller: passwordretypeController,isPass: true),
                      5.heightBox,
                      Row(
                        children: [
                          Checkbox(
                            checkColor: redColor,
                              value: isCheck,
                              onChanged:(newValue){
                              setState(() {
                                isCheck = newValue;
                              });
                              }
                          ),
                          Expanded(
                            child: RichText(text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  ),
                                ),
                                TextSpan(
                                  text: termAndCond,
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  ),
                                ),
                                TextSpan(
                                  text: " & ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  ),
                                ),
                                TextSpan(
                                  text: privacypolice,
                                  style: TextStyle(
                                    fontFamily: bold,
                                    color: redColor,
                                  ),
                                ),
                              ]
                            )),
                          )
                        ],
                      ),
                      5.heightBox,
                     controller.isloading.value? const CircularProgressIndicator(
                       valueColor: AlwaysStoppedAnimation(redColor),
                     ): ourButton(color: isCheck == true ? redColor : lightGrey , title: signup, textColor: whiteColor, onPress: () async{
                        if(isCheck != false){
                          controller.isloading(true);
                          try{
                             await controller.signupMethod(context: context, email: emailController.text,
                                 password: passwordController.text).then(
                                     (value) {
                                       return controller.storeUserData(
                                         name: nameController.text,
                                         email: emailController.text,
                                         password: passwordController.text,
                                       );
                                     }).then((value)  {
                                       VxToast.show(context, msg: loggedin);
                                 Get.offAll(()=>Home());
                             });
                          }catch(e){
                           auth.signOut();
                           VxToast.show(context, msg: e.toString());
                           controller.isloading(false);
                          }
                        }
                      }).box.width(context.screenWidth - 50).make(),
                     10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          alreadyHaveAccount.text.color(lightGrey).make(),
                          login.text.color(redColor).make().onTap(() {
                            Get.back();
                          }),
                        ],
                      ),

                    ],
                  ).box.white.rounded.padding(EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
                ),
              ],
            ),
          ),
        )
    );

  }
}
