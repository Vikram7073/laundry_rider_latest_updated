import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry_rider/bloc/booking/accept_booking_bloc.dart';
import 'package:laundry_rider/bloc/booking/deliver_booking_bloc.dart';
import 'package:laundry_rider/bloc/booking/ongoing_booking_bloc.dart';
import 'package:laundry_rider/bloc/booking/picup_booking_bloc.dart';
import 'package:laundry_rider/common/constant/shimmer/list_shimmer_effect.dart';
import 'package:laundry_rider/locator/locator.dart';
import 'package:laundry_rider/ui/notification/firebase_notification.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../api/service/dialog_service.dart';
import '../api/service/toast_service.dart';
import '../bloc/booking/booking_page_bloc.dart';
import '../bloc/booking_cancel_bloc.dart';
import '../common/constant/color_constants.dart';
import '../common/constant/font_style.dart';
import '../common/constant/no data.dart';
import '../common/custom_widget/custom_button.dart';
import '../model/booking_page_model.dart';
import 'map.dart';
import 'order_detail_screen.dart';
class BookingPageTabScreen extends StatefulWidget {
  String ? type;
   BookingPageTabScreen({super.key,this.type});

  @override
  State<BookingPageTabScreen> createState() => _BookingPageTabScreenState();
}

class _BookingPageTabScreenState extends State<BookingPageTabScreen> {
  Completer<GoogleMapController> _controller = Completer();
 // final availableMaps = await MapLauncher.installedMaps;
  BookingPageModel ? bookingPageModel;
  int ? selectedIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<BookingPageBloc>(context).add(BookingPageSubmitEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BookingPageBloc,BookingPageState>(
       listener: (context,state){
       if(state is BookingPageSuccessState){
        bookingPageModel=state.bookingPageModel;
       }
      },
      builder: (context,state){
        return  bookingPageModel != null ?
       widget.type == "Pending" ?
       bookingPageModel?.data.pending.length!=0?
       ListView.builder(
          itemCount: bookingPageModel?.data.pending.length,
          shrinkWrap: true,
          itemBuilder: (context,index){
            var booking=bookingPageModel?.data.pending?[index];
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: ColorConstants.backgroundColor)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order Id",style: AppStyles.backGround14Text,),
                        InkWell(
                          onTap: (){
                            setState(() {
                              selectedIndex=index;
                            });
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailScreen(bookId: booking?.bookId??0,type: "Pending",)));
                          },
                          child: Card(
                              elevation: 2,
                              child: Text(booking?.bookingId.toString()??"",style: AppStyles.backGround14Text,)),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5.w),
                          width: 110.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: ColorConstants.whiteColor,
                              border: Border.all(color: ColorConstants.themeColor)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date ",style: AppStyles.backGround14Text,),
                              Text(booking?.date??"",style: AppStyles.backGround14Text,),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 5.w),
                          width: 110.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: ColorConstants.whiteColor,
                              border: Border.all(color: ColorConstants.themeColor)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Time Slot",style: AppStyles.backGround14Text,),
                              Text(booking?.time??"",style: AppStyles.backGround14Text,),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Address",style: AppStyles.backGround14Text,),
                        IconButton(
                            onPressed: () async {
                                try {
                                  await launchUrlString('https://www.google.com/maps/search/?api=1&query=${booking?.late},${booking?.long}',
                                      mode: LaunchMode.externalApplication);
                                } catch (e) {
                                  debugPrint(  "🚀 catched error~ $e:");
                                }
                            }, icon:const Icon(Icons.location_on)),
                        SizedBox(width: 30.w,),

                        SizedBox(
                            width: 180.w,
                            child: Text(booking?.address??"",textAlign: TextAlign.right,style: AppStyles.backGround14Text,)),
                      ],
                    ),
                    SizedBox(height: 5.h,),
                    BlocListener<AcceptBookingBloc,AcceptBookingState>(
                      listener: (context,state){
                        if(state is AcceptBookingLoadingState){
                          locator<DialogService>().showLoader2();
                        }
                        else if(state is AcceptBookingSuccessState){
                          locator<DialogService>().hideLoader();

                          if(index==state.index){
                            locator<ToastService>().show(state.acceptBookingModel?.message??"");
                            send_notification(
                                [booking?.token.toString()??""],
                                "Order Accept Successfully"
                            );
                            BlocProvider.of<BookingPageBloc>(context).add(BookingPageSubmitEvent());

                          }

                        }
                      },
                      child: CustomButton(onTap: (){
                        BlocProvider.of<AcceptBookingBloc>(context).add(AcceptBookingSubmitEvent(booking?.bookId.toString()??"",index));

                      },text: "Accept",color: ColorConstants.themeColor,
                        buttonHeight: 40.h,
                        textStyle: AppStyles.whiteColor16Text,),
                    ),
                    SizedBox(height: 5.h,),
                  ],
                ),
              ),
            );
          }):
       NoDataFound().noData():
          widget.type == "Accept" ?
          bookingPageModel?.data.accept.length!=0?
          ListView.builder(
              itemCount: bookingPageModel?.data.accept.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
                var booking=bookingPageModel?.data.accept?[index];
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: ColorConstants.backgroundColor)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Order Id",style: AppStyles.backGround14Text,),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  selectedIndex=index;
                                  print ("thi is tioken${booking?.token.toString()??""}");

                                });
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailScreen(bookId: booking?.bookId??0,type: "Accept",)));                              },
                              child: Card(
                                  elevation: 2,
                                  child: Text(booking?.bookingId.toString()??"",style: AppStyles.backGround14Text,)),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5.w),
                              width: 110.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: ColorConstants.whiteColor,
                                  border: Border.all(color: ColorConstants.themeColor)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Date ",style: AppStyles.backGround14Text,),
                                  Text(booking?.date??"",style: AppStyles.backGround14Text,),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 5.w),
                              width: 110.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: ColorConstants.whiteColor,
                                  border: Border.all(color: ColorConstants.themeColor)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Time Slot",style: AppStyles.backGround14Text,),
                                  Text(booking?.time??"",style: AppStyles.backGround14Text,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Address",style: AppStyles.backGround14Text,),
                            IconButton(

                                onPressed: () async {

                                  try {
                                    await launchUrlString('https://www.google.com/maps/search/?api=1&query=${booking?.late},${booking?.long}',
                                        mode: LaunchMode.externalApplication);
                                  } catch (e) {
                                    debugPrint(  "🚀 catched error~ $e:");
                                  }
                                }, icon:const Icon(Icons.location_on)),
                            SizedBox(width: 30.w,),

                            SizedBox(
                                width: 180.w,
                                child: Text(booking?.address??"",textAlign: TextAlign.right,style: AppStyles.backGround14Text,)),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        BlocListener<OngoingBookingBloc,OngoingBookingState>(
                          listener: (context,state){
                            if(state is OngoingBookingLoadingState){
                              locator<DialogService>().showLoader2();
                            }
                            else if(state is OngoingBookingSuccessState){
                              locator<DialogService>().hideLoader();
                              if(index==state.index){
                                locator<ToastService>().show(state.ongoingBookingModel?.message??"");
                                send_notification(
                                    [booking?.token.toString()??""],
                                    "Booking Ongoing "
                                );
                                BlocProvider.of<BookingPageBloc>(context).add(BookingPageSubmitEvent());
                              }
                            }
                          },
                          child: CustomButton(onTap: (){
                            BlocProvider.of<OngoingBookingBloc>(context).add(OngoingBookingSubmitEvent(booking?.bookId.toString()??"",index));

                          },text: "OnGoing",color: ColorConstants.themeColor,
                            buttonHeight: 40.h,
                            textStyle: AppStyles.whiteColor16Text,),
                        ),
                        SizedBox(height: 5.h,),
                      ],
                    ),
                  ),
                );
              }):
          NoDataFound().noData():

          widget.type == "Ongoing" ?
          bookingPageModel?.data.ongoing.length!=0?
          ListView.builder(
              itemCount: bookingPageModel?.data.ongoing.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
                var booking=bookingPageModel?.data.ongoing?[index];
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: ColorConstants.backgroundColor)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Order Id",style: AppStyles.backGround14Text,),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  selectedIndex=index;
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailScreen(bookId: booking?.bookId??0,type: "Ongoing",)));
                              },
                              child: Card(
                                  elevation: 2,
                                  child: Text(booking?.bookingId.toString()??"",style: AppStyles.backGround14Text,)),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5.w),
                              width: 110.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: ColorConstants.whiteColor,
                                  border: Border.all(color: ColorConstants.themeColor)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Date ",style: AppStyles.backGround14Text,),
                                  Text(booking?.date??"",style: AppStyles.backGround14Text,),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 5.w),
                              width: 110.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: ColorConstants.whiteColor,
                                  border: Border.all(color: ColorConstants.themeColor)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Time Slot",style: AppStyles.backGround14Text,),
                                  Text(booking?.time??"",style: AppStyles.backGround14Text,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Address",style: AppStyles.backGround14Text,),
                            IconButton(

                                onPressed: () async {

                                  try {
                                    await launchUrlString('https://www.google.com/maps/search/?api=1&query=${booking?.late},${booking?.long}',
                                        mode: LaunchMode.externalApplication);
                                  } catch (e) {
                                    debugPrint(  "🚀 catched error~ $e:");
                                  }
                                }, icon:const Icon(Icons.location_on)),
                            SizedBox(width: 30.w,),

                            SizedBox(
                                width: 180.w,
                                child: Text(booking?.address??"",textAlign: TextAlign.right,style: AppStyles.backGround14Text,)),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Row(
                          children: [

                            booking?.pickUpStatus == true ?
                            BlocListener<BooingCancelBloc,BooingCancelState>(
                              listener: (context,state){
                                if(state is BooingCancelLoadingState){
                                  locator<DialogService>().showLoader2();
                                }
                                else if(state is BooingCancelSuccessState){
                                  locator<DialogService>().hideLoader();
                                  locator<ToastService>().show(state.bookingCancelModel?.message??'');
                                  BlocProvider.of<BookingPageBloc>(context).add(BookingPageSubmitEvent());
                                }
                              },
                              child: Expanded(
                                  child: CustomButton(onTap: (){
                                    BlocProvider.of<BooingCancelBloc>(context).add(BooingCancelSubmitEvent(booking?.bookId.toString()));
                                  },
                                    buttonHeight: 35.h,
                                    text: "Cancel",color: ColorConstants.redColor,textStyle: AppStyles.whiteColor16Text,)),
                            ):
                            SizedBox(),
                            SizedBox(width: 10.w,),
                            BlocListener<PickUpBookingBloc,PickUpBookingState>(
                              listener: (context,state){
                                if(state is PickUpBookingLoadingState){
                                  locator<DialogService>().showLoader2();
                                }
                                else if(state is PickUpBookingSuccessState){
                                  locator<DialogService>().hideLoader();
                                  if(index==state.index){
                                    locator<ToastService>().show(state.pickUpBookingModel?.message??"");
                                    send_notification(
                                        [booking?.token.toString()??""],
                                        "Order PickUp Successful"
                                    );
                                    BlocProvider.of<BookingPageBloc>(context).add(BookingPageSubmitEvent());
                                  }

                                }

                              },
                              child: Expanded(
                                child: CustomButton(
                                  onTap: (){
                                  BlocProvider.of<PickUpBookingBloc>(context).add(PickUpBookingSubmitEvent(booking?.bookId.toString()??"",index));

                                },text: "PickUp",color: ColorConstants.themeColor,
                                  buttonHeight: 35.h,
                                  textStyle: AppStyles.whiteColor16Text,),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                      ],
                    ),
                  ),
                );
              }):
          NoDataFound().noData():

          widget.type == "PickUp" ?
          bookingPageModel?.data.pickup.length!=0?
          ListView.builder(
              itemCount: bookingPageModel?.data.pickup.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
                var booking=bookingPageModel?.data.pickup?[index];
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: ColorConstants.backgroundColor)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Order Id",style: AppStyles.backGround14Text,),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  selectedIndex=index;
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailScreen(bookId: booking?.bookId??0,type: "PickUp",)));
                              },
                              child: Card(
                                  elevation: 2,
                                  child: Text(booking?.bookingId.toString()??"",style: AppStyles.backGround14Text,)),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5.w),
                              width: 110.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: ColorConstants.whiteColor,
                                  border: Border.all(color: ColorConstants.themeColor)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Date ",style: AppStyles.backGround14Text,),
                                  Text(booking?.date??"",style: AppStyles.backGround14Text,),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 5.w),
                              width: 110.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: ColorConstants.whiteColor,
                                  border: Border.all(color: ColorConstants.themeColor)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Time Slot",style: AppStyles.backGround14Text,),
                                  Text(booking?.time??"",style: AppStyles.backGround14Text,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Address",style: AppStyles.backGround14Text,),
                            IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () async {

                              Navigator.push(context,MaterialPageRoute(builder: (context)=>Home()));

                            }, icon: const Icon(Icons.location_on)),
                            SizedBox(width: 30.w,),
                            SizedBox(
                                width: 180.w,
                                child: Text(booking?.address??"",textAlign: TextAlign.right,style: AppStyles.backGround14Text,)),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        BlocListener<DeliverBookingBloc,DeliverBookingState>(
                          listener: (context,state){
                            if(state is DeliverBookingLoadingState){
                              locator<DialogService>().showLoader2();
                            }
                            else if(state is DeliverBookingSuccessState){
                              locator<DialogService>().hideLoader();
                              if(index==state.index){
                                locator<ToastService>().show(state.deliverBookingModel?.message??"");
                                send_notification(
                                    [booking?.token.toString()??""],
                                    "Order Delivered successfully"
                                );
                                BlocProvider.of<BookingPageBloc>(context).add(BookingPageSubmitEvent());
                              }

                            }

                          },
                          child: CustomButton(onTap: (){

                            BlocProvider.of<DeliverBookingBloc>(context).add(DeliverBookingSubmitEvent(booking?.bookId.toString()??"",index));

                          },text: "Delivered",color: ColorConstants.themeColor,
                            buttonHeight: 40.h,
                            textStyle: AppStyles.whiteColor16Text,),
                        ),
                        SizedBox(height: 5.h,),
                      ],
                    ),
                  ),
                );
              }):
          NoDataFound().noData():

          widget.type == "Deliver" ?
          bookingPageModel?.data.deliver.length!=0?
          ListView.builder(
              itemCount: bookingPageModel?.data.deliver.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
                var booking=bookingPageModel?.data.deliver?[index];
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: ColorConstants.backgroundColor)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Order Id",style: AppStyles.backGround14Text,),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  selectedIndex=index;
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailScreen(bookId: booking?.bookId??0,type: "Deliver",)));
                              },
                              child: Card(
                                  elevation: 2,
                                  child: Text(booking?.bookingId.toString()??"",style: AppStyles.backGround14Text,)),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5.w),
                              width: 110.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: ColorConstants.whiteColor,
                                  border: Border.all(color: ColorConstants.themeColor)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Date ",style: AppStyles.backGround14Text,),
                                  Text(booking?.date??"",style: AppStyles.backGround14Text,),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 5.w),
                              width: 110.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: ColorConstants.whiteColor,
                                  border: Border.all(color: ColorConstants.themeColor)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Time Slot",style: AppStyles.backGround14Text,),
                                  Text(booking?.time??"",style: AppStyles.backGround14Text,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Address",style: AppStyles.backGround14Text,),
                            SizedBox(
                                width: 180.w,
                                child: Text(booking?.address??"",textAlign: TextAlign.right,style: AppStyles.backGround14Text,)),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                      ],
                    ),
                  ),
                );
              }):
          NoDataFound().noData():

          bookingPageModel?.data.cancel.length!=0?
          ListView.builder(
              itemCount: bookingPageModel?.data.cancel.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
                var booking=bookingPageModel?.data.cancel?[index];
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: ColorConstants.backgroundColor)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Order Id",style: AppStyles.backGround14Text,),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  selectedIndex=index;
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailScreen(bookId: booking?.bookId??0,type: "Deliver",)));
                              },
                              child: Card(
                                  elevation: 2,
                                  child: Text(booking?.bookingId.toString()??"",style: AppStyles.backGround14Text,)),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5.w),
                              width: 110.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: ColorConstants.whiteColor,
                                  border: Border.all(color: ColorConstants.themeColor)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Date ",style: AppStyles.backGround14Text,),
                                  Text(booking?.date??"",style: AppStyles.backGround14Text,),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 5.w),
                              width: 110.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: ColorConstants.whiteColor,
                                  border: Border.all(color: ColorConstants.themeColor)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Time Slot",style: AppStyles.backGround14Text,),
                                  Text(booking?.time??"",style: AppStyles.backGround14Text,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Address",style: AppStyles.backGround14Text,),
                            SizedBox(
                                width: 180.w,
                                child: Text(booking?.address??"",textAlign: TextAlign.right,style: AppStyles.backGround14Text,)),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                      ],
                    ),
                  ),
                );
              }):
          NoDataFound().noData():
         const ListShimmer();
    },
    )
    );
  }
}
