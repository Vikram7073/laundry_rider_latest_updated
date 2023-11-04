import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ListShimmer extends StatefulWidget {
  const ListShimmer({Key? key}) : super(key: key);

  @override
  State<ListShimmer> createState() => _ListShimmerState();
}

class _ListShimmerState extends State<ListShimmer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Card(
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: const SizedBox(height: 120),
            );
          },
        ),
      ),
    );
  }
}
