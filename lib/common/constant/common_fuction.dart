import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_rider/common/constant/font_style.dart';

import '../custom_widget/custom_button.dart';
import 'color_constants.dart';

class CommonFunction{

  static  Future<bool> onWillPop(BuildContext context) async {
    return (
        await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(

        title: const Text('Are you sure ?'),
        content: const Text('Do you want to exit this app ?'),
        actions: <Widget>[
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 17,vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomButton(onTap: (){
                   // locator<NavigationService>().pop();
                    Navigator.pop(context);
                  },
                    color: ColorConstants.greenLightColor,
                    buttonHeight: 40,
                    text: "No",
                  textStyle: AppStyles.whiteColor16Text,),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: CustomButton(onTap: (){
                    exit(0);
                  },
                    buttonHeight: 40,
                    textStyle: AppStyles.whiteColor16Text,

                    text: "Yes",),
                )
              ],
            ),
          )
         
          // TextButton(
          //   onPressed: () => Navigator.of(context).pop(false),
          //   child: const Text("No"),
          // ),
          // TextButton(
          //   onPressed: () => exit(0),
          //   child: const Text("Yes"),
          // ),
        ],
      ),
    )) ?? false;
  }

  // String dateTimeConvertMMMFormat(String date) {
  //   DateTime parsedDate = DateTime.parse(date.toString());
  //   final DateFormat formatter = DateFormat('dd MMM yyyy, hh:mm');
  //   final String formatted = formatter.format(parsedDate);
  //   return formatted;
  // }

  static  Future<bool> showDialogAlert(BuildContext context,Widget ? content, void Function() onTap) async {
    return (
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(

            title: const Text('Are you sure ?'),
            content: content,
            actions: <Widget>[
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 17.w,vertical: 0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomButton(onTap: (){
                        // locator<NavigationService>().pop();
                        Navigator.pop(context);
                      },
                        color: ColorConstants.backGroundColor,
                        buttonHeight: 40.h,
                        text: "No",
                        textStyle: AppStyles.whiteColor16Text,),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: CustomButton(
                        onTap: onTap,
                        buttonHeight: 40.h,
                        textStyle: AppStyles.whiteColor16Text,
                        text: "Yes",),
                    )
                  ],
                ),
              )

              // TextButton(
              //   onPressed: () => Navigator.of(context).pop(false),
              //   child: const Text("No"),
              // ),
              // TextButton(
              //   onPressed: () => exit(0),
              //   child: const Text("Yes"),
              // ),
            ],
          ),
        )) ?? false;
  }
}