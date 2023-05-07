

import 'package:ffapp/Routes/AppRoutes.dart';
import 'package:ffapp/Screen/HomeScreen/HomeScreenController.dart';
import 'package:ffapp/theme/styles.dart';
import 'package:ffapp/utils/paths.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';



drawer(){
  final controller = Get.put(HomeScreenController());
  return Container(
    color: Colors.white,
    height: Get.height,
    width: Get.width/1.7,
    child: Column(
      children: [
        SizedBox(height: 30,),
        SizedBox(
            height: Get.height/4,
            width: Get.width,
            child: Center(child: SizedBox(
                height: Get.height/6,
                child: SvgPicture.asset('${AllPaths().imagePath}logo.svg')))),
        // Divider(thickness: 1,color: Color(0xFF37C8C3),indent:20,endIndent: 20,),
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              InkWell(
                onTap: (){
                  Get.toNamed(Routes.userProfile);
                },
                child: Row(
                  children: [
                    SizedBox(height:20,width:20,child: SvgPicture.asset('${AllPaths().iconsPath}profile.svg',color: Colors.black,)),
                    SizedBox(width: 30,),
                    Text('Profile',maxLines: 1,style: Styles().normalGText),
                  ],),
              ),
              SizedBox(height: 30,),
              InkWell(
                onTap: (){
                  Get.toNamed(Routes.supportScreen);
                },
                child: Row(
                  children: [
                    SizedBox(height:20,width:20,child: SvgPicture.asset('${AllPaths().iconsPath}support.svg',color: Colors.black,)),
                    SizedBox(width: 30,),
                    Text('Support',maxLines: 1,style: Styles().normalGText),
                  ],),
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: GetBuilder<HomeScreenController>(
            builder: (__) {
              return __.drawerProcessing?CircularProgressIndicator(color: Colors.black,):InkWell(
                onTap: (){
                  __.drawerProcessing=true;
                  __.update();
                  final FirebaseAuth _auth= FirebaseAuth.instance;
                  _auth.signOut();
                  __.drawerProcessing=false;
                  __.update();
                  Get.back();
                  Get.back();
                },
                child: Row(
                  children: [
                    SizedBox(height:20,width:20,child: SvgPicture.asset('${AllPaths().iconsPath}logout.svg',color: Colors.black,)),
                    SizedBox(width: 30,),
                    Text('Logout',maxLines: 1,style: Styles().normalGText),
                  ],),
              );
            }
          ),
        ),
        const SizedBox(height: 20,),
      ],
    ),
  );
}