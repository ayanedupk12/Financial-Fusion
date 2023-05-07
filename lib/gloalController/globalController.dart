

import 'dart:io';

import 'package:ffapp/globalModels/UserInfo.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class GlobalController extends GetxController{
  @override
  void onInit() async{
    await checkAllPermissions();
    super.onInit();
  }
  UserInformation? userInformation;



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

}

