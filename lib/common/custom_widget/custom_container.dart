import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/color_constants.dart';

//ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
  String hintText;
  String headingText;
  void Function()? onTap ;
  CustomContainer({super.key, required this.hintText, required this.headingText,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headingText,
          style: GoogleFonts.dmSans(
              fontSize: 12.sp,
              color: ColorConstants.blueColor,
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
   onTap: onTap,
          child: Container(
            height: 40.h,
            width: 330,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1)),
            child: Padding(
              padding: const EdgeInsets.only(left: 20,bottom: 12,top: 12),
              child: Text(
                hintText,
                style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.greyColor),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }
}
