
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ffapp/GlobalWidgets.dart';
import 'package:ffapp/Routes/AppRoutes.dart';
import 'package:ffapp/Screen/UserProfile/UserProfileController.dart';
import 'package:ffapp/theme/styles.dart';
import 'package:ffapp/utils/paths.dart';
import 'package:ffapp/validatorS.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({Key? key}) : super(key: key);
  final controller=Get.put(UserProfileController());
  final validatorC=Get.put(ValidatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<UserProfileController>(
          builder: (_) {
            return Form(
              key: controller.updateInfoGlobalKey,
              child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: InkWell(
                                  onTap: (){
                                    Get.back();
                                  },
                                  child: Icon(Icons.chevron_left,size: 40,)),
                            ),
                            Spacer(),
                            Text('User Profile',style: Styles().ExtraboldText.copyWith(fontSize: 18,color: Colors.black,),),
                            Spacer(),
                            SizedBox(width: Get.width*0.15,)
                          ],
                        ),
                        SizedBox(height: Get.height*0.01,),
                        // Spacer(),
                        Center(
                          child: Container(
                            height: Get.height*0.15,
                            width: Get.height*0.15,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.withOpacity(0.4),
                                  border: Border.all(color: Colors.black,width: 1),
                                // image: controller.profileImage!=''?DecorationImage(
                                //   fit: BoxFit.cover,
                                //   image: NetworkImage(controller.profileImage),
                                // ):DecorationImage(
                                //   image: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fstackoverflow.com%2Fquestions%2F59501445%2Fflutter-how-to-save-a-file-on-ios&psig=AOvVaw26T9Nkuw483uObYlraZ3GB&ust=1683618575593000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCMDDx4qe5f4CFQAAAAAdAAAAABAE'),
                                // ),
                              ),
                            child: Stack(
                              children: [
                                controller.profileImage!=''?
                                SizedBox(child: ClipRRect(borderRadius: BorderRadius.circular(100000.0),
                                    child: SizedBox(
                                      height: Get.height,
                                      width: Get.width,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: controller.profileImage,
                                        placeholder: (context, url) => CircularProgressIndicator(color: Colors.black,),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                    ),),):
                                SvgPicture.asset('${AllPaths().iconsPath}profile.svg',fit: BoxFit.scaleDown,color: Colors.white,width: Get.height,height: Get.width,),
                                controller.readonlyTextField?SizedBox(): Positioned(
                                    right: 0,
                                    bottom: Get.height*0.01,
                                    child: InkWell(
                                        onTap: (){
                                          Get.dialog(ChangeImagePicker());
                                        },
                                        child: SvgPicture.asset('${AllPaths().iconsPath}camera.svg',fit: BoxFit.scaleDown,width: 40,height: 40,))),
                              ],
                            )
                          ),),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Center(
                            //   child: SizedBox(
                            //     height: Get.height/4,
                            //     width: Get.width/4,
                            //     child: Container(
                            //       decoration: BoxDecoration(
                            //         shape: BoxShape.circle,
                            //         color: Colors.grey.withOpacity(0.4),
                            //         border: Border.all(color: Colors.black,width: 1)
                            //       ),
                            //       height: Get.height/4,
                            //       width: Get.width/4,
                            //       child: Stack(
                            //         children: [
                            //           SvgPicture.asset('${AllPaths().iconsPath}profile.svg',fit: BoxFit.scaleDown,color: Colors.white,width: Get.height,height: Get.width,),
                            //           controller.readonlyTextField?SizedBox():Positioned(
                            //               right: 0,
                            //               bottom: Get.height*0.07,
                            //               child: SvgPicture.asset('${AllPaths().iconsPath}camera.svg',fit: BoxFit.scaleDown,width: 30,height: 30,)),
                            //         ],
                            //       )),
                            //   ),
                            // ),
                            SizedBox(height: Get.height*0.02,),
                            CustomTetextField(hintText:'Name',icon: 'profile',width: 350,readonly:controller.readonlyTextField,controller: controller.nameController,validator: validatorC.nameValidator,),
                            SizedBox(height: Get.height*0.01,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: InternationalPhoneNumberInput(
                                onInputChanged: (PhoneNumber number) {
                                  controller.completePhoneNumber=number.phoneNumber??'';
                                  print(controller.completePhoneNumber);
                                },
                                onInputValidated: (bool value) {
                                  print(value);
                                },
                                selectorConfig: SelectorConfig(
                                  selectorType: PhoneInputSelectorType.DROPDOWN,
                                ),
                                ignoreBlank: false,
                                autoValidateMode: AutovalidateMode.disabled,
                                selectorTextStyle: TextStyle(color: Colors.black),
                                initialValue: controller.number,
                                textFieldController: controller.phoneNumber,
                                formatInput: true,
                                keyboardType:
                                TextInputType.numberWithOptions(signed: true, decimal: true),
                                inputBorder: OutlineInputBorder(),
                                onSaved: (PhoneNumber number) {
                                  print('On Saved: $number');
                                },
                              ),
                            ),
                            SizedBox(height: Get.height*0.1,),
                            controller.processing?CircularProgressIndicator(color: Colors.black,):CustomTextButton(text:controller.readonlyTextField?'Edit Profile':"Save Profile",width: 250,onTap: (){
                              controller.readonlyTextField=!controller.readonlyTextField;
                              if(controller.readonlyTextField){
                                controller.updateInfo();
                              }
                              controller.update();
                              // Get.offAndToNamed(Routes.homeScreen);
                            },),
                          ],
                        ),

                      ],
                    ),
                    controller.imageUploading
                        ?Scaffold(
                      backgroundColor: Colors.black.withOpacity(0.3),
                      body: Center(
                        child: controller.imageUploading
                            ?CircularProgressIndicator(color: Colors.black,)
                            :SizedBox(),
                      ),
                    )
                        :SizedBox()
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
