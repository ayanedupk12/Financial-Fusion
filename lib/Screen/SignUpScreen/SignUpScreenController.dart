

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

class SignUpScreenController extends GetxController{
  GlobalKey<FormState> signUpGlobalKey = GlobalKey();
  bool processing=false;

  //image Get
  final TextEditingController phoneNumber = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  String completePhoneNumber='';
  String? frontSide;
  String? backSide;

  //controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController cPassController = TextEditingController();

  //signup
  final FirebaseAuth _auth= FirebaseAuth.instance;
  final FirebaseFirestore firebaseFireStore=FirebaseFirestore.instance;


  Future<void> signUp() async {
    processing=true;
    update();
    bool result = await InternetConnectionChecker().hasConnection;
    if(result){
      if(frontSide!=null && backSide!=null){
        if(signUpGlobalKey.currentState!.validate()){
          try {
            // Create a new user in Firebase Authentication
            if(passController.text==cPassController.text){

              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: emailController.text,
                password: passController.text,
              ).then((value) async{
                // Create a new UserInformation object with default values
                UserInformation userInfo = UserInformation(
                    userId: value.user!.uid,
                    userType: 'user',
                    name: nameController.text,
                    phone: completePhoneNumber,
                    balance: [
                      BalanceEntry(amount: 0, date: DateTime.now())
                    ],
                    idFrontSide: await uploadImage('frontSide', frontSide!),
                    idBackSide: await uploadImage('backSide', backSide!),
                email: emailController.text,
                profit: 0,
                  highest: 0,
                  profile: '',
                );
                // Add the user information to Cloud Firestore
                await FirebaseFirestore.instance.collection('Users').doc(value.user!.uid).set(userInfo.toJson());
                Get.back();
                await _auth.currentUser!.sendEmailVerification();
                Get.snackbar('FinancialFusion', 'check your inbox');


              }).onError((error, stackTrace) {
                Get.snackbar('FinancialFusion', error.toString());
                // print(error);
              });

            }else{
              Get.snackbar('FinancialFusion', "Password didn't Match");
            }


          } catch (e) {
            print(e.toString());
          }
        }else{
          Get.snackbar('Financial Fusion', 'All fields are Required');
        }
      }else{
        Get.snackbar('Financial Fusion', 'upload Id First');
      }
    }else{
      Get.snackbar('Financial Fusion', 'No internet connection');
    }
    await Future.delayed(Duration(seconds: 3));
    processing=false;
    update();
  }
  
  uploadImage(String name,String filePath)async{
    final Reference storageReference =
    FirebaseStorage.instance.ref().child(_auth.currentUser!.uid.toString()).child(name);
    final UploadTask uploadTask = storageReference.putFile(File(filePath));
    final TaskSnapshot downloadUrl = (await uploadTask.whenComplete(() {}));
    final String url = (await downloadUrl.ref.getDownloadURL());
    return url;
  }

}

class ImagePickerClass extends StatefulWidget {
  String? side;
  ImagePickerClass({Key? key,this.side}) : super(key: key);

  @override
  State<ImagePickerClass> createState() => _ImagePickerClassState();
}

class _ImagePickerClassState extends State<ImagePickerClass> {
  // TextEditingController adminIdController = TextEditingController();


  ValidatorController validatorController = Get.find();
  final globalController=Get.put(GlobalController());
  final signUpController=Get.put(SignUpScreenController());
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
                    "Upload Identity",
                    style: Styles().ExtraboldText.copyWith(fontSize: 18,color: Colors.black,),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextButton(text:'Camera',width: Get.width*0.23,height: 40,textSize: 10,onTap: ()async{

                        if(globalController.cPerm==true&&globalController.sPerm==true){
                          if(widget.side=='Front'){
                            signUpController.frontSide= await globalController.pickImage(ImageSource.camera);
                            signUpController.update();
                            Get.back();
                          }else{
                            signUpController.backSide= await globalController.pickImage(ImageSource.camera);
                            signUpController.update();
                            Get.back();
                          }
                        }else{
                          Get.snackbar('Financial Fusion', 'Permission denied');
                        }
                      },),
                      SizedBox(width: 20,),
                      CustomTextButton(text:'Gallery',width: Get.width*0.23,height: 40,textSize: 10,onTap: ()async{
                        if(globalController.cPerm==true&&globalController.sPerm==true){
                          if(widget.side=='Front'){
                            signUpController.frontSide= await globalController.pickImage(ImageSource.gallery);
                            signUpController.update();
                            Get.back();
                          }else{
                            signUpController.backSide= await globalController.pickImage(ImageSource.gallery);
                            signUpController.update();
                            Get.back();
                          }
                        }else{
                          Get.snackbar('Financial Fusion', 'Permission denied');
                        }
                        // globalController.pickImage(ImageSource.gallery);
                      },),
                    ],
                  ),
                ]

            )));
  }
}
