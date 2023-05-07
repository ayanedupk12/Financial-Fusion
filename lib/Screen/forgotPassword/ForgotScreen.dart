import 'package:ffapp/GlobalWidgets.dart';
import 'package:ffapp/Screen/forgotPassword/ForgotController.dart';
import 'package:ffapp/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../validatorS.dart';

class ForgotScreen extends StatelessWidget {
  ForgotScreen({Key? key}) : super(key: key);
  final controller=Get.put(ForgotScreenController());
  final validatorC=Get.put(ValidatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: Icon(Icons.chevron_left,size: 40,)),
                  ),
                  // Spacer(),
                  Text('Reset Password',style: Styles().ExtraboldText.copyWith(fontSize: 18,color: Colors.black,),),
                  // Spacer(),
                  SizedBox(width: Get.width*0.15,)
                ],
              ),
              Spacer(),
              CustomTetextField(hintText:'Email',icon: 'email',width: 350,validator: validatorC.emailValidator,controller: controller.emailController,),
              SizedBox(height: Get.height*0.05,),
              GetBuilder<ForgotScreenController>(
                builder: (__) {
                  return __.processing?CircularProgressIndicator(color: Colors.black,):CustomTextButton(text:'Reset',width: 200
                    ,onTap: (){
                      controller.forgotPassword();
                    },);
                }
              ),
              Spacer(),

            ],
          ),
        ),
      ),
    );
  }
}
