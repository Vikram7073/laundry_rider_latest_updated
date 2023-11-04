import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../color_constants.dart';

class HomeShimmer extends StatefulWidget {
  const HomeShimmer({Key? key}) : super(key: key);
  @override
  State<HomeShimmer> createState() => _HomeShimmerState();
}

class _HomeShimmerState extends State<HomeShimmer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height:145.h,
      width: double.infinity,
      child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor:Colors.grey[100]!,
          child:Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30.h,),
                Row(
                  children: [
                    Container(height: 50.h,width: 50.w,decoration:
                    const BoxDecoration(color: ColorConstants.blueLightColor,shape: BoxShape.circle),),
                    SizedBox(width: 60.w,),
                    Container(height: 20.h,width:100.w,decoration:  BoxDecoration(color: ColorConstants.blueLightColor,borderRadius: BorderRadius.circular(5.r)),),
                   const Spacer(),
                    Container(height: 25.h,width:25.w,decoration: const BoxDecoration(color: ColorConstants.blueLightColor),),




                  ],
                ),
                SizedBox(height: 15.h,),
                Container(height: 100.h,width: double.infinity,decoration: const BoxDecoration(color: ColorConstants.blueLightColor),),
                SizedBox(height: 10.h,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 10.h,width: 10.w,decoration: const BoxDecoration(color: ColorConstants.blueLightColor,shape: BoxShape.circle),
                    ),
                    SizedBox(width: 5.w,),
                    Container(height: 10.h,width: 10.w,decoration: const BoxDecoration(color: ColorConstants.blueLightColor,shape: BoxShape.circle),
                    ),
                    SizedBox(width: 5.w,),
                    Container(height: 10.h,width: 10.w,decoration: const BoxDecoration(color: ColorConstants.blueLightColor,shape: BoxShape.circle),
                    ),
                  ],
                ),
                SizedBox(height: 8.h,),
                Center(
                  child: Container(height: 20.h,width: 120.w,decoration: BoxDecoration(color: ColorConstants.blueLightColor,borderRadius: BorderRadius.circular(10.r)),
                  ),
                ),
                SizedBox(height: 15.h,),
                GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 8,
                  shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1/1.02,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3
                    ),
                    itemBuilder: (context,index){
                  return
                    Container(height: 50.h,width: 50.w,decoration: const BoxDecoration(color: ColorConstants.blueLightColor,),
                    );

                    }),
                SizedBox(height: 10.h,),
                Container(height: 100.h,width: double.infinity,
                decoration: const BoxDecoration(color: ColorConstants.blueLightColor),),
                SizedBox(height: 10.h,),
                GridView.builder(
                    itemCount: 8,
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1/1.02,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3
                    ),
                    itemBuilder: (context,index){
                      return
                        Container(height: 50.h,width: 50.w,decoration: const BoxDecoration(color: ColorConstants.blueLightColor,),
                        );

                    }),
              ],),
          ),
      ),
    );
  }
}
