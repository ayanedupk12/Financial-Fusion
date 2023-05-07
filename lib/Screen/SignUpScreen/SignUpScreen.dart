
import 'package:ffapp/GlobalWidgets.dart';
import 'package:ffapp/Routes/AppRoutes.dart';
import 'package:ffapp/Screen/SignUpScreen/SignUpScreenController.dart';
import 'package:ffapp/theme/styles.dart';
import 'package:ffapp/utils/paths.dart';
import 'package:ffapp/validatorS.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final controller=Get.put(SignUpScreenController());
  final validatorC=Get.put(ValidatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Form(
            key: controller.signUpGlobalKey,
            child: SingleChildScrollView(
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
                      Text('Sign Up',style: Styles().ExtraboldText.copyWith(fontSize: 18,color: Colors.black,),),
                      Spacer(),
                      SizedBox(width: Get.width*0.15,)
                    ],
                  ),
                  SizedBox(height:Get.height*0.02),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: Get.height*0.02,),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Welcome',style: Styles().ExtraboldText.copyWith(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w600),),],
                        ),
                      ),
                      SizedBox(height: Get.height*0.02,),
                      Center(child: Text('Please create your account',textAlign: TextAlign.center,style: Styles().normalText.copyWith(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500),),),
                      SizedBox(height: Get.height*0.05,),
                      CustomTetextField(hintText:'Name',icon: 'profile',width: 350,controller: controller.nameController,validator: validatorC.nameValidator,),
                      SizedBox(height: 20,),
                      CustomTetextField(hintText:'Email',icon: 'email',width: 350,validator: validatorC.emailValidator,controller: controller.emailController,),
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
                      SizedBox(height: 20,),
                      CustomTetextField(hintText:'Password',icon: 'password',obsecure: true,width: 350,validator: validatorC.passwordValidator,controller: controller.passController,),
                      SizedBox(height: Get.height*0.02,),
                      CustomTetextField(hintText:'Confirm Password',icon: 'password',obsecure: true,width: 350,validator: validatorC.passwordValidator,controller: controller.cPassController,),
                      SizedBox(height: Get.height*0.02,),
                      Text('Upload Identity',style: TextStyle(color: Colors.blue),),
                      SizedBox(height: Get.height*0.01,),
                      GetBuilder<SignUpScreenController>(
                        builder: (__) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              InkWell(
                                  onTap: (){
                                    Get.dialog(ImagePickerClass(side: 'Front',));
                                  },
                                  child: Text(controller.frontSide!=null?controller.frontSide!.split('/').last.split('.').first:'Front side')),
                              SizedBox(width: 50,),
                              InkWell(
                                  onTap: (){
                                    Get.dialog(ImagePickerClass(side: 'Back',));
                                  },
                                  child: Text(controller.backSide!=null?controller.backSide!.split('/').last.split('.').first:'Back side')),
                            ],),
                          );
                        }
                      ),
                      GetBuilder<SignUpScreenController>(
                        builder: (__) {
                          return __.processing?CircularProgressIndicator(color: Colors.black,):CustomTextButton(text:'Sign Up',width: 200,onTap: (){
                            controller.signUp();
                            // Get.offAndToNamed(Routes.homeScreen);
                          },);
                        }
                      ),
                    ],
                  ),
                  SizedBox(height:Get.height*0.02),
                  // Spacer(),
                 Center(
                   child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Already have an account?   ',textAlign: TextAlign.center,style: Styles().normalText.copyWith(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500),),
                        InkWell(
                            onTap: (){
                              Get.offAndToNamed(Routes.loginScreen);
                            },
                            child: Text('Login',textAlign: TextAlign.center,style: Styles().boldText.copyWith(fontSize: 16,color: Colors.black),)),
                      ],
                    ),
                 ),
                  SizedBox(height:Get.height*0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
