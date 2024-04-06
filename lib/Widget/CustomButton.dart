import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../AppConstant/textStyle.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  const CustomButton({Key? key, required this.onPress, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPress,
      child: Text(title.toUpperCase(),style:GoogleFonts.josefinSans(
        textStyle: TextStyle(
          color:  Colors.white,
          fontSize: 14.r,
          fontWeight: FontWeight.w600,
        ),
        fontSize: 16.r,
        fontWeight: FontWeight.w600,
      ),textAlign: TextAlign.center,),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: StadiumBorder(),
          padding: EdgeInsets.only(left: 21.r,right: 21.r,top: 13.r,bottom: 10.r)
        ),
    );
  }
}
