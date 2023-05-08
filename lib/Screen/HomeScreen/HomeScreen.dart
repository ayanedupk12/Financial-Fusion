
import 'package:ffapp/GlobalWidgets.dart';
import 'package:ffapp/Screen/HomeScreen/HomeScreenController.dart';
import 'package:ffapp/gloalController/globalController.dart';
import 'package:ffapp/theme/styles.dart';
import 'package:ffapp/utils/paths.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'homescreenWidgets/drawer.dart';
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: ()async{
            return await controller.refreshCalculations();

          },
          child: SingleChildScrollView(
    child: GetBuilder<HomeScreenController>(
          builder: (controllerr) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) {
                        return InkWell(
                            onTap: (){
                              Scaffold.of(context).openDrawer();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: SvgPicture.asset('${AllPaths().iconsPath}menu.svg',fit: BoxFit.scaleDown,)),
                            ));
                      }
                    ),
                    Text('Home',textAlign: TextAlign.center,style: Styles().boldText.copyWith(fontSize: 16,color: Colors.black),),
                    SizedBox(width: Get.width*0.15,)
                  ],
                ),
                SizedBox(height: Get.height*0.02,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Look at your statistics',textAlign: TextAlign.center,style: Styles().normalGText.copyWith(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: Get.height*0.02,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 20),
                  child: Container(
                    height: Get.height/7.5,
                    width: Get.width-80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black
                    ),
                    child: GetBuilder<GlobalController>(
                      builder: (__) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Balance',style: Styles().normalText.copyWith(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                            SizedBox(height: 5,),
                            Text('\$ ${__.userInformation!.balance.last.amount.toString()}',style: Styles().normalText.copyWith(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                            SizedBox(height: 5,),],
                        );
                      }
                    ),
                  ),
                ),
                SizedBox(height: Get.height*0.02,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('More Analytics',textAlign: TextAlign.center,style: Styles().normalGText.copyWith(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: Get.height*0.02,),
                Center(
                  child: Container(
                    width: Get.width-80,
                    // height: Get.height/2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 9,
                            offset: Offset(3, 5), // Shadow position
                          ),
                        ]
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controllerr.calculatePercentage()[0],style: Styles().normalGText,),
                                  Text('${controllerr.calculatePercentage()[1]}%',style: Styles().normalGText,),
                                ],
                              ),
                            )),
                        SizedBox(
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controllerr.depositOrWithdraw()[0],style: Styles().normalGText,),
                                  Text(controllerr.depositOrWithdraw()[1],style: Styles().normalGText,),
                                ],
                              ),
                            )),
                        SizedBox(
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Equity',style: Styles().normalGText,),
                                  Text('19.2%',style: Styles().normalGText,),
                                ],
                              ),
                            )),
                        GetBuilder<GlobalController>(
                          builder: (__) {
                            return SizedBox(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total Profit',style: Styles().normalGText,),
                                      Text('${__.userInformation!.profit.toString()} \$',style: Styles().normalGText,),
                                    ],
                                  ),
                                ));
                          }
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height*0.02,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Balance Chart',textAlign: TextAlign.center,style: Styles().normalGText.copyWith(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: Get.height*0.03,),
                GetBuilder<GlobalController>(
                  builder: (__) {
                    return Container(
                      width: Get.width+__.userInformation!.balance.length*500,
                      height: 400,
                      child: ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection:Axis.horizontal,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: SizedBox(
                              // height: 300,
                              width:Get.width+__.userInformation!.balance.length*50,
                              child: BarChart(
                                  BarChartData(
                                      maxY: __.max,
                                      minY: 0,
                                      barGroups: __.userInformation!.balance.expand((data){
                                        // controller.data=data;
                                        if(data.amount>__.previousValue){
                                          __.rise=true;
                                          __.previousValue=data.amount;
                                        }else{
                                          __.rise=false;
                                          __.previousValue=data.amount;
                                        }
                                        return [
                                          BarChartGroupData(
                                              x:data.date.day,
                                              // spacing: 10,
                                              barRods: [
                                                BarChartRodData(
                                                    toY: data.amount==0?0.01:data.amount,
                                                    color: __.rise?Colors.green:Colors.red,
                                                    borderRadius: BorderRadius.circular(2),
                                                    width: 40
                                                ),
                                              ]
                                          )
                                        ];

                                      }

                                      ).toList()
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                ),


              ],
            );
          }
    ),
          ),
        ),
      ),
    );
  }
}
