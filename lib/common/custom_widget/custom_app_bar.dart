// import 'package:career_guide/common/constant/color_constants.dart';
// import 'package:career_guide/common/constant/font_style.dart';
// import 'package:career_guide/common/constant/image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../api/service/navigation_service.dart';
// import '../constant/string.dart';
// import '../locator/locator.dart';
//
// //ignore: must_be_immutable
// class CustomAppBar extends StatelessWidget {
//   String ?text2;
//   String ?text1;
//   String? richtext;
//   Widget? child;
//    CustomAppBar({Key? key, this.text2,this.text1,this.richtext,this.child}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent
//     ));
//     return Stack(
//       alignment: Alignment.center,
//       clipBehavior: Clip.none,
//       children: [
//         Container(
//           height: 110.h,width: double.infinity,
//           decoration: const BoxDecoration(
//               image: DecorationImage(image: AssetImage(ImageControl.backgroundAppBar),fit: BoxFit.fill)
//           ),
//           child: Padding(
//             padding: EdgeInsets.only(top: 30.h),
//             child: Row(
//               children: [
//                 IconButton(
//                 onPressed: (){
//                   locator<NavigationService>().pop();
//                 },
//                 icon:  const Icon(Icons.arrow_back,color: ColorConstants.whiteColor,)),
//                 SizedBox(width: 10.w,),
//                 Text(StringControl.back,style: AppStyles.appBarText,)
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//             bottom: -25.h,
//             child: Container(
//                 padding:  EdgeInsets.all(5.r),
//                 height: 50.h,width: 60.w,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15.r),
//                     color: ColorConstants.whiteColor
//                 ),
//                 child:child /*Image.asset(ImageControl.google, height: 40.h,width: 40.w,fit: BoxFit.fill,)*/
//             )
//         ),
//         Positioned(
//             bottom: -25.h,left: 10.w,
//             child:Text.rich(
//               TextSpan(
//                 children: [
//                   TextSpan(
//                     text:richtext ,
//                     style: GoogleFonts.dmSans(
//                         fontWeight: FontWeight.w700,
//                         fontSize: 14.sp,
//                         color: ColorConstants.blackDarkColor
//                     ),
//                   ),
//                   TextSpan(
//                     text: text1,
//                     style: GoogleFonts.dmSans(
//                       color: ColorConstants.grayLightColor,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 13.sp,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//         ),
//         Positioned(
//             bottom: -25.h,right: 10.w,
//             child: Text(text2??"",style: AppStyles.gray16Text,)),
//       ],
//     );
//   }
// }
//
//
//
