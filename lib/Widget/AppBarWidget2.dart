import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlesociety/Dashboard/view/profile.dart';
import 'package:vlesociety/Dashboard/view/profile/ChaAdmin.dart';

import '../AppConstant/textStyle.dart';

class CustomAppBar2 extends StatelessWidget {
  final String title;
  final String image;
  final String Points;
  final VoidCallback onPress;
  const CustomAppBar2({Key? key, required this.title, required this.image, required this.Points, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: -80,
            right: 60,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffcdf55a),
              ),
            )),
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: AppBar(
              backgroundColor: Colors.white.withOpacity(0.5),
              leading: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.amber.withOpacity(0.1),
                  backgroundImage: NetworkImage(image),
                ),
              ),
              leadingWidth: 60,
              title:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    Points +" Points",
                    style: smallTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        color: Colors.green),
                  ),
                ],
              ),
              elevation: 0.0,
              actions: [
                RawMaterialButton(
                  constraints: BoxConstraints(
                      maxHeight: 30.h, minWidth: 30.w),
                  onPressed:onPress,
                  shape: CircleBorder(),
                  child: Image.asset
                    (
                    "assets/images/shoppingcart.png",
                    height: 25.h,
                    width: 25.w,
                    fit: BoxFit.fill,
                  ),
                ),
                RawMaterialButton(
                  constraints:
                  BoxConstraints(maxHeight: 40.h, minWidth: 40.w),
                  onPressed: () {
                    if(int.parse(Points)>=100){
                      Get.to(() => chats());
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Points must be 100 or more to proceed.')),
                      );
                    }
                  },
                  shape: CircleBorder(),
                  child: Image.asset(
                    "assets/images/chat.png",
                    height: 35,
                    width: 35,
                    fit: BoxFit.fill,
                  ),
                ),
                RawMaterialButton(
                  constraints: BoxConstraints(maxHeight: 30, minWidth: 30),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  shape: CircleBorder(),
                  child: Image.asset(
                    "assets/images/back.png",
                    height: 30.h,
                    width: 30.w,
                    fit: BoxFit.fill,
                  ),
                ),

                SizedBox(
                  width: 8,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
