

import 'package:ffapp/Routes/AppRoutes.dart';
import 'package:ffapp/Screen/HomeScreen/HomeScreen.dart';
import 'package:ffapp/Screen/LoginScreen/LoginScreen.dart';
import 'package:ffapp/Screen/SignUpScreen/SignUpScreen.dart';
import 'package:ffapp/Screen/forgotPassword/ForgotScreen.dart';
import 'package:ffapp/Screen/splashScreen/SplashScreen.dart';
import 'package:ffapp/Screen/Support/SupportScreen.dart';
import 'package:ffapp/Screen/UserProfile/UserProfileScreen.dart';
import 'package:ffapp/Screen/welcomScreen.dart';
import 'package:get/get.dart';


class Pages {
  static final pages = [
    GetPage(
        name: Routes.splashScreen,
        page: () => SplashScreen(),

    ),
    GetPage(
        name: Routes.welcomeScreen,
        page: () => WelcomeScreen(),

    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => LoginScreen(),

    ),
    GetPage(
      name: Routes.signUpScreen,
      page: () => SignUpScreen(),

    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => HomeScreen(),

    ),
    GetPage(
      name: Routes.userProfile,
      page: () => UserProfileScreen(),

    ),
    GetPage(
      name: Routes.supportScreen,
      page: () => SupportScreen(),

    ),
    GetPage(
      name: Routes.forgotScreen,
      page: () => ForgotScreen(),
    ),


  ];
}