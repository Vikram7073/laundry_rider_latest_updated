import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_rider/api/service/dialog_service.dart';
import 'package:laundry_rider/api/service/toast_service.dart';
import 'package:laundry_rider/bloc/otp_bloc.dart';
import 'package:laundry_rider/common/constant/app_utils.dart';
import 'package:laundry_rider/locator/locator.dart';
import 'package:laundry_rider/ui/bottom_bar.dart';
import 'package:laundry_rider/ui/rider_detail_page_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../bloc/get_profile_bloc.dart';
import '../common/constant/color_constants.dart';
import '../common/constant/font_style.dart';
import '../common/constant/image.dart';
import '../common/custom_widget/custom_button.dart';
import '../model/get_profile_model.dart';
class OtpScreen extends StatefulWidget {
  String  ? mobileNumber;
   OtpScreen({Key? key,this.mobileNumber}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
 /* late OTPTextEditController controller;
  late OTPInteractor _otpInteractor;
  @override
  void initState() {
    super.initState();
    _otpInteractor = OTPInteractor();
    _otpInteractor
        .getAppSignature()
        .then((value) => print('signature - $value'));
    controller = OTPTextEditController(
      codeLength: 4,
      onCodeReceive: (code) => print('Your Application receive code - $code'),
      otpInteractor: _otpInteractor,
    )..startListenUserConsent(
          (code) {
        final exp = RegExp(r'(\d{4})');
        return exp.stringMatch(code ?? '') ?? '';
      },
    );
  }*/

  GetProfileModel ? getProfileModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // BlocProvider.of<GetProfileBloc>(context).add(GetProfileSubmitEvent());

  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.themeColor,
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 120.h,),
                  Image.asset(ImageControl.loginWithOtpImg,height: 150.h,),
                  SizedBox(height: 70.h,),
                  Text("We have sent OTP on your number",style: AppStyles.whiteColor16Text,),
                  SizedBox(height: 30.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal:20.w),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: const TextStyle(
                        color: ColorConstants.greenColor,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      enableActiveFill: true,
                      autoDisposeControllers: false,
                      enablePinAutofill: true,
                      errorTextSpace: 5,
                      useExternalAutoFillGroup: true,
                      obscureText: false,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10.r),
                          fieldHeight: 50.h,
                          fieldWidth: 45.w,
                          activeFillColor: Colors.white,
                          inactiveFillColor: ColorConstants.whiteColor,
                          activeColor: Colors.transparent,
                          inactiveColor: Colors.transparent
                      ),
                      animationType: AnimationType.fade,
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      // enabled: true,
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                      },
                      onChanged: (value) {
                        setState(() {
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Text("Didn't receive a OTP? Resend OTP",style: AppStyles.whiteColor16Text,),
                  SizedBox(height: 40.h,),
                  BlocListener<OTPBloc,OTPState>(
                    listener: (context,state){
                      if(state is OTPLoadingState){
                        locator<DialogService>().showLoader2();
                      }
                      else if( state is OTPSuccessState){
                        locator<DialogService>().hideLoader();
                        if(state.otpModel?.success==false){
                          locator<ToastService>().show(state.otpModel?.message??"");
                        }else{
                          locator<ToastService>().show(state.otpModel?.message??"");
                          AppUtils().setUserLoggedIn(state.otpModel?.data?.kycStatus??false);
                          if(state.otpModel?.data?.email==null || state.otpModel?.data?.email==""){
                            AppUtils().setToken(state.otpModel?.data?.token??"");
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> RiderDetailPageScreen()));
                          }else{
                            AppUtils().setToken(state.otpModel?.data?.token??"");
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
                          }
                        }
                      }
                    },
                    child: CustomButton(onTap: (){
                      BlocProvider.of<OTPBloc>(context).add(OTPSubmitEvent(widget.mobileNumber,otpController.text));

                    },text: "Verify",color: ColorConstants.backGroundColor,textStyle: AppStyles.whiteColor16Text,),
                  ),
                  SizedBox(height: 20.h,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
