

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffapp/Routes/AppRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../gloalController/globalController.dart';
import '../../globalModels/UserInfo.dart';

class SplashScreenController extends GetxController{
  @override
  void onInit() {
    moveScreen();
    super.onInit();
  }
  final FirebaseAuth _auth= FirebaseAuth.instance;
  final FirebaseFirestore firebaseFireStore=FirebaseFirestore.instance;
  final globalController=Get.put(GlobalController());
  moveScreen(){
    Timer(
        Duration(seconds: 3),
            ()async{
              bool result = await InternetConnectionChecker().hasConnection;
              if(result){
                if(_auth.currentUser!=null){
                  if (_auth.currentUser!.emailVerified) {
                    final user =firebaseFireStore.collection('Users').doc(_auth.currentUser!.uid);
                    user.get().then((value){
                      List<dynamic> balanceJson = value['balance'];
                      List<BalanceEntry> balanceF = balanceJson.map((entry) => BalanceEntry.fromJson(entry)).toList();
                      globalController.userInformation=UserInformation(
                          userId: value['userId'],
                          userType: value['userType'],
                          name: value['name'],
                          phone: value['phone'],
                          balance: balanceF,
                          idFrontSide: value['idFrontSide'],
                          email: value['email'],
                          idBackSide: value['idBackSide'],
                          profit: value['profit'], profile: value['profile']??''
                      );
                      Get.toNamed(Routes.homeScreen);
                    });
                  }
                  else {
                    // If the user's email is not verified, send a verification email
                    await _auth.currentUser!.sendEmailVerification();
                    Get.snackbar('FinancialFusion', 'Please check your email to verify your account and login again');
                    Get.offAndToNamed(Routes.welcomeScreen);
                    // return 'Please check your email to verify your account';
                  }
                }else{
                  Get.offAndToNamed(Routes.welcomeScreen);
                }
              }else{
                Get.offAndToNamed(Routes.welcomeScreen);
              }


        }
    );
  }
}