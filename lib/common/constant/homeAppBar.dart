// import 'package:career_guide/common/constant/color_constants.dart';
// import 'package:career_guide/common/constant/font_style.dart';
// import 'package:career_guide/common/constant/string.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
//
// import '../../api/network/model/auth/profile_setting_model/get_profile_detail_model.dart';
// import '../../bloc/get_profile_details_bloc.dart';
// import 'image.dart';
// class HomeAppBar extends StatelessWidget {
//   const HomeAppBar({Key? key}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     GetProfileDetailModel? getProfileDetailModel;
//     var imageSize = MediaQuery.of(context).size.width;
//     return Container(
//       width: double.infinity,
//       decoration:  const BoxDecoration(
//         image: DecorationImage(image: AssetImage(ImageControl.homeBackgroundAppbar),fit: BoxFit.fill,),
//
//       ),
//       child: Padding(
//         padding:  EdgeInsets.only(left: 20.w,top: 40.h,right: 20.w,bottom: 10.h),
//         child: BlocConsumer<GetProfileDetailsBloc,GetProfileDetailsState>(listener: (context,state){
//           if(state is GetProfileDetailsSuccessState){
//             getProfileDetailModel=state.getProfileDetailModel;
//           }
//         },builder: (context,state){
//           return getProfileDetailModel!=null ?Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Container(
//                       //   height: imageSize*0.15,width: imageSize*0.15,
//                       //   decoration: BoxDecoration(
//                       //     borderRadius:BorderRadius.circular(imageSize*0.15),
//                       //     border: Border.all(width: 2.w,color: ColorConstants.whiteColor)
//                       //   ),
//                       //   child: ClipRRect(
//                       //       borderRadius: BorderRadius.circular(imageSize*0.15),
//                       //       child: Image.asset(ImageControl.profileImg,height: imageSize*0.15,width: imageSize*0.15,fit: BoxFit.fill,)),
//                       // ),
//                       // SizedBox(height: 20.h,),
//                       Text(getProfileDetailModel?.data?.profileSummary?.name??"",style: AppStyles.blackDarkColor20text,),
//                       //  Text(StringControl.startYoursToday,style: AppStyles.blackDark14Colortext,),
//                     ],
//                   ),
//                   Container(
//                       padding: EdgeInsets.all(8),
//                       // height: 110.h,width: 120.w,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black,width: 2),
//                           shape: BoxShape.circle,
//                           color: ColorConstants.whiteColor
//                       ),
//                       child:Image.asset(ImageControl.crownImg,height: imageSize*0.1,width: imageSize*0.1,)
//
//                     // ClipRRect(
//                     //     borderRadius: BorderRadius.circular(imageSize*0.03),
//                     //     child: Image.asset(ImageControl.homeAppbarRightImg,height: imageSize*0.25,width: imageSize*0.25,fit: BoxFit.fill,)),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20.h,),
//               Container(
//                 //  width: MediaQuery.of(context).size.width*0.9.w,
//                 decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 3)),
//                 child: LinearPercentIndicator(
//                   padding: EdgeInsets.zero,
//                   // width: MediaQuery.of(context).size.width*0.872.w,
//                   lineHeight: 14.0,
//                   percent: 0.2,
//                   backgroundColor: Colors.white,
//                   progressColor: Colors.red,
//
//                 ),
//               ),
//               SizedBox(height: 10.h,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Profile complete:  15%",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15.sp),),
//                   Text("Complete Now >>",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15.sp),)
//
//                 ],
//               ),
//             ],
//           ):SizedBox();
//         },
//         ),
//       ),
//     );
//   }
// }
