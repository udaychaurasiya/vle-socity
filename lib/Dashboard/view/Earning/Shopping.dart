import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Widget/EditTextWidget.dart';

import '../../../AppConstant/APIConstant.dart';
import '../../../AppConstant/AppConstant.dart';
import '../../../AppConstant/textStyle.dart';
import '../../../Widget/AppBarWidget2.dart';
class Shopping extends StatefulWidget {
  const Shopping({Key? key}) : super(key: key);

  @override
  State<Shopping> createState() => _ShoppingState();
}
class _ShoppingState extends State<Shopping> {
  List<String> images = [
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
    "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png"
  ];
  DashboardController controller = Get.find();
  _launchURL() async
  {
    const url = 'https://hellokart.com/';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getCouponCodeNetworkApi();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(
            double.infinity,
            60.0,
          ),
          child: CustomAppBar2(
            title: GetStorage().read(AppConstant.userName),
            Points: controller.points,
            image:BASE_URL+GetStorage().read(AppConstant.profileImg), onPress: _launchURL,
          )
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue.shade100,
            child: controller.selectedTabRedeemIndex.value == 1
                ?   SingleChildScrollView(
                   child: Obx(()=>controller.settingModel.value.data!=null?
                   Column(
                  children:List.generate(1, (index){
                    final data=controller.settingModel.value.data!.perCouponPoint;
                    print("${data} dkjgcfyutd");
                    controller.paisa=double.parse(controller.pointData.value)*.25;
                    print("${controller.paisa}fknuohgf");
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10,top: 30),
                      child:
                      Form(
                      key: controller.formKey2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: Colors.grey),
                              ),

                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:
                                [
                                  Container(
                                    padding: EdgeInsets.only(top: 8.h),
                                    width:Get.width,
                                    color:Colors.orangeAccent.withOpacity(0.1),
                                    child: Text("Shopping Rate: 1 Point = 0.25 Paisa",textAlign:TextAlign.center,style:subtitleStyle.copyWith(color: Colors.orangeAccent,fontSize: 16.sp) ,),
                                  ),
                                  Container(
                                    color: Colors.orangeAccent.withOpacity(0.1),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0,bottom: 8),
                                      child: Column(
                                        children:
                                        [
                                          Container(
                                            height: 80.h,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                                border: Border.all()
                                            ),
                                            child:Row(
                                              children: [

                                                Container(
                                                  height: 80.h,
                                                  width: Get.width/2.4,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("Available Point",style:TextStyle(fontSize:16.sp,fontWeight: FontWeight.bold),),
                                                      Text(controller.pointData.value,style: TextStyle(color: Color(
                                                          0xff024585),fontSize: 22.sp,fontWeight: FontWeight.bold),),

                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 80.h,
                                                  width:30.w,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 24.h,
                                                        width: 1.w,
                                                        color: Colors.black,
                                                      ),
                                                      Container(
                                                        height: 30.h,
                                                        width: 30.w,
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            border: Border.all()
                                                        ),
                                                        child: Text("=",textAlign:TextAlign.center,style: TextStyle(fontSize: 24.sp),),
                                                      ),
                                                      Container(
                                                        height: 24.h,
                                                        width: 1.w,
                                                        color: Colors.black,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 80.h,
                                                  width: Get.width/2.6,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("Euivalent Amount (INR)",textAlign:TextAlign.center,style:TextStyle(fontSize:16.sp,fontWeight: FontWeight.bold),),
                                                      Text(controller.paisa.toStringAsFixed(2),style: TextStyle(color: Color(
                                                          0xff169400),fontSize: 22.sp,fontWeight: FontWeight.bold),),

                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h,),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column
                                (
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                [
                                  Row(
                                    children:
                                    [

                                      Text("₹",style: titleStyle,),
                                      Container(
                                        width: 190.w,
                                        child: Column(
                                          children: [
                                            EditTextWidgetAmount(
                                              controller: controller.etAmount2,
                                              hint: 'Enter Amount to withdraw',
                                              type: TextInputType.number,
                                              validator: (value)
                                              {
                                                if(value.toString().isEmpty)
                                                {
                                                  return "Please Enter Amount to withdraw";
                                                }
                                                if(int.parse(value.toString())<=249)
                                                {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      backgroundColor: Colors.orange,
                                                      content: Text("Your amount less than 250"),
                                                      duration: Duration(seconds: 2),
                                                      behavior: SnackBarBehavior.floating,
                                                    ),
                                                  );
                                                }

                                                return null;
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      int.parse(controller.pointData.value.toString())>=1100?
                                      InkWell(
                                        onTap: ()
                                        async {
                                          // print("dsjdfgh  "+controller.selectedTrasactionIndex.value.toString());
                                            if(controller.formKey2.currentState!.validate())
                                            {
                                              controller.postCouponCodeApi();
                                                controller.etAmount2.clear();
                                                controller.Remark.clear();
                                                controller.getgetUserDetailsNetworkApi();
                                            }
                                        },
                                        child:
                                        Padding(
                                          padding:  EdgeInsets.only(right: 10.w),
                                          child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  border: Border.all(color: Colors.grey)
                                              ),
                                              child: Text("Coupon Code",style:subtitleStyle.copyWith(fontSize: 16.sp,color: Colors.orangeAccent.withOpacity(0.6)),)),
                                        ),
                                      )
                                          : InkWell(
                                        onTap: ()
                                        async {
                                        },
                                        child:
                                        Padding(
                                          padding: const EdgeInsets.only(right: 10.0),
                                          child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  border: Border.all(color: Colors.grey)
                                              ),
                                              child: Text("Coupon Code",style:subtitleStyle.copyWith(fontSize: 16.sp,color: Colors.grey.withOpacity(0.6)),)),
                                        ),
                                      )
                                    ],
                                  ),
                                  EditTextWidgetAmount(
                                    controller: controller.Remark,
                                    hint: 'Remark',
                                    type: TextInputType.text,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Withdrawal amount greater than 250 ",style: subtitleStyle.copyWith(fontSize: 14),),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })

              ):Container()
              ),
            )
                : Container(),
          ),
      Expanded(
        child: Obx(()=>controller.coupopCode.value.data!=null?
          SingleChildScrollView(
            child: Container(
              color: Colors.grey.shade100,
                padding: EdgeInsets.all(12.0),
                child: GridView.builder(
                  itemCount: controller.coupopCode.value.data!.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0
                      ),
                      itemBuilder: (BuildContext context, int index){
                    final data=controller.coupopCode.value.data![index];
                    DateTime parsedDate = DateTime.parse(data.addDate.toString());
                    String Date =DateFormat('dd-MMM-yyyy').format(parsedDate);
                    DateTime parsedDate2 = DateTime.parse(data.expDate.toString());
                    String Date2 =DateFormat('dd-MMM-yyyy').format(parsedDate2);
                      return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(left: 8.w,right: 8.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Rs.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp),),
                                        Text(data.amount.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp)),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 45.h,
                                      width: 45.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage("assets/images/icons.png")
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 45.h,
                                width:Get.width,
                                decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("MFD Date : "+Date.toString(),style:bodyText2Style.copyWith(fontSize: 10.sp,fontWeight: FontWeight.bold),),
                                    Text("To",style:bodyText2Style.copyWith(fontSize: 10.sp,fontWeight: FontWeight.bold),),
                                    Text("EXP Date : "+Date2.toString(),style:bodyText2Style.copyWith(fontSize: 10.sp,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5.h,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                DottedBorder(
                                dashPattern: [4, 2],
                                strokeWidth: 1,
                                child: Container(
                                  padding: EdgeInsets.all(3.w),
                                  child: Text(data.couponNo.toString(),style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
                                ),
                              )
                                ],
                              )
                            ],
                          )),
                    );
                  },
                )),
          ):Container()
        ),
      ),
        ],
      ),
    );
  }
}
