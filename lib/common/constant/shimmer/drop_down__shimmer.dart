import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../color_constants.dart';
class DropDownShimmer extends StatefulWidget {
  const DropDownShimmer({Key? key}) : super(key: key);
  @override
  State<DropDownShimmer> createState() => _DropDownShimmerState();
}
class _DropDownShimmerState extends State<DropDownShimmer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:145.h,
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: ColorConstants.themeColor.withOpacity(0.2),
        highlightColor:ColorConstants.greyColor.withOpacity(0.6),
        child: Card(
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const SizedBox(height: 50),
        )
      ),
    );
  }
}
