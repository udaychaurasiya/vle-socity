import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../AppConstant/APIConstant.dart';
import '../AppConstant/AppConstant.dart';
import '../AppConstant/textStyle.dart';
import '../Auth/view/LoginPage2.dart';
import '../Dashboard/controller/DashboardController.dart';
import '../Splash/SplashPage1.dart';

class UtilsMethod{

static  Future<void> launchUrls(String url)
async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

static Future<void> PopupBox(BuildContext context ,String message)
async {
  showDialog(
    context: context,
    builder: (_) =>
        Dialog(
          alignment: Alignment.center,
          insetPadding:EdgeInsets.all(20) ,
          backgroundColor: Colors.transparent,
          child:
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child:
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children:
                [
                  Text("Confirms !",style: bodyText1Style.copyWith(color: Colors.red,fontSize: 20,),),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text("You are a guest user ! Please login \n Then ${message}",style: bodyText1Style.copyWith(color: Colors.red,fontSize: 15,
                      height: 1.3
                    ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      children:
                      [
                         MaterialButton(onPressed: ()
                         {
                         Navigator.pop(context);
                        },
                         shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                         color: Colors.green.withOpacity(0.1),
                       child: Text("Cancle",style: bodyText1Style.copyWith(color: Colors.black,fontSize: 15,)),),
                        Spacer(),
                        MaterialButton(onPressed: ()
                        {
                          DashboardController controller = Get.find();
                          controller.logout();

                        },
                          shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          color: Colors.cyanAccent.withOpacity(0.1),
                          child: Text("Ok",style: bodyText1Style.copyWith(color: Colors.black,fontSize: 15,)),)
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
  );

}



static Future<void> PopupBoxTrasction(BuildContext context ,String message)
async {
  showDialog(
    context: context,
    builder: (_) =>
        Dialog(
          alignment: Alignment.center,
          insetPadding:EdgeInsets.all(20) ,
          backgroundColor: Colors.transparent,
          child:
          Container(
            height: 200.h,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)
            ),
            child:
            Column(
              children:
              [
                Container(
                  width: Get.width/1.2,
                  color: Colors.orangeAccent.withOpacity(0.1),
                  child: Padding(
                    padding:  EdgeInsets.only(left: 8.w,right: 8.w,top: 8.h),
                    child: Row(
                      children:
                      [
                        Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children:
                          [
                             Text("Withdrawal Amount and Processing Fee",style: heading3.copyWith(fontSize:13.sp,fontWeight: FontWeight.w200, ),),

                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                Divider(height: 0.8,color: Colors.grey,thickness: 1,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset("assets/images/verified.png",height: 20.h,width: 20.w,),
                      SizedBox(width: 5,),
                      Text.rich(

                        TextSpan(
                          style: smallTextStyle,
                          children: [
                            TextSpan(
                              text:
                              'Minimum withdrawal amount is ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14.sp,
                                  height: 2.h,
                                  letterSpacing: 0.2.w),
                            ),
                            TextSpan(
                              text: '₹ 1000',
                              style: TextStyle(
                                color: const Color(0xff222324),
                                fontWeight: FontWeight.w900,
                                decoration: TextDecoration.underline,
                              ),
                            ),


                          ],
                        ),
                        textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),

                        softWrap: false,
                      )
                        ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(8.w),
                  child: Row(
                    children: [
                      Image.asset("assets/images/verified.png",height: 20.h,width: 20.w,),
                      SizedBox(width: 5,),
                      Text.rich(

                        TextSpan(
                          style: smallTextStyle,
                          children: [
                            TextSpan(
                              text:
                              'Processing fees of ₹ 15 ',
                              style: TextStyle(

                                  color: const Color(0xff222324),
                                  fontWeight: FontWeight.w900,

                                  fontSize: 14.sp,
                                  height: 2.h,
                                  letterSpacing: 0.2.w),
                            ),
                            TextSpan(
                              text: 'will be charged  \nfor each withdrawal request once all your\nMonthly free withdrawals are over',
                              style: TextStyle(
                                color: const Color(0xff222324),
                                fontWeight: FontWeight.w300,
                                fontSize: 13.sp
                              ),
                            ),
                          ],
                        ),
                        textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),

                        softWrap: false,
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
  );

}
static Future<void> PopupRatusApp(BuildContext context ,String message)
async {
  showDialog(
    context: context,
    builder: (_) =>
        Dialog(
          alignment: Alignment.center,
          insetPadding:EdgeInsets.all(20.w) ,
          backgroundColor: Colors.transparent,
          child:
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)
            ),
            child:
            Column(
              children:
              [
                Container(
                  color: Colors.orangeAccent.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
                    child: Row(
                      children:
                      [
                        Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children:
                          [
                            Text("Withdrawal Amount and Processing Fee",style: heading3.copyWith(fontSize: 16,fontWeight: FontWeight.w200, ),),

                          ],
                        ),


                      ],
                    ),
                  ),
                ),
                Divider(height: 0.8,color: Colors.grey,thickness: 1,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset("assets/images/verified.png",height: 20,width: 20,),
                      SizedBox(width: 5,),
                      Text.rich(

                        TextSpan(
                          style: smallTextStyle,
                          children: [
                            TextSpan(
                              text:
                              'Minimum withdrawal amount is ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  height: 2,
                                  letterSpacing: 0.2),
                            ),
                            TextSpan(
                              text: '₹ 100',
                              style: TextStyle(
                                color: const Color(0xff222324),
                                fontWeight: FontWeight.w900,
                                decoration: TextDecoration.underline,
                              ),
                            ),


                          ],
                        ),
                        textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),

                        softWrap: false,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset("assets/images/verified.png",height: 20,width: 20,),
                      SizedBox(width: 5,),
                      Text.rich(

                        TextSpan(
                          style: smallTextStyle,
                          children: [
                            TextSpan(
                              text:
                              'Processing fees of ₹ 15 ',
                              style: TextStyle(

                                  color: const Color(0xff222324),
                                  fontWeight: FontWeight.w900,

                                  fontSize: 16,
                                  height: 2,
                                  letterSpacing: 0.2),
                            ),
                            TextSpan(
                              text: 'will be charged  \nfor each withdrawal request once all your\nMonthly free withdrawals are over',
                              style: TextStyle(
                                color: const Color(0xff222324),
                                fontWeight: FontWeight.w300,

                              ),
                            ),


                          ],
                        ),
                        textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),

                        softWrap: false,
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
  );

}

static dateOfBirth(BuildContext context,String name)
{
  print("dfjghjfd");
  DashboardController controller = Get.find();
  DateTime current_date = DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final DateFormat formatter2 = DateFormat('dd/MM');
  final DateFormat formatter3 = DateFormat('yyyy');

  final String currentdate = formatter.format(current_date);
  final String currentdate1 = formatter2.format(current_date);
  final String currentdate3 = formatter3.format(current_date);

  final String dob =controller.dob.toString();
  String str1 = dob;
  List<String> str2 = str1.split('/');
  String day = str2.isNotEmpty ? str2[0] : '';
  String  month= str2.length > 1 ? str2[1] : '';
  String year = str2.length > 2 ? str2[2] : '';
  String dataofbirth=day+"/"+month;
  int data=int. parse(currentdate3)-int.parse(year);
  if(currentdate1==dataofbirth)
    {
      showDialog(
        context: context,
        builder: (_) =>
            Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r)
              ),
              child: Container(
                height:400.h,
                width:Get.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:AssetImage("assets/images/birth6.gif"), // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10.h,),
                    Container(
                      height: 100.h,
                      width:Get.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/birth4.png"),fit: BoxFit.fill
                          )
                      ),
                    ),
                    Container(
                      height: 120.h,
                      width: 120.w,
                      decoration:BoxDecoration(
                          border: Border.all(width: 3.w),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(BASE_URL +
                                  GetStorage()
                                      .read(AppConstant.profileImg)
                                      .toString()),fit: BoxFit.fill
                          )
                      ),
                    ),
                    Container(
                      height: 70.h,
                      width:Get.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/birth5.jpg"),fit: BoxFit.fill
                          )
                      ),
                    ),
                    Text(GetStorage().read(AppConstant.userName),
                      style: smallTextStyle.copyWith(color: Color(0xfffc7e00),fontSize: 20.sp,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    InkWell(onTap: (){
                      Navigator.pop(context);
                    },
                      child: Container(
                        height: 40.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(25.r)
                        ),
                        child: Center(child: Text("Thankyou",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19.sp),textAlign: TextAlign.center)),
                      ),
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
            )
            // Dialog(
            //   alignment: Alignment.center,
            //   insetPadding:EdgeInsets.all(20) ,
            //   backgroundColor: Colors.transparent,
            //   child:
            //   Container(
            //     height: 500.h,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(10.r)
            //     ),
            //     child:
            //     Padding(
            //       padding: EdgeInsets.all(10.w),
            //       child: Column(
            //         children:
            //         [
            //           Container(
            //             height: 120.h,
            //             width: 120.w,
            //             decoration:BoxDecoration(
            //                 border: Border.all(width: 3.w),
            //                 shape: BoxShape.circle,
            //                 image: DecorationImage(
            //                     image: NetworkImage(BASE_URL +
            //                         GetStorage()
            //                             .read(AppConstant.profileImg)
            //                             .toString())
            //                 )
            //             ),
            //           ),
            //           Container(
            //             height:200.h,
            //               width: Get.width,
            //             child: Lottie.asset('assets/json/birthday.json'),),
            //           SizedBox(height: 10,),
            //           InkWell(onTap: (){
            //             Navigator.pop(context);
            //           },
            //             child: Container(
            //               height: 40.h,
            //               width: 150.w,
            //               decoration: BoxDecoration(
            //                   color: Colors.teal,
            //                   borderRadius: BorderRadius.circular(25.r)
            //               ),
            //               child: Center(child: Text("Back",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19.sp),textAlign: TextAlign.center)),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
      );
    }
    else
    {
      print("object");
    }
}




static contestWinners(BuildContext context,String name)
{
  print("dfjghjfd");
  DashboardController controller = Get.find();
  DateTime current_date = DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final DateFormat formatter2 = DateFormat('dd/MM');
  final DateFormat formatter3 = DateFormat('yyyy');

  final String currentdate = formatter.format(current_date);
  final String currentdate1 = formatter2.format(current_date);
  final String currentdate3 = formatter3.format(current_date);

  final String dob =controller.dob.toString();
  String str1 = dob;
  List<String> str2 = str1.split('/');
  String day = str2.isNotEmpty ? str2[0] : '';
  String  month= str2.length > 1 ? str2[1] : '';
  String year = str2.length > 2 ? str2[2] : '';
  String dataofbirth=day+"/"+month;
  int data=int. parse(currentdate3)-int.parse(year);
  if(currentdate1==dataofbirth)
  {
    showDialog(
      context: context,
      builder: (_) =>
          Dialog(
            alignment: Alignment.center,
            insetPadding:EdgeInsets.all(20) ,
            backgroundColor: Colors.transparent,
            child:
            Container(
              height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child:
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children:
                  [
                    Text("${data}th BIRTHDAY  ${name}",style: bodyText1Style.copyWith(color: Colors.red,fontSize: 20,),),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Lottie.asset('assets/json/birthday.json'),height: 350,width: Get.width,),
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.only(left: 20,right: 20),

                      child: Row(
                        children:
                        [
                          /*       MaterialButton(onPressed: ()
                            {
                               controller.isDob.value=false;
                               Navigator.pop(context);
                            },
                              shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              color: Colors.green.withOpacity(0.1),
                              child: Text("Hide",style: bodyText1Style.copyWith(color: Colors.black,fontSize: 15,)),),*/
                          Spacer(),
                          MaterialButton(onPressed: ()
                          {
                            Navigator.pop(context);

                          },
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            color: Colors.cyanAccent.withOpacity(0.1),
                            child: Text("Thank You",style: bodyText1Style.copyWith(color: Colors.black,fontSize: 15,)),)
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
    );
  }
  else
  {
    print("object");
  }
}


}