import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../color_constants.dart';
class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height:145.h,
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor:Colors.grey[100]!,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 75.h,width: 75.w,decoration: const BoxDecoration(shape: BoxShape.circle,color: ColorConstants.blueLightColor),
            ),
            SizedBox(height: 5.h,),
            Container(height: 10.h,width: 130.w,decoration: BoxDecoration(color: ColorConstants.blueLightColor,borderRadius: BorderRadius.circular(10.r)),
            ),SizedBox(height: 5.h,),
            Container(height: 10.h,width: 130.w,decoration: BoxDecoration(color: ColorConstants.blueLightColor,borderRadius: BorderRadius.circular(10.r)),
            ),
            SizedBox(height: 15.h,),
            // SizedBox(height: 50.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 50.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
               Container(height: 35.h,width: 120.w,decoration: BoxDecoration(color: ColorConstants.blueLightColor,borderRadius: BorderRadius.circular(10.r)),
               ),
                Container(height: 35.h,width: 120.w,decoration: BoxDecoration(color: ColorConstants.blueLightColor,borderRadius: BorderRadius.circular(10.r)),
                )],),
            )
          ],),
      ),
    );
  }
}
