
import 'package:ffapp/GlobalWidgets.dart';
import 'package:ffapp/Routes/AppRoutes.dart';
import 'package:ffapp/theme/styles.dart';
import 'package:ffapp/utils/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: Get.height/3,
              width: Get.width/3,
            child: SvgPicture.asset('${AllPaths().imagePath}introScreen.svg',fit: BoxFit.scaleDown),),
          ),
          SizedBox(height: Get.height*0.05,),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Login or Create',style: Styles().normalText.copyWith(fontSize: 24,color: Colors.black,fontWeight: FontWeight.w600),),
                Text(' Account',style: Styles().boldText.copyWith(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w900),),
              ],
            ),
          ),
          SizedBox(height: Get.height*0.02,),
          Center(child: Text('Please login or create new account',style: Styles().normalText.copyWith(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w400),),),
          SizedBox(height: Get.height*0.05,),
          CustomTextButton(text:'Login',
            onTap: (){
            Get.toNamed(Routes.loginScreen);
            },),
          SizedBox(height: Get.height*0.02,),
          CustomTextButton(text:'Create Account',color: Colors.white,textColor: Colors.black,border: true,
          onTap: (){
            Get.toNamed(Routes.signUpScreen);
          }),
        ],
      ),
    );
  }
}
