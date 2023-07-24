import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:e_mart/widgets_common/bg_widget.dart';
import 'package:e_mart/widgets_common/custom_textfield.dart';
import 'package:e_mart/widgets_common/our_button.dart';

import '../../controllers/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 120,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
              ? Image.network(data['imageUrl'],width: 100,height: 100,
               fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
             :Image.file(
                      File(controller.profileImgPath.value),
                      width: 100,height: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make(),
              5.heightBox,
              ourButton(
                  color: redColor,
                  title: "Change",
                  textColor: whiteColor,
                  onPress: () {
                    controller.changeImage(context);
                  }),
              const Divider(),
              5.heightBox,
              customTextFiled(title: name, hint: nameHint, isPass: false,controller: controller.nameController),
              10.heightBox,
              customTextFiled(
                  title: oldpass, hint: passwordHint, isPass: true,controller: controller.oldpasswordController),
              10.heightBox,
              customTextFiled(
                  title: newpass, hint: passwordHint, isPass: true,controller: controller.newpasswordController),
              10.heightBox,
             controller.isLoading.value? const CircularProgressIndicator(
               valueColor: AlwaysStoppedAnimation(redColor),
             ): SizedBox(
                  width: context.screenWidth - 60,
                  child: ourButton(
                      color: redColor,
                      title: "Save",
                      textColor: whiteColor,
                      onPress: () async{
                        controller.isLoading(true);

                        ////////////////// if image is not selected/////////////

                        if(controller.profileImgPath.value.isNotEmpty){
                          await controller.uploadProfileImage();
                        }else{
                        controller.profileImageLink = data['imageUrl'];
                        }

                        //////////// if old password matches database//////////

                        if(data['password']== controller.oldpasswordController.text){
                          await controller.changeAuthPassword(
                            email: data['email'],
                            password: controller.oldpasswordController.text,
                            newPassword: controller.newpasswordController.text,
                          );

                          await controller.updateProfile(
                            name: controller.nameController.text,
                            password: controller.newpasswordController.text,
                            imgUrl: controller.profileImageLink,
                          );
                          VxToast.show(context, msg: "Updated");
                        }else if(controller.oldpasswordController.text.isEmptyOrNull && controller.newpasswordController.text.isEmptyOrNull){
                          await controller.updateProfile(
                            name: controller.nameController.text,
                            password: data['password'],
                            imgUrl: controller.profileImageLink,
                          );
                          VxToast.show(context, msg: "Image Update");
                        } else{
                          VxToast.show(context, msg: "Some error ocured");
                          controller.isLoading(false);
                        }
                      })),
            ],
          )
              .box
              .shadowSm
              .white
              .rounded
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .make(),
        )
    )
    );
  }
}
