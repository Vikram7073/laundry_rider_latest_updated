// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../constant/color_constants.dart';
// import '../constant/image.dart';
// import '../constant/string.dart';
// class CommonAppBar extends StatelessWidget {
//   bool delete;
//   bool title;
//   Widget? titles;
//   Widget ? action;
//   void Function() ? ontap;
//
//    CommonAppBar({Key? key,this.delete=false,this.ontap,this.title=false,this.titles,this.action}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//     ));
//     return Padding(
//       padding:  EdgeInsets.only(top: 20.h),
//       child: SizedBox(
//         height: 45.h,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               child:  title?Image.asset(ImageControl.appbarLogo,height: 45,width: 200,):Padding(
//                 padding:  EdgeInsets.only(left: 15.w),
//                 child: titles,
//               ),
//             ),Container(
//               child:delete?Padding(
//                 padding:  EdgeInsets.only(right: 15.w),
//                 child: const Icon(Icons.notifications_none,color: ColorConstants.blackDarkColor,),
//               ):Padding(
//                 padding:  EdgeInsets.only(right: 15.w),
//                 child: InkWell(
//                     onTap:(){
//                      // locator<NavigationService>().pop();
//                     },
//                     child: action),
//               ),
//             )
//
//           ],
//         ),
//       ),
//     );
//
//  /*     Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leadingWidth: 30,
//         centerTitle: true,
//         title: title?Image.asset(ImageControl.appbarLogo,height: 45,width: 200,):titles,
//          actions: [
//            delete?const Icon(Icons.notifications,color: ColorConstants.blackDarkColor,):SizedBox(),
//          SizedBox(width: 20.w,)],
//       ),*/
//         //
//         // leading: IconButton(
//         //     onPressed: () {
//         //       locator<NavigationService>().pop();
//         //     },
//         //     icon: const Icon(
//         //       Icons.arrow_back,
//         //       color: ColorConstants.greyBlackColor,
//         //     )),
//         // actions: [delete?Text('Delete all',style: GoogleFonts.ubuntu(color: ColorConstants.redColor,
//         //     fontSize: 16.sp,fontWeight: FontWeight.w400),):SizedBox(),
//         // SizedBox(width: 20.w,)],
//
//   }
// }
