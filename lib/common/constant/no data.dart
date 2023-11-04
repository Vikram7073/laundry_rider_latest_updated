
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'font_style.dart';
import 'image.dart';

class NoDataFound{

  noData(){
    return  Center(
        child:Column(
          children: [
            SizedBox(height: 80.h,),
            Image.asset(ImageControl.nodataImg),
            Text("No data found",style: AppStyles.blackDarkColor14text,),
          ],
        ));
  }


}