import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/color_constants.dart';
class CommonRow extends StatelessWidget {
  bool?showBack;
  String? upperText;
  String? lowerText;
   CommonRow({Key? key,this.showBack=true,this.lowerText,this.upperText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      showBack==true ? InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 6,top: 6,right: 6),
          child: Container(
            height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      // stops: [0.1, 0.5, 0.7, 0.9],
                      colors: [
                        ColorConstants.whiteColor.withOpacity(0.0048),ColorConstants.whiteColor.withOpacity(0.2)]
                  ),
                  border: Border.all(color: ColorConstants.whiteColor.withOpacity(0.2)),
                  // color: ColorConstants.backgroundColor.withOpacity(0.8),
                  shape: BoxShape.circle
              ),
              child: Icon(Icons.arrow_back_rounded,color: ColorConstants.whiteColor,size: 20.sp,)),
        ),
      ):Container(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(upperText??"",style: GoogleFonts.poppins(fontSize: 25.sp,fontWeight: FontWeight.w700,color: ColorConstants.whiteColor),),
        Text(lowerText??"",style: GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w500,color: ColorConstants.smallTextColor),)
      ],)
    ],);
  }
}
