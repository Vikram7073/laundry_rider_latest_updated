// import 'package:career_guide/api/service/dialog_service.dart';
// import 'package:career_guide/bloc/job_by_search_bloc.dart';
// import 'package:career_guide/common/constant/color_constants.dart';
// import 'package:career_guide/common/constant/string.dart';
// import 'package:career_guide/common/locator/locator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../api/network/model/auth/job_model/job_details_model.dart';
// import '../custom_widget/custom_field.dart';
// import 'app_utils.dart';
// import 'image.dart';
//
// class JobSearchAppBar extends StatefulWidget {
//    const JobSearchAppBar({Key? key,}) : super(key: key);
//
//   @override
//   State<JobSearchAppBar> createState() => _JobSearchAppBarState();
// }
//
// class _JobSearchAppBarState extends State<JobSearchAppBar> {
//
//   TextEditingController search=TextEditingController();
//   int? userId;
//   JobDetailsModel ?jobDetailsModel;
//
//
//   @override
//   void initState() {
//     super.initState();
//     getId();
//   }
//
//   getId() {
//     AppUtils().getId().then((value) {
//       userId = value;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent
//     ));
//     return  SizedBox();
//     //   Container(height: 110.h,width: double.infinity,
//     //   decoration: const BoxDecoration(
//     //     image: DecorationImage(image: AssetImage(ImageControl.jobSearchBackgroundImg),fit: BoxFit.fill),
//     //   ),
//     //   child: Padding(
//     //     padding:  EdgeInsets.only(left: 20.w,right: 20.w,top: 30.h),
//     //     child: BlocListener<JobBySearchBloc,JobBySearchState>(listener:(context,state){
//     //       if(state is JobBySearchLoadingState){
//     //         locator<DialogService>().showLoader();
//     //       }else if(state is JobBySearchSuccessState){
//     //         locator<DialogService>().hideLoader();
//     //       }
//     //     } ,
//     //       child: CustomField(controller: search, fillColor: ColorConstants.whiteColor, labelText: StringControl.searchJobTitle,maxLines: 1,
//     //         prefixIcon: Icon(Icons.search,color: ColorConstants.greyColor,size: 30.sp,),
//     //         onChange: (_){
//     //         // BlocProvider.of<JobBySearchBloc>(context).add(JobSearchFindEvent(userId??0,
//     //         //     search.text  ,jobDetailsModel?.data?.salaryFrom.toString() , jobDetailsModel?.data?.salaryTo.toString(),jobDetailsModel?.data?.salaryCurrency.toString()));
//     //
//     //         },
//     //       ),
//     //     // child: CustomField(controller: search, fillColor: ColorConstants.whiteColor, labelText: StringControl.searchJobTitle,maxLines: 1,
//     //     //   prefixIcon: Icon(Icons.search,color: ColorConstants.greyColor,size: 30.sp,),
//     //     ),
//     //   ),
//     // );
//   }
// }
