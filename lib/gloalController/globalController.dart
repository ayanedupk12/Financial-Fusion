

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffapp/globalModels/AppCalculations.dart';
import 'package:ffapp/globalModels/UserInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class GlobalController extends GetxController{
  final FirebaseAuth _auth= FirebaseAuth.instance;
  final FirebaseFirestore firebaseFireStore=FirebaseFirestore.instance;
  @override
  void onInit() async{
    await checkAllPermissions();
    await getUserInfo();
    await getAppPreviewCalculations();

    update();
    super.onInit();
  }
  getUserInfo()async{
    final user =firebaseFireStore.collection('Users').doc(_auth.currentUser!.uid);
    await user.get().then((value){
      List<dynamic> balanceJson = value['balance'];
      List<BalanceEntry> balanceF = balanceJson.map((entry) => BalanceEntry.fromJson(entry)).toList();
      userInformation=UserInformation(
          userId: value['userId'],
          userType: value['userType'],
          name: value['name'],
          phone: value['phone'],
          balance: balanceF,
          idFrontSide: value['idFrontSide'],
          email: value['email'],
          idBackSide: value['idBackSide'],
          highest: value['highest'].toDouble(),
          profit: value['profit'].toDouble(), profile: value['profile']??''
      );

    });
    update();
  }
  UserInformation? userInformation;
  AppCalculations? appPreviewCalculations;
  double totalPreviewBalance=0;
  double previousValue=0;
  bool rise=false;
  double max=0;
  // getMax(){
  //   max = userInformation!.balance.reduce((value, element) => value.amount > element.amount ? value : element).amount;
  // }
  bool cPerm=false;
  bool sPerm=false;
  checkAllPermissions()async{
    cPerm =await checkCameraPermission();
    sPerm =await checkStoagePermission();
  }

  Future pickImage(ImageSource source)async{
    try{
      final image= await ImagePicker().pickImage(source: source);
      if(image==null) return;
      final tempimage = File(image.path);
      var dir = await getApplicationDocumentsDirectory();
      String tempPath='';
      for(int i=0;i<6;i++){
        if(i==5){
          tempPath=tempPath+dir.path.split('/')[i]+'/BrainBook/'+DateTime.now().toString().replaceAll(' ', '').replaceAll('-', '');
          final path=Directory(tempPath);
          if (!await path.exists()) {
            await path.create(recursive: true);
          }
          tempPath=tempPath+'png';
          await tempimage.copy(tempPath);
        }else{
          tempPath=tempPath+dir.path.split('/')[i]+'/';
        }
      }
      return tempPath;

    }on PlatformException catch(e){
      // toastmessage(e);
    }
  }

  Future<bool> checkCameraPermission() async {
    PermissionStatus cameraPermissionStatus = await Permission.camera.request();
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>\ncamera permission >> " + cameraPermissionStatus.name);
    if (cameraPermissionStatus.name == "granted") {
      return true;
    } else if (cameraPermissionStatus.name == "denied") {
      return false;
    } else {
      return false;
    }
  }

  Future<bool> checkStoagePermission() async {
    PermissionStatus storagePermissionStatus = await Permission.storage.request();
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>\ncamera permission >> " + storagePermissionStatus.name);
    if (storagePermissionStatus.name == "granted") {
      return true;
    } else if (storagePermissionStatus.name == "denied") {
      return false;
    } else {
      return false;
    }
  }


  getAppPreviewCalculations()async{
    // final user =firebaseFirestore.collection('Users').doc(userId);
    final userRef = firebaseFireStore.collection('Admin').doc('AppPreviewCalculation');
    final userData = await userRef.get();
    if(userData.exists){
      appPreviewCalculations=AppCalculations.fromFirestore(userData);
      update();
    }else{
      // await userRef.set(AppCalculations(
      //     totalBalance: [
      //       BalanceEntry(amount: 0, date: DateTime.now())
      //     ], profit: 0, equity: 0, highest: 0).toJson());
    }
    if(userInformation!.balance.length>1){
      max = userInformation!.balance.reduce((value, element) => value.amount > element.amount ? value : element).amount*2;
    }else {
      max=userInformation!.balance.last.amount*2;
      }
    update();
  }

}

