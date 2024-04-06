import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pinput/pinput.dart';
import 'package:vlesociety/AppConstant/textStyle.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import '../../Widget/ArrowTitleAppBar.dart';
import '../../Widget/CustomButton.dart';
import '../controller/login_controller.dart';
class OtypVerifyPage extends StatefulWidget {
  final String id;
  OtypVerifyPage({Key? key, required this.id,}) : super(key: key);

  @override
  State<OtypVerifyPage> createState() => _OtypVerifyPageState();
}

class _OtypVerifyPageState extends State<OtypVerifyPage> {
  LoginController _controller=Get.find();
  DateTime ?currentBackPressTime;
  DashboardController controller=Get.put(DashboardController());

 String etotp="";

  @override
  Widget build(BuildContext context)
  {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
    final defaultPinTheme = PinTheme(
      width: 50.r,
      height: 50.r,
      textStyle:  TextStyle(
        fontSize: 22.r,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19.r),
        border: Border.all(color: Colors.black),
      ),
    );
    _controller.startTimer();
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
       body: Scrollbar(
         child: SingleChildScrollView(
           child: SafeArea(
             child: Container(
               child: Column(
                 children: [
                   SizedBox(height: 40.r,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: 18.w),
                          child: Text("Verify",style: titleStyle.copyWith(fontSize: 18.r),textAlign: TextAlign.start,),
                        ),
                      ],
                    ),
                   SizedBox(height: 40.r,),
                 Text("Enter the verification code we just sent\nyou on your ${_controller.etMobile.text}",style: smallTextStyle.copyWith(fontSize: 14.r),textAlign: TextAlign.center,),
                     SizedBox(height: 50.r,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Padding(
                         padding:  EdgeInsets.only(top: 5.r),
                         child: Text("Code  ",style: titleStyle.copyWith(fontSize: 18.r,color: Colors.black38),textAlign: TextAlign.center,),
                       ),
                       // Container(
                       //   width: 150,
                       //   height: 40,
                       //   child: OTPTextField(
                       //     length: 4,
                       //     width: MediaQuery.of(context).size.width,
                       //     fieldWidth: 30,
                       //     style:const TextStyle(
                       //         fontSize: 17,fontWeight: FontWeight.bold
                       //     ),
                       //     textFieldAlignment: MainAxisAlignment.spaceAround,
                       //     fieldStyle: FieldStyle.underline,
                       //     onCompleted: (pin)
                       //     {
                       //        etotp=pin;
                       //        if(etotp!=null)
                       //         {
                       //          _controller.verifyNetworkApi(widget.id, pin);
                       //           }
                       //       },
                       //
                       //   ),
                       // ),
                       Container(
                         width: 150.r,
                         height: 40.r,
                         child:Pinput(
                           length: 4,
                           onCompleted: (pin)
                           {
                             etotp=pin;
                             if(etotp!=null)
                             {
                               _controller.verifyNetworkApi(widget.id, pin);
                             }
                           },
                           cursor: Column(
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                               Container(
                                 margin:  EdgeInsets.only(bottom: 9.r),
                                 width: 22.r,
                                 height: 1.r,
                                 color: focusedBorderColor,
                               ),
                             ],
                           ),
                           focusedPinTheme: defaultPinTheme.copyWith(
                             decoration: defaultPinTheme.decoration!.copyWith(
                               borderRadius: BorderRadius.circular(6.r),
                               border: Border.all(color: focusedBorderColor),
                             ),
                           ),
                           submittedPinTheme: defaultPinTheme.copyWith(
                             decoration: defaultPinTheme.decoration!.copyWith(
                               color: fillColor,
                               borderRadius: BorderRadius.circular(10.r),
                               border: Border.all(color: focusedBorderColor),
                             ),
                           ),
                           errorPinTheme: defaultPinTheme.copyBorderWith(
                             border: Border.all(color: Colors.redAccent),
                           ),
                         ),
                       ),
                     ],
                   ),
                   Container(
                       margin: EdgeInsets.only(top:50.r,right: 15.r,bottom: 50.r),
                       width:Get.width,
                       child: Obx(() =>  Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             Text(_controller.start.value.toString(),style: titleStyle.copyWith(fontSize: 16.r,
                                 color: _controller.start.value!=0? Colors.blue:Colors.grey.withOpacity(0.4)),
                               textAlign: TextAlign.end,),
                             TextButton(child:Text("Resend Code?",
                               style: titleStyle.copyWith(fontSize: 16.r,
                                   decoration: TextDecoration.underline,
                                   color: _controller.start.value==0?Colors.blue:Colors.grey.withOpacity(0.4)),textAlign: TextAlign.end,),
                             onPressed:_controller.start.value==0? ()
                             {
                               _controller.start.value=120;
                               _controller.startTimer();
                               _controller.loginNetworkApi();
                             }:null,
                             ),
                           ],
                         ),
                       )),

                   CustomButton(onPress: ()
                   { if(etotp!=null)
                     { _controller.verifyNetworkApi(widget.id, etotp);}

                   },title: "Verify Code",)
                 ],
               ),
             ),
           ),
         ),
       ),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Press again to exit"),
            backgroundColor:Theme.of(context).appBarTheme.backgroundColor,
            elevation: 10, //shadow
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 70.h,left: 30.w,right: 30.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r),
            ),
          )
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
