import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_rider/api/service/dialog_service.dart';
import 'package:laundry_rider/api/service/navigation_service.dart';
import 'package:laundry_rider/api/service/toast_service.dart';
import 'package:laundry_rider/bloc/logout_bloc.dart';
import 'package:laundry_rider/locator/locator.dart';
import 'package:laundry_rider/router/router.gr.dart';
import 'package:laundry_rider/ui/profile_screen.dart';
import 'package:laundry_rider/ui/term_condition_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/get_profile_bloc.dart';
import '../common/constant/color_constants.dart';
import '../common/constant/common_fuction.dart';
import '../common/constant/font_style.dart';
import '../common/constant/image.dart';
import '../common/constant/shimmer/list_shimmer_effect.dart';
import '../model/get_profile_model.dart';
import 'bottom_bar.dart';
class ProfileSettingScreen extends StatefulWidget {
   ProfileSettingScreen({Key? key}) : super(key: key);
  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}
class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  GetProfileModel ? getProfileModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetProfileBloc>(context).add(GetProfileSubmitEvent());
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocConsumer<GetProfileBloc,GetProfileState>(
        listener: (context,state){
          if(state is GetProfileSuccessState){
            getProfileModel=state.getProfileModel;
          }
        },
        builder: (context,state){
          return getProfileModel!=null?
          ListView(
            padding: EdgeInsets.zero,
            children: [
              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 8.h),
              //   width: double.infinity,
              //   decoration: const BoxDecoration(
              //       color: ColorConstants.themeColor
              //   ),
              //   child: Column(
              //     children: [
              //       SizedBox(height: 45.h,),
              //       ClipRRect(
              //         borderRadius: BorderRadius.circular(35.r),
              //         child: CachedNetworkImage(
              //           imageUrl: getProfileModel?.data?.profileImage??"",
              //           imageBuilder:
              //               (context, imageProvider) =>
              //               Container(
              //                 height: 70.h,
              //                 width: 70.w,
              //                 decoration: BoxDecoration(
              //                   image: DecorationImage(
              //                     image: imageProvider,
              //                     fit: BoxFit.fill,
              //                   ),
              //                 ),
              //               ),
              //           placeholder: (context, url) =>
              //               Shimmer(
              //                 duration: const Duration(seconds: 1),
              //                 //Default value
              //                 interval: const Duration(seconds: 0),
              //                 //Default value: Duration(seconds: 0)
              //                 color: ColorConstants.whiteColor,
              //                 //Default value
              //                 colorOpacity: 0,
              //                 //Default value
              //                 enabled: true,
              //                 //Default value
              //                 direction: const ShimmerDirection
              //                     .fromLTRB(),
              //                 //Default Value
              //                 child: Container(
              //                   color:
              //                   ColorConstants.greyDarkColor,
              //                 ),
              //               ),
              //           errorWidget: (context, url, error) =>
              //               Image.asset(
              //                 ImageControl.dummyProfile,height: size*0.2,width: size*0.2,fit: BoxFit.fill,),
              //         ),
              //       ),
              //       Text("${getProfileModel?.data?.firstName??""} ${getProfileModel?.data?.lastName??""}",style: AppStyles.whiteColor16Text,),
              //       Text(getProfileModel?.data?.email??"",style: AppStyles.whiteColor16Text,),
              //       Text(getProfileModel?.data?.mobileNo.toString()??"",style: AppStyles.whiteColor16Text,),
              //       Text(getProfileModel?.data?.currentLocation??"",style: AppStyles.whiteColor16Text,)
              //     ],
              //   ),
              // ),
              Container(
                alignment: Alignment.center,

                padding: EdgeInsets.only(top: 45.h,bottom: 10.h,left: 20.w,right: 0.w),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: ColorConstants.themeColor
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: 8.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35.r),
                            child: CachedNetworkImage(
                              imageUrl: getProfileModel?.data?.profileImage??"",
                              imageBuilder:
                                  (context, imageProvider) =>
                                  Container(
                                    height: 70.h,
                                    width: 70.w,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                              placeholder: (context, url) =>
                                  Shimmer(
                                    duration: const Duration(seconds: 1),
                                    //Default value
                                    interval: const Duration(seconds: 0),
                                    //Default value: Duration(seconds: 0)
                                    color: ColorConstants.whiteColor,
                                    //Default value
                                    colorOpacity: 0,
                                    //Default value
                                    enabled: true,
                                    //Default value
                                    direction: const ShimmerDirection
                                        .fromLTRB(),
                                    //Default Value
                                    child: Container(
                                      color:
                                      ColorConstants.greyDarkColor,
                                    ),
                                  ),
                              errorWidget: (context, url, error) =>
                                  Image.asset(
                                    ImageControl.dummyProfile,height: 70.h,width: 70.w,fit: BoxFit.fill,),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 180.w,
                                child: Text("${getProfileModel?.data?.firstName??" "} ${getProfileModel?.data?.lastName??""}",style: AppStyles.whiteColor16Text,)),
                            Text(getProfileModel?.data?.mobileNo.toString()??" ",style: AppStyles.whiteColor16Text,),
                            SizedBox(
                                width: 210.w,
                                child: Text(getProfileModel?.data?.email??"",style: AppStyles.whiteColor16Text.copyWith(fontSize: 14.sp),)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(getProfileModel: getProfileModel,)));
                      },
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          children: [
                            Image.asset(ImageControl.profileImg,height: 25.h,width: 25.w,color: ColorConstants.themeColor,),
                            SizedBox(width: 15.w,),
                            Text("Profile",style: AppStyles.backGround16Text,)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen(index: 1,)));
                      },
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          children: [
                            Image.asset(ImageControl.fileImg,height: 30.h,width: 30.w,color: ColorConstants.themeColor),
                            SizedBox(width: 12.w,),
                            Text("Booking",style: AppStyles.backGround16Text,)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen(index: 2,)));
                      },
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          children: [
                            Image.asset(ImageControl.truckImg,height: 25.h,color: ColorConstants.themeColor,),
                            SizedBox(width: 15.w,),
                            Text("Wallet",style: AppStyles.backGround16Text,)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await launchUrl(Uri.parse("mailto:${getProfileModel?.data?.supportEmail}"));
                      },
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          children: [
                            Icon(Icons.call,color: ColorConstants.themeColor,size: 30.sp,),
                            SizedBox(width: 10.w,),
                            Text("Help & Support",style: AppStyles.backGround16Text,)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Share.share('https://play.google.com/store/apps/details?id=com.BrightNok_rider');
                      },
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          children: [
                            Icon(Icons.share,color: ColorConstants.themeColor,size: 30.sp,),
                            SizedBox(width: 10.w,),
                            Text("Share",style: AppStyles.backGround16Text,)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TermConditionScreen(type: "Term",)));
                      },
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          children: [
                            Icon(Icons.text_snippet_rounded,color: ColorConstants.themeColor,size: 30.sp,),
                            SizedBox(width: 10.w,),
                            Text("Terms & Condition",style: AppStyles.backGround16Text,)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TermConditionScreen(type: "Privacy",)));
                      },
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          children: [
                            Icon(Icons.privacy_tip_outlined,color: ColorConstants.themeColor,size: 30.sp,),
                            SizedBox(width: 10.w,),
                            Text("Privacy Policy",style: AppStyles.backGround16Text,)
                          ],
                        ),
                      ),
                    ),
                    BlocListener<LogOutBloc,LogOutState>(
                      listener: (context,state){
                        if(state is LogOutLoadingState){
                          locator<DialogService>().showLoader2();
                        }
                        if(state is LogOutSuccessState){
                          locator<DialogService>().hideLoader();
                          locator<ToastService>().show(state.logOutModel?.message??"");
                          locator<NavigationService>().pushAndRemoveUntil(const LoginWithOtpScreenRoute());
                        }
                      },

                      child: InkWell(
                        onTap: (){
                          CommonFunction.showDialogAlert( context,
                              Text("Do you want to delete account ?",style: AppStyles.backGround14Text,),
                                  () {
                                    BlocProvider.of<LogOutBloc>(context).add(LogOutSubmitEvent());
                              });
                        },
                        child: Padding(
                          padding:  EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline_outlined,color: ColorConstants.themeColor,size: 30.sp,),
                              SizedBox(width: 10.w,),
                              Text("Delete Account",style: AppStyles.backGround16Text,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    BlocListener<LogOutBloc,LogOutState>(
                      listener: (context,state){
                        if(state is LogOutLoadingState){
                          locator<DialogService>().showLoader2();
                        }
                        if(state is LogOutSuccessState){
                          locator<DialogService>().hideLoader();
                          locator<ToastService>().show(state.logOutModel?.message??"");
                          locator<NavigationService>().pushAndRemoveUntil(const LoginWithOtpScreenRoute());
                        }
                      },
                      child: InkWell(
                        onTap: (){
                          CommonFunction.showDialogAlert( context,Text("Do you want to logout ?",style: AppStyles.backGround14Text,), () {
                            BlocProvider.of<LogOutBloc>(context).add(LogOutSubmitEvent());
                          });
                        },
                        child: Padding(
                          padding:  EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            children: [
                              Icon(Icons.logout,color: ColorConstants.themeColor,size: 30.sp,),
                              SizedBox(width: 10.w,),
                              Text("Logout",style: AppStyles.backGround16Text,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 80.h,)
                  ],
                ),
              ),
            ],
          ):const ListShimmer();
        },
      ),
    );
  }
}
