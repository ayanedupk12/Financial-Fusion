
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'theme/styles.dart';
import 'utils/paths.dart';
String? Function(String?)? textFieldValidator = (String? value){
  if(value!.isEmpty){
    return 'TextField cannot be empty';
  }
  final n = num.tryParse(value);
  if(n == null) {
    return '"$value" is not a valid number';
  }
  return null;
};
class CustomTetextField extends StatefulWidget {
  double? width;
  double? height;
  String? icon;
  String? hintText;
  bool readonly;
  bool obsecure;
  String? Function(String?)? validator;
  TextEditingController? controller;
  CustomTetextField({this.validator,this.readonly=false,this.width=270,this.height=60,this.hintText,this.icon,this.obsecure=false,this.controller,Key? key}) : super(key: key);

  @override
  State<CustomTetextField> createState() => _CustomTetextFieldState();
}

class _CustomTetextFieldState extends State<CustomTetextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(50),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withOpacity(0.1),
      //       blurRadius: 9,
      //       offset: Offset(3, 5), // Shadow position
      //     ),
      //   ],
      // ),
     child: Center(
       child: TextFormField(
         readOnly: widget.readonly,
         controller: widget.controller,
         obscureText: widget.obsecure,
         validator:widget.validator,
         decoration: InputDecoration(
           suffixIcon:widget.icon=='password'? GestureDetector(
             onTap: (){
               widget.obsecure=!widget.obsecure;
               setState(() {

               });
             },
             child: SizedBox(
               // height: 30,
               width: 50,
               child: Padding(
                 padding: const EdgeInsets.only(left: 20.0,top: 5,bottom: 5,right: 10),
                 child: SvgPicture.asset('${AllPaths().iconsPath}hide.svg',fit: BoxFit.scaleDown,color: widget.obsecure?Colors.black:Colors.grey,),
               ),
             ),
           ):SizedBox(),
           //add prefix icon
           prefixIcon: SizedBox(
             // height: 30,
             width: 50,
             child: Padding(
               padding: const EdgeInsets.only(left: 20.0,top: 5,bottom: 5,right: 10),
               child: SvgPicture.asset('${AllPaths().iconsPath}${widget.icon}.svg',fit: BoxFit.scaleDown),
             ),
           ),
           border: OutlineInputBorder(borderSide: BorderSide.none),
           fillColor: Colors.grey,
           hintText: widget.hintText,
           //make hint text
           hintStyle: TextStyle(
             color: Colors.grey,
             fontSize: 16,
             fontFamily: "verdana_regular",
             fontWeight: FontWeight.w400,
           ),

           //create lable
           //lable style,
         ),
       ),
     ),
    );
  }
}
class CustomTextButton extends StatelessWidget {
  double? width;
  double? height;
  double? textSize;
  String? text;
  Color color;
  Color textColor;
  bool border;
  final VoidCallback? onTap;
  CustomTextButton({this.textSize=18.0,this.textColor=Colors.white,this.border=false,this.color=Colors.black,this.width=300,this.height=60,this.text='',this.onTap,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          // border: border?Border.all(color: Colors.black):Border.all(width: 0),
          color: color,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 9,
              offset: Offset(3, 5),
              // Shadow position
            ),
          ],
        ),
       child: Center(
         child: Text(text!,style: Styles().normalText.copyWith(color:textColor,fontSize: textSize),),
       ),
      ),
    );
  }
}

class CustomDialogBox extends StatelessWidget {
  String? userName;
  String? title;
  String? buttontext;
      String? amount;
      String? adminName;
      String? icon;
      String? successDetails;
  CustomDialogBox({this.userName,this.adminName,this.amount,this.title,this.icon,this.successDetails,this.buttontext,Key? key}) : super(key: key);
  TextEditingController adminController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        titlePadding: EdgeInsets.all(10.0),
        content: Container(
            // height: 400,
            width: 500,

            child: icon != null ?Column(
              mainAxisSize:MainAxisSize.min,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black
                  ),
                  child:Center(
                    child: SizedBox(
                      // height: 30,
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset('${AllPaths().iconsPath}$icon.svg',fit: BoxFit.scaleDown),
                      ),
                    ),),),
                SizedBox(height: 40),
                Text('${title!} Successfully',
                  style: Styles().normalText.copyWith(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),),
                SizedBox(height: 20),
                Text(successDetails!,
                  style: Styles().normalText.copyWith(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                SizedBox(height: 30),
                CustomTextButton(text: buttontext!, onTap: () {
                  if(buttontext=='Go Back'){
                    Get.back();
                  }else{
                    Get.back();
                    Get.dialog(
                        CustomDialogBox(
                            icon: 'done',
                            buttontext: 'Go Back',
                            title: title,
                            successDetails:'Thanks for being here'
                        )
                    );
                  }
                },),
              ],
            ):Column(
                mainAxisSize:MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40,),
                  Text('Verification',
                    style: Styles().normalText.copyWith(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),)
                  ,

                  userName == null ? SizedBox() : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('User Name:',
                        style: Styles().normalText.copyWith(color: Colors.black,fontSize: 20),),
                      Text(userName!,
                        style: Styles().normalText.copyWith(color: Colors.black,fontSize: 20),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  amount == null ? SizedBox() : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${title} Amount:',
                        style: Styles().normalText.copyWith(color: Colors.black,fontSize: 20),),
                      Text(amount!,
                        style: Styles().normalText.copyWith(color: Colors.black,fontSize: 20),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  adminName == null ? SizedBox() : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Admin:',
                        style: Styles().normalText.copyWith(color: Colors.black,fontSize: 20),),
                      Text(adminName!,
                        style: Styles().normalText.copyWith(color: Colors.black,fontSize: 20),),
                    ],
                  ),
                  SizedBox(height: 30,),
                  adminName == null ? SizedBox() : CustomTetextField(
                    hintText: 'Admin Id',
                    icon: 'profile',
                    controller: adminController,),
                  SizedBox(height: 30,),
                  CustomTextButton(text: buttontext!, onTap: () {
                    if(buttontext=='Go Back'){
                      Get.back();
                    }else{
                      Get.back();
                      Get.dialog(
                          CustomDialogBox(
                              icon: 'done',
                              buttontext: 'Go Back',
                              title: buttontext,
                              successDetails: successDetails
                          )
                      );
                    }
                  },),

                ]

            )));
  }
}

class CustomSmallTextField extends StatelessWidget {
  double? width;
  double? height;
  String? icon;
  String? hintText;
  String? lableText;
  bool obsecure;
  double radius;
  double? fontSize;
  TextEditingController? controller;
  CustomSmallTextField({this.fontSize=24,this.lableText,this.radius=30,this.width=200,this.height=40,this.hintText,this.icon,this.obsecure=false,this.controller,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        lableText==null
            ?SizedBox()
            :Expanded(
          flex: 1,
              child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(lableText!,style: Styles().normalText.copyWith(fontSize: fontSize,fontWeight: FontWeight.bold,color: Colors.black),),

                ],
              ),
            ),
        Expanded(
          flex: 1,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 9,
                  offset: Offset(3, 5), // Shadow position
                ),
              ],
            ),
            child: SizedBox(
              height: height,
              width: width,
              child: TextFormField(
                validator: textFieldValidator,
                controller: controller,
                obscureText: obsecure,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
//add prefix icon
                  prefixIcon: SizedBox(
// height: 30,
                    width: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0,top: 5,bottom: 5,right: 10),
                      child: SvgPicture.asset('${AllPaths().iconsPath}$icon.svg',fit: BoxFit.scaleDown),
                    ),
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  fillColor: Colors.grey,
                  hintText: hintText,
//make hint text
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
//create lable
//lable style,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: context.width*0.1,)
      ],
    );
  }
}




