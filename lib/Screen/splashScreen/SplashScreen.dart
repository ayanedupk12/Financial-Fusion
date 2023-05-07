
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffapp/Routes/AppRoutes.dart';
import 'package:ffapp/Screen/splashScreen/spashScreenController.dart';
import 'package:ffapp/gloalController/globalController.dart';
import 'package:ffapp/globalModels/UserInfo.dart';
import 'package:ffapp/utils/paths.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
final controller=Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
            height: Get.height/2,
            width: Get.width/2,

            child: SvgPicture.asset('${AllPaths().imagePath}logo.svg')),
      ),
    );
  }
}
