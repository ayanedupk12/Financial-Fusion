
import 'package:ffapp/GlobalWidgets.dart';
import 'package:ffapp/Routes/AppRoutes.dart';
import 'package:ffapp/Screen/UserProfile/UserProfileController.dart';
import 'package:ffapp/theme/styles.dart';
import 'package:ffapp/utils/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({Key? key}) : super(key: key);
  final controller=Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<UserProfileController>(
          builder: (_) {
            return SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                          height: Get.height/4,
                          width: Get.width/4,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.4),
                              border: Border.all(color: Colors.black,width: 1)
                            ),
                            height: Get.height/4,
                            width: Get.width/4,
                            child: Stack(
                              children: [
                                SvgPicture.asset('${AllPaths().iconsPath}profile.svg',fit: BoxFit.scaleDown,color: Colors.white,width: Get.height,height: Get.width,),
                                controller.readonlyTextField?SizedBox():Positioned(
                                    right: 0,
                                    bottom: Get.height*0.07,
                                    child: SvgPicture.asset('${AllPaths().iconsPath}camera.svg',fit: BoxFit.scaleDown,width: 30,height: 30,)),
                              ],
                            )),
                        ),
                      ),
                      SizedBox(height: Get.height*0.02,),
                      CustomTetextField(hintText:'Name',icon: 'profile',width: 350,readonly:controller.readonlyTextField),
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
                      CustomTextButton(text:controller.readonlyTextField?'Edit Profile':"Save Profile",width: 250,onTap: (){
                        controller.readonlyTextField=!controller.readonlyTextField;
                        controller.update();
                        // Get.offAndToNamed(Routes.homeScreen);
                      },),
                    ],
                  ),

                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
