
import 'package:ffapp/GlobalWidgets.dart';
import 'package:ffapp/Routes/AppRoutes.dart';
import 'package:ffapp/Screen/LoginScreen/LoginScreenController.dart';
import 'package:ffapp/theme/styles.dart';
import 'package:ffapp/utils/paths.dart';
import 'package:ffapp/validatorS.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final controller=Get.put(LoginScreenController());
  final validatorC=Get.put(ValidatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    Text('Login',style: Styles().ExtraboldText.copyWith(fontSize: 18,color: Colors.black,),),
                    // Spacer(),
                    SizedBox(width: Get.width*0.15,)
                  ],
                ),
                // Spacer(),
                SizedBox(height: Get.height*0.1,),
                Form(
                  key: controller.loginGlobalKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                            height: Get.height/5,
                            width: Get.width/2,

                            child: SvgPicture.asset('${AllPaths().imagePath}logo.svg')),
                      ),
                      SizedBox(height: Get.height*0.03,),
                      Center(
                        child: Text('Hey, Login Now',style: Styles().ExtraboldText.copyWith(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w600),),
                      ),
                      SizedBox(height: Get.height*0.02,),
                      Center(child: Text('Welcome back, Please login to\nyour account',textAlign: TextAlign.center,style: Styles().normalText.copyWith(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500),),),
                      SizedBox(height: Get.height*0.05,),
                      CustomTetextField(hintText:'Email',icon: 'email',width: 350,validator: validatorC.emailValidator,controller: controller.emailController,),
                      SizedBox(height: 20,),
                      CustomTetextField(hintText:'Password',icon: 'password',obsecure: true,width: 350,validator: validatorC.passwordValidator,controller: controller.passController,),
                      SizedBox(height: Get.height*0.02,),
                      Center(child:
                      InkWell(
                          onTap: (){
                            Get.toNamed(Routes.forgotScreen);
                          },
                          child: Text('Reset password?',textAlign: TextAlign.center,style: Styles().normalText.copyWith(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),)),),
                      SizedBox(height: Get.height*0.02,),
                      GetBuilder<LoginScreenController>(
                        builder: (__) {
                          return __.processing?CircularProgressIndicator(color: Colors.black,):
                          CustomTextButton(text:'Login',width: 200
                            ,onTap: (){
                            controller.loginUser();
                            // Get.offAndToNamed(Routes.homeScreen);
                          },);
                        }
                      ),
                    ],
                  ),
                ),
                // Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
