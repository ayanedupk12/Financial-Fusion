import 'dart:async';


import 'package:ffapp/Routes/AppPages.dart';
import 'package:ffapp/gloalController/globalController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Routes/AppRoutes.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class ValidationBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(ValidatorController());
    Get.put(GlobalController());
  }}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // moveScreen();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme:  ThemeData(
          colorScheme: ColorScheme.light().copyWith(primary: Colors.white)
      ),
      initialBinding: ValidationBinding(),
      initialRoute: Routes.splashScreen,
        getPages: Pages.pages,
    );
  }
}



