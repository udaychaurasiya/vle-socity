import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlesociety/Dashboard/view/profile.dart';
import 'package:vlesociety/Dashboard/view/profile/ChaAdmin.dart';

import '../AppConstant/textStyle.dart';

class CustomAppBar3 extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  const CustomAppBar3({Key? key, required this.title, required this.onPress})
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
              leading: Icon(Icons.arrow_back_sharp,color: Colors.black,),
              leadingWidth: 30,
              title:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: bodyText2Style,
                  ),
                ],
              ),
              elevation: 0.0,
            ),
          ),
        ),
      ],
    );
  }
}
