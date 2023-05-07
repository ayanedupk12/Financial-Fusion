
import 'package:ffapp/GlobalWidgets.dart';
import 'package:ffapp/Screen/HomeScreen/HomeScreenController.dart';
import 'package:ffapp/theme/styles.dart';
import 'package:ffapp/utils/paths.dart';
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Balance',style: Styles().normalText.copyWith(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                      SizedBox(height: 5,),
                      Text('\$1313.43',style: Styles().normalText.copyWith(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                      SizedBox(height: 5,),
                      Text('4.59 %',style: Styles().normalText.copyWith(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                    ],
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
                                Text('Gain',style: Styles().normalGText,),
                                Text('19.2%',style: Styles().normalGText,),
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
                                Text('Abs. Gain',style: Styles().normalGText,),
                                Text('19.2%',style: Styles().normalGText,),
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
                                Text('Daily',style: Styles().normalGText,),
                                Text('19.2%',style: Styles().normalGText,),
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
                                Text('Monthly',style: Styles().normalGText,),
                                Text('19.2%',style: Styles().normalGText,),
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
                                Text('Draw down',style: Styles().normalGText,),
                                Text('19.2%',style: Styles().normalGText,),
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
                      SizedBox(
                          height: 40,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Highest',style: Styles().normalGText,),
                                Text('19.2%',style: Styles().normalGText,),
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
                                Text('Profit',style: Styles().normalGText,),
                                Text('19.2%',style: Styles().normalGText,),
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
                                Text('Interest',style: Styles().normalGText,),
                                Text('19.2%',style: Styles().normalGText,),
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
                                Text('Deposit',style: Styles().normalGText,),
                                Text('19.2%',style: Styles().normalGText,),
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
                                Text('Withdrawals',style: Styles().normalGText,),
                                Text('19.2%',style: Styles().normalGText,),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.02,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Graphs',textAlign: TextAlign.center,style: Styles().normalGText.copyWith(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: Get.height*0.03,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  CustomTextButton(text: 'Balance',width: 100,height: 40,textSize: 12,color: controller.selectedGraph==0?Colors.black:Colors.white,textColor: controller.selectedGraph==0?Colors.white:Colors.black,onTap: (){
                    controller.selectedGraph=0;
                    controller.selectedGraphName='Balance';
                    controller.update();
                  },),
                  SizedBox(width: 20,),
                    CustomTextButton(text: 'Profit',width: 100,height: 40,textSize: 12,color: controller.selectedGraph==1?Colors.black:Colors.white,textColor: controller.selectedGraph==1?Colors.white:Colors.black,onTap: (){
                    controller.selectedGraph=1;
                    controller.selectedGraphName='Profit';
                    controller.update();
                  },),
                ],),
              ),
              SizedBox(height: Get.height*0.02,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(children: [
                  //Initialize the chart widget
                  SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // Chart title
                      title: ChartTitle(text: '${controller.selectedGraphName} \$'),
                      // Enable legend
                      legend: Legend(isVisible: false),
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: [
                        LineSeries(dataSource: [1000,1002,1000,1300,700,1100],
                            xValueMapper: (int sales, _) => sales,
                            yValueMapper: (int sales, _) => sales,
                            name: 'Sales',
                            // Enable data label
                            dataLabelSettings: DataLabelSettings(isVisible: true))
                      ])],),
              ),


            ],
          );
        }
    ),
        ),
      ),
    );
  }
}
