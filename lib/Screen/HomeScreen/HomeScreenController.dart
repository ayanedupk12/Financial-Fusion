

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffapp/gloalController/globalController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../globalModels/UserInfo.dart';

class HomeScreenController extends GetxController{
  final globalController=Get.put(GlobalController());
  final FirebaseAuth _auth= FirebaseAuth.instance;
  final FirebaseFirestore firebaseFireStore=FirebaseFirestore.instance;

  int selectedGraph=0;
  String selectedGraphName='Balance';
  int selectedPage=0;
  bool drawerProcessing=false;


  calculatePercentage(){
    double change=0;
    if(globalController.userInformation!.balance.length>1){
      double secondLast= globalController.userInformation!.balance.elementAt(globalController.userInformation!.balance.length-2).amount;
      double last= globalController.userInformation!.balance.last.amount;
      change= last-secondLast;
    }else{
      change=globalController.userInformation!.balance.last.amount;
    }
    double percentage= change/100;
    return [change>0?'Gain':'Loss',percentage.toString()];
  }
  depositOrWithdraw(){
    double change=0;
    if(globalController.userInformation!.balance.length>1){
      double secondLast= globalController.userInformation!.balance.elementAt(globalController.userInformation!.balance.length-2).amount;
      double last= globalController.userInformation!.balance.last.amount;
      change= last-secondLast;
    }else{
      change=globalController.userInformation!.balance.last.amount;
    }

    return [change>0?'Deposit':'Withdraw',change.toString()];
  }
  calculateEquity(){

  }
  refreshCalculations(){
    globalController.getAppPreviewCalculations();
    final user =firebaseFireStore.collection('Users').doc(_auth.currentUser!.uid);
    user.get().then((value){
      List<dynamic> balanceJson = value['balance'];
      List<BalanceEntry> balanceF = balanceJson.map((entry) => BalanceEntry.fromJson(entry)).toList();
      globalController.userInformation=UserInformation(
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

  }


}