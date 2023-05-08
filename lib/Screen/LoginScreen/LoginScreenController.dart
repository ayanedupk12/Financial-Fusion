

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffapp/Routes/AppRoutes.dart';
import 'package:ffapp/gloalController/globalController.dart';
import 'package:ffapp/globalModels/UserInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class LoginScreenController extends GetxController{
  GlobalKey<FormState> loginGlobalKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final globalController=Get.put(GlobalController());
  bool processing=false;


  final FirebaseAuth _auth= FirebaseAuth.instance;
  final FirebaseFirestore firebaseFireStore=FirebaseFirestore.instance;


  Future<String?> loginUser() async {
    // Get.toNamed(Routes.homeScreen);
    processing=true;
    update();
    try{
      _auth.signOut();
    }catch(e){}
    bool result = await InternetConnectionChecker().hasConnection;
    if(result){
      if(loginGlobalKey.currentState!.validate()){
        try {

          UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: emailController.text,
            password: passController.text,
          );
          if (userCredential.user != null) {
            if (userCredential.user!.emailVerified) {
              // If the user's email is verified, return the user ID
              // return userCredential.user!.uid;
              final user =firebaseFireStore.collection('Users').doc(userCredential.user!.uid);
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
                    highest: value['highest'],
                    profit: value['profit'], profile: value['profile']??''
                );
                Get.toNamed(Routes.homeScreen);
              });


            }
            else {
              // If the user's email is not verified, send a verification email
              await userCredential.user!.sendEmailVerification();
              Get.snackbar('FinancialFusion', 'Please check your email to verify your account');
              // return 'Please check your email to verify your account';
            }
          } else {
            Get.snackbar('FinancialFusion', 'Unable to sign in with the provided credentials');
            // return 'Unable to sign in with the provided credentials';
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            Get.snackbar('FinancialFusion', 'user not found');
            // return 'No user found with the provided email';
          } else if (e.code == 'wrong-password') {
            Get.snackbar('FinancialFusion', 'Incorrect email or password');
            // return 'Incorrect password provided for the user';
          } else {
            Get.snackbar('FinancialFusion', e.message.toString());
            // return 'An error occurred while signing in: ${e.message}';
          }
        } catch (e) {
          Get.snackbar('FinancialFusion', e.toString());
          // return 'An unexpected error occurred while signing in: ${e.toString()}';
        }
      }
    }else{
      Get.snackbar('FinancialFusion', 'No internet connection');
    }
    processing=false;
    update();
  }

}