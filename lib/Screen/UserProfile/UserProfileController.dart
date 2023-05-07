

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class UserProfileController extends GetxController{
  bool readonlyTextField=true;

  final TextEditingController phoneNumber = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  String completePhoneNumber='';
}