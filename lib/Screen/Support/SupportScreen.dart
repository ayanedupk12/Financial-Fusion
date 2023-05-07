
import 'package:ffapp/GlobalWidgets.dart';
import 'package:ffapp/Routes/AppRoutes.dart';
import 'package:ffapp/Screen/Support/SupportScreenController.dart';
import 'package:ffapp/Screen/UserProfile/UserProfileController.dart';
import 'package:ffapp/theme/styles.dart';
import 'package:ffapp/utils/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class SupportScreen extends StatelessWidget {
  SupportScreen({Key? key}) : super(key: key);
  final controller=Get.put(SupportScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<SupportScreenController>(
          builder: (_) {
            return SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: InkWell(
                            onTap: (){
                              Get.back();
                            },
                            child: Icon(Icons.chevron_left,size: 40,)),
                      ),
                      Spacer(),
                      Text('Support',style: Styles().ExtraboldText.copyWith(fontSize: 18,color: Colors.black,),),
                      Spacer(),
                      SizedBox(width: Get.width*0.15,)
                    ],
                  ),
                  SizedBox(height: Get.height*0.01,),
                  // Spacer(),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: Get.height*0.04,),
                        Container(
                          height: 60,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 9,
                                offset: Offset(3, 5), // Shadow position
                              ),
                            ],
                          ),
                          child: Center(
                            child: TextFormField(
                              // controller: widget.controller,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                fillColor: Colors.grey,
                                hintText: 'Subject',
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
                        SizedBox(height: Get.height*0.01,),
                        Container(
                          height: 150,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 9,
                                offset: Offset(3, 5), // Shadow position
                              ),
                            ],
                          ),
                          child: Center(
                            child: TextFormField(
                              maxLines: 5,
                              // controller: widget.controller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                fillColor: Colors.grey,
                                hintText: 'description',
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
                        SizedBox(height: Get.height*0.04,),
                        CustomTextButton(text:controller.readonlyTextField?'Edit Profile':"Save Profile",width: 250,onTap: (){
                          controller.readonlyTextField=!controller.readonlyTextField;
                          controller.update();
                          // Get.offAndToNamed(Routes.homeScreen);
                        },),
                        SizedBox(height: Get.height*0.04,),
                        SizedBox(
                            width:Get.width-200,
                            height: 12,
                            child: Stack(
                              children: [
                                Divider(color: Colors.black,),
                                Positioned(
                                    bottom: 0,
                                    right: 20,
                                    child: Container(
                                      color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Text('Or you can contact us using',style: Styles().normalGText.copyWith(fontSize: 12,color: Colors.black)),
                                        )))
                              ],
                            )),
                        SizedBox(height: Get.height*0.08,),
                        Center(
                          child: SvgPicture.asset('${AllPaths().iconsPath}whatsapp.svg',fit: BoxFit.scaleDown,width: 80,height: 80,),
                        )

                      ],
                    ),
                  ),

                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
