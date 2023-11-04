import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../color_constants.dart';
class FilterShimmer extends StatefulWidget {
  const FilterShimmer({Key? key}) : super(key: key);

  @override
  State<FilterShimmer> createState() => _FilterShimmerState();
}

class _FilterShimmerState extends State<FilterShimmer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            itemBuilder: (context,index){
              return  Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: ColorConstants.grayLightColor)
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 7,
                      itemBuilder: (context,index){
                        return Card(
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const SizedBox(height: 40),

                        );
                      }),
                ),
              );
            },
          )
      ),
    );  }
}
