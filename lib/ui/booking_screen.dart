import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_rider/bloc/booking/booking_page_bloc.dart';
import 'package:laundry_rider/common/constant/color_constants.dart';
import 'package:laundry_rider/common/constant/font_style.dart';
import 'package:laundry_rider/common/custom_widget/custom_appbar.dart';
import 'package:laundry_rider/common/custom_widget/custom_button.dart';

import '../model/booking_page_model.dart';
import 'booking_pageTab_screen.dart';
import 'order_detail_screen.dart';
class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int ? currentIndex;
  BookingPageModel ? bookingPageModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<BookingPageBloc>(context).add(BookingPageSubmitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(45.h), child: CustomAppBar(
          title: Text("Booking",style: AppStyles.whiteColor20Text,),
          leading: const Text(""),
          centerTile: true,
        )),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
                child: TabBar(
                  unselectedLabelColor: ColorConstants.backGroundColor,
                  unselectedLabelStyle: AppStyles.backGround14Text,
                  labelStyle: AppStyles.backGround14Text.copyWith(fontSize: 14.sp),
                  padding: EdgeInsets.zero,
                  indicatorColor: Colors.transparent,
                  isScrollable: true,
                    indicatorPadding: EdgeInsets.zero,
                    indicator: BoxDecoration(
                      color: ColorConstants.themeColor,
                    border: Border.all(color:ColorConstants.backgroundColor.withOpacity(0.5),width: 2.w),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                    labelColor: ColorConstants.whiteColor,
                    tabs: const [
                      Tab(text: "Pending",),
                      Tab(text: "Accept",),
                      Tab(text: "Ongoing",),
                      Tab(text: "Pickup",),
                      Tab(text: "Delivered",),
                      Tab(text: "Cancelled",)

                    ]),
              ),
              SizedBox(height: 15.h,),
              Expanded(
                child: TabBarView(
                    children: [
                      BookingPageTabScreen(type: "Pending"),BookingPageTabScreen(type: "Accept"),BookingPageTabScreen(type: "Ongoing"),BookingPageTabScreen(type: "PickUp"),BookingPageTabScreen(type: "Deliver"),
                      BookingPageTabScreen(type: "Cancelled")

                ]),
              )

            ],
          ),
        ),
      ),
    );
  }
  // Widget TabPage( String ? type){
  //   return BlocConsumer<BookingPageBloc,BookingPageState>(
  //     listener: (context,state){
  //       if(state is BookingPageSuccessState){
  //         bookingPageModel=state.bookingPageModel;
  //       }
  //     },
  //     builder: (context,state){
  //       return ListView.builder(
  //           itemCount: bookingPageModel?.data.pending.length,
  //           shrinkWrap: true,
  //           itemBuilder: (context,index){
  //             return Padding(
  //               padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10.r),
  //                     border: Border.all(color: ColorConstants.backgroundColor)
  //                 ),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(bookingPageModel?.data.pending[index].bookId.toString()??"",style: AppStyles.backGround14Text,),
  //                         InkWell(
  //                           onTap: (){
  //                             Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailScreen()));
  //                           },
  //                           child: Card(
  //                               elevation: 2,
  //                               child: Text("#124434",style: AppStyles.backGround14Text,)),
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(height: 5.h,),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Container(
  //                           padding: EdgeInsets.only(left: 5.w),
  //                           width: 110.w,
  //                           decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(10.r),
  //                               color: ColorConstants.whiteColor,
  //                               border: Border.all(color: ColorConstants.themeColor)
  //                           ),
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text("Date ",style: AppStyles.backGround14Text,),
  //                               Text("15-10-2023",style: AppStyles.backGround14Text,),
  //                             ],
  //                           ),
  //                         ),
  //                         Container(
  //                           padding: EdgeInsets.only(right: 5.w),
  //                           width: 110.w,
  //                           decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(10.r),
  //                               color: ColorConstants.whiteColor,
  //                               border: Border.all(color: ColorConstants.themeColor)
  //                           ),
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.end,
  //                             children: [
  //                               Text("Time Slot",style: AppStyles.backGround14Text,),
  //                               Text("10:00 AM",style: AppStyles.backGround14Text,),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(height: 5.h,),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text("Address",style: AppStyles.backGround14Text,),
  //                         SizedBox(
  //                             width: 180.w,
  //                             child: Text("61, brixcode llp rajat pata,mansarovar jaipur",textAlign: TextAlign.right,style: AppStyles.backGround14Text,)),
  //                       ],
  //                     ),
  //                     SizedBox(height: 5.h,),
  //                     Row(
  //                       children: [
  //                         Expanded(
  //                           child: CustomButton(onTap: (){},text: "Cancel",
  //                             buttonHeight: 40.h,
  //                             color: ColorConstants.backGroundColor,textStyle: AppStyles.whiteColor16Text,),
  //                         ),
  //                         SizedBox(width: 35.h,),
  //                         Expanded(
  //                           child: CustomButton(onTap: (){},text: "Accept",color: ColorConstants.themeColor,
  //                             buttonHeight: 40.h,
  //                             textStyle: AppStyles.whiteColor16Text,),
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(height: 5.h,),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           });
  //     },
  //   );
  // }
}
