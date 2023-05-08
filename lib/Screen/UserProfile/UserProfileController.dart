

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffapp/GlobalWidgets.dart';
import 'package:ffapp/gloalController/globalController.dart';
import 'package:ffapp/globalModels/UserInfo.dart';
import 'package:ffapp/theme/styles.dart';
import 'package:ffapp/validatorS.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class UserProfileController extends GetxController{
  GlobalKey<FormState> updateInfoGlobalKey = GlobalKey();
  final globalController=Get.put(GlobalController());
  final FirebaseAuth _auth= FirebaseAuth.instance;
  final FirebaseFirestore firebaseFireStore=FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  @override
  void onInit() async{
    profileImage= globalController.userInformation!.profile!;
    nameController.text=globalController.userInformation!.name;
    number = await PhoneNumber.getRegionInfoFromPhoneNumber(globalController.userInformation!.phone);
    completePhoneNumber=number.parseNumber();
    // number=number.parseNumber();
    update();
    print('profileImage');
    print(profileImage);
    super.onInit();
  }
  bool readonlyTextField=true;
  String profileImage='';
  bool processing=false;
  bool imageUploading=false;

  final TextEditingController phoneNumber = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  String completePhoneNumber='';
  updateInfo()async{
    processing=true;
    update();
    if(updateInfoGlobalKey.currentState!.validate()){
      bool result = await InternetConnectionChecker().hasConnection;
      if(result){
        final user = firebaseFireStore.collection('Users').doc(_auth.currentUser!.uid);
        await user.get().then((value)async{
          List<dynamic> balanceJson = value['balance'];
          List<BalanceEntry> balanceF = balanceJson.map((entry) => BalanceEntry.fromJson(entry)).toList();
          await user.set(UserInformation(
              userId: value['userId'],
              userType: value['userType'],
              name: nameController.text,
              phone: completePhoneNumber,
              balance: balanceF,
              idFrontSide: value['idFrontSide'],
              idBackSide: value['idBackSide'],
              email: value['email'],
              profit: value['profit'],
              profile: value['profile']).toJson());
        });
      }
      else{
        Get.snackbar('Financial Fusion', 'No internet connection');
      }
    }

    processing=false;
    update();

  }
}

class ChangeImagePicker extends StatefulWidget {
  String? side;
  ChangeImagePicker({Key? key,this.side}) : super(key: key);

  @override
  State<ChangeImagePicker> createState() => _ChangeImagePickerState();
}

class _ChangeImagePickerState extends State<ChangeImagePicker> {
  // TextEditingController adminIdController = TextEditingController();
  final FirebaseAuth _auth= FirebaseAuth.instance;
  final FirebaseFirestore firebaseFireStore=FirebaseFirestore.instance;
  uploadImage(String name,String filePath)async{
    final Reference storageReference =
    FirebaseStorage.instance.ref().child(_auth.currentUser!.uid.toString()).child(name);
    final UploadTask uploadTask = storageReference.putFile(File(filePath));
    final TaskSnapshot downloadUrl = (await uploadTask.whenComplete(() {}));
    final String url = (await downloadUrl.ref.getDownloadURL());
    globalController.userInformation!.profile!=url;
    print('url');
    print(url);
    final user = firebaseFireStore.collection('Users').doc(_auth.currentUser!.uid);
    user.get().then((value)async{
      List<dynamic> balanceJson = value['balance'];
      List<BalanceEntry> balanceF = balanceJson.map((entry) => BalanceEntry.fromJson(entry)).toList();
      await user.set(UserInformation(
          userId: value['userId'],
          userType: value['userType'],
          name: value['name'],
          phone: value['phone'],
          balance: balanceF,
          idFrontSide: value['idFrontSide'],
          idBackSide: value['idBackSide'],
          email: value['email'],
          profit: value['profit'],
          profile: url).toJson());
    });
    print(globalController.userInformation!.toJson());


    return url;
  }
  final globalController=Get.put(GlobalController());
  final userProfilecontroller=Get.put(UserProfileController());
  bool isSend=false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        titlePadding: EdgeInsets.all(10.0),
        content: Container(
          // height: 400,
            width: 500,
            child:Column(
                mainAxisSize:MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Upload profile",
                    style: Styles().ExtraboldText.copyWith(fontSize: 18,color: Colors.black,),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextButton(text:'Camera',width: Get.width*0.23,height: 40,textSize: 10,onTap: ()async{
                        userProfilecontroller.imageUploading=true;
                        userProfilecontroller.update();
                        if(globalController.cPerm==true&&globalController.sPerm==true){
                          Get.back();
                          String temp=await globalController.pickImage(ImageSource.camera);
                            userProfilecontroller.profileImage= await uploadImage('ProfileImage',temp);
                            userProfilecontroller.update();
                        }else{
                          Get.snackbar('Financial Fusion', 'Permission denied');
                        }
                        userProfilecontroller.imageUploading=false;
                        userProfilecontroller.update();
                      },),
                      SizedBox(width: 20,),
                      CustomTextButton(text:'Gallery',width: Get.width*0.23,height: 40,textSize: 10,onTap: ()async{
                        userProfilecontroller.imageUploading=true;
                        userProfilecontroller.update();
                        if(globalController.cPerm==true&&globalController.sPerm==true){
                          Get.back();
                          String temp=await globalController.pickImage(ImageSource.gallery);
                            userProfilecontroller.profileImage= await uploadImage('ProfileImage',temp);
                            userProfilecontroller.update();
                            Get.back();
                        }else{
                          Get.snackbar('Financial Fusion', 'Permission denied');
                        }
                        userProfilecontroller.imageUploading=false;
                        userProfilecontroller.update();
                        // globalController.pickImage(ImageSource.gallery);
                      },),
                    ],
                  ),
                ]

            )));
  }
}