import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../color_constants.dart';
class HomeScreenShimmer extends StatefulWidget {
  const HomeScreenShimmer({Key? key}) : super(key: key);

  @override
  State<HomeScreenShimmer> createState() => _HomeScreenShimmerState();
}

class _HomeScreenShimmerState extends State<HomeScreenShimmer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:120.h,
      width: double.infinity,
      child: Shimmer.fromColors(
          baseColor: Colors.cyanAccent.withOpacity(0.4),
          highlightColor:Colors.cyanAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(height: 20.h,width: double.infinity,decoration: BoxDecoration(color: ColorConstants.blueLightColor,borderRadius: BorderRadius.circular(10.r)),
              // ),
              SizedBox(height: 10.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(height: 50.h,width: 50.h,decoration: const BoxDecoration(shape: BoxShape.circle,color: ColorConstants.blueLightColor),
                  ),
                ],
              ),


            ],),
      ),
    );
  }
}
