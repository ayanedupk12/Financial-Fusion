

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffapp/globalModels/supportModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SupportScreenController extends GetxController{
  bool readonlyTextField=true;
  bool processing=false;
  final FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  final FirebaseAuth _auth= FirebaseAuth.instance;

  TextEditingController subjectController = TextEditingController();
  TextEditingController desController = TextEditingController();
  sendSupportMessage()async{
    processing=true;
    update();
    bool result = await InternetConnectionChecker().hasConnection;
    if(result){
      if(subjectController.text.trim()!=''&&desController.text.trim()!=''){
        final user =firebaseFirestore.collection('Support').doc(_auth.currentUser!.uid);
        await user.set(SupportModel(Subject: subjectController.text, Description: desController.text, Date: DateTime.now().toString().split(' ')[0], Id: _auth.currentUser!.uid).toJson());
      }else{
        Get.snackbar('FinancialFusion', 'Unable send empty fields');
      }
    }
    processing=false;
    update();
  }
}