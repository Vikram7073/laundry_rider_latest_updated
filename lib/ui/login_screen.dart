import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_rider/common/constant/app_utils.dart';


import '../common/constant/color_constants.dart';
import '../common/constant/font_style.dart';
import '../common/constant/image.dart';
import '../common/custom_widget/custom_button.dart';
import 'login_with_otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.themeColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(ImageControl.loginImg,fit: BoxFit.fill,),
              SizedBox(height: 50.h,),
              Text("Become a Rider",style: AppStyles.whiteColor20Text,),
              SizedBox(height: 15.h,),
              // Padding(
              //   padding:  EdgeInsets.symmetric(horizontal: 25.w),
              //   child: Text("Lorem ipsum dolor sit amet consectetur,adipisicing elit. Quae cupiditate suscipit quam ",textAlign: TextAlign.center,style: AppStyles.whiteColor16Text,),
              // ),
              SizedBox(height: 30.h,),
              Padding(
                padding:   EdgeInsets.symmetric(horizontal: 20.w),
                child:     CustomButton(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginWithOtpScreen()));
                },text: "Login",
                  color: ColorConstants.whiteColor,
                  borderRadius: BorderRadius.circular(25.r),),
              ),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
      ),
    );
  }
}
