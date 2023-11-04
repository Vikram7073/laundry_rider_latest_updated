import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:laundry_rider/api/service/dialog_service.dart';
import 'package:laundry_rider/api/service/toast_service.dart';
import 'package:laundry_rider/bloc/login_bloc.dart';
import 'package:laundry_rider/locator/locator.dart';


import '../common/constant/app_utils.dart';
import '../common/constant/color_constants.dart';
import '../common/constant/font_style.dart';
import '../common/constant/image.dart';
import 'otp_screen.dart';
class LoginWithOtpScreen extends StatefulWidget {
  const LoginWithOtpScreen({Key? key}) : super(key: key);

  @override
  State<LoginWithOtpScreen> createState() => _LoginWithOtpScreenState();
}

class _LoginWithOtpScreenState extends State<LoginWithOtpScreen> {
  TextEditingController phoneNumberController=TextEditingController();
  String ? FcmToken;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setFcmToken();
    getFcmToken();

  }

  setFcmToken(){
    FirebaseMessaging.instance.getToken().then((value) {
      AppUtils().setFcm(value.toString());
      print("this is fcm token ${value}");
    });
  }

  Future getFcmToken(){
    return AppUtils().getFcm().then((value){
      setState(() {
        FcmToken=value.toString();
      });
    });
  }
  @override
  Widget build(BuildContext context) {

 //  var  height1= MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            clipBehavior: Clip.none,
           // alignment: Alignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                color: ColorConstants.themeColor,
                height: MediaQuery.of(context).size.height*0.5.h,
                  width: double.infinity,

                  child: Image.asset(ImageControl.loginWithOtpImg,fit: BoxFit.fill,height: 150.h,)),
              Positioned(
                bottom: MediaQuery.of(context).size.height*0.18.h,
                left: 10.w,
                right: 10.w,
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 35.w,),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 20.h),
                    child: Column(
                      children: [
                        Text("OTP Login",style: AppStyles.whiteColor20Text.copyWith(color: ColorConstants.themeColor),),
                        SizedBox(height: 10.h,),
                        Text("Please enter your mobile number to receive One Time Password.",
                          textAlign: TextAlign.center,
                          style: AppStyles.whiteColor16Text.copyWith(color: ColorConstants.brownColor),),
                        // SizedBox(height: 10.h,),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                          child: IntlPhoneField(
                            controller: phoneNumberController,
                            disableLengthCheck: true,
                            dropdownIconPosition: IconPosition.trailing,
                            //flagsButtonMargin: EdgeInsets.zero,
                            keyboardType: TextInputType.phone,
                            //showCountryFlag: false,
                            dropdownIcon: const Icon(Icons.keyboard_arrow_down_outlined,color: ColorConstants.themeColor,),
                            decoration: const InputDecoration(

                              enabledBorder: UnderlineInputBorder(),
                              disabledBorder: InputBorder.none,
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide()),
                              hintText: 'Mobile Number',
                              border: OutlineInputBorder(

                                borderSide: BorderSide( ),
                              ),
                            ),
                            initialCountryCode: 'IN',
                            onChanged: (phone) {

                            },
                            onTap: (){},
                          ),
                        ),
                        SizedBox(height: 40.h,),

                      ],
                    ),
                  ),
                ),
              ),
              BlocListener<LoginBloc,LoginState>(
                listener: (context,state){
                  if(state is LoginLoadingState){
                    locator<DialogService>().showLoader();
                  }
                  else if(state is LoginSuccessState){
                    locator<DialogService>().hideLoader();
                    if(state.loginModel?.success==false){
                      locator<ToastService>().show(state.loginModel?.message??"");
                    }else{
                      locator<ToastService>().show(state.loginModel?.message??"");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> OtpScreen(mobileNumber: phoneNumberController.text,)));
                      
                    }
                  }
                },
                child: Positioned(
                  left: 0.w,right: 0.w,
                  bottom: MediaQuery.of(context).size.height*0.14.h,
                  child: InkWell(
                    onTap: (){
                      BlocProvider.of<LoginBloc>(context).add(LoginSubmitEvent(phoneNumberController.text,FcmToken));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.h,width: 50.w,
                      decoration: const BoxDecoration(
                          color: ColorConstants.backGroundColor,
                          shape: BoxShape.circle
                      ),
                      child: const Icon(Icons.arrow_forward_outlined,color: ColorConstants.whiteColor,),
                    ),
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
