

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ForgotScreenController extends GetxController {
  final FirebaseAuth _auth= FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  bool processing=false;
  forgotPassword()async{
    processing=true;
    update();
    bool result = await InternetConnectionChecker().hasConnection;
    if(result){
      try{
        await _auth.sendPasswordResetEmail(email:emailController.text).then((value) {
          Get.snackbar('FinancialFusion', "link has been sent to your email for password reset");
        }).onError((error, stackTrace){Get.snackbar('FinancialFusion', 'invalid Email');});
      }catch(e){}
    }else{
      Get.snackbar('FinancialFusion', 'No internet connection');
    }
    processing=false;
    update();
  }
}