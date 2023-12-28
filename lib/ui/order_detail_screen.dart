import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_rider/bloc/booking/view_booking_bloc.dart';
import 'package:laundry_rider/common/constant/shimmer/list_shimmer_effect.dart';
import 'package:laundry_rider/ui/order_detail_edit_screen.dart';

import '../common/constant/color_constants.dart';
import '../common/constant/font_style.dart';
import '../common/custom_widget/custom_appbar.dart';
import '../model/booking/view_booking_model.dart';
class OrderDetailScreen extends StatefulWidget {
  int ? bookId;
  String? type;
   OrderDetailScreen({Key? key,this.bookId,this.type}) : super(key: key);
  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  ViewBookingModel ? viewBookingModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ViewBookingBloc>(context).add(ViewBookingSubmitEvent(widget.bookId??0));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.h),
          child: CustomAppBar(
            actionIcon: [
             (widget.type=="Accept" || widget.type=="Ongoing")? IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailEditScreen(bookId: widget.bookId,)));
             }, icon: const Icon(Icons.edit)):const SizedBox(),
              SizedBox(width: 10.w,)],
            title:  Text("Order Detail",style:
            AppStyles.whiteColor16Text.copyWith(fontSize: 20.sp),),)),
      body: BlocConsumer<ViewBookingBloc,ViewBookingState>(
        listener: (context,state){
          if(state is ViewBookingSuccessState){
            viewBookingModel=state.viewBookingModel;
          }
        },
        builder: (context,state){
          return viewBookingModel != null?
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Items ",style: AppStyles.backGround16Text,),
                        const Spacer(),
                        Text("Piece ",style: AppStyles.backGround16Text),
                        SizedBox(width: 20.w,),
                        Text("Kg ",style: AppStyles.backGround16Text),
                        SizedBox(width: 25.w,),
                        Text("Price ",style: AppStyles.backGround16Text),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  SizedBox(
                    height: ( viewBookingModel?.data?.itemList?.length??0)>1?(viewBookingModel?.data?.itemList?.length??0)*35:45,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: viewBookingModel?.data?.itemList?.length,
                      shrinkWrap: true,
                         physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, index) {
                        var viewBooking=viewBookingModel?.data?.itemList?[index];
                        return    Padding(
                          padding:  EdgeInsets.only(bottom: 8.h,left: 8.w,right: 10.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 150.w,
                                  child: Text(viewBooking?.productName??"",maxLines: 2,overflow: TextOverflow.ellipsis,
                                    style: AppStyles.backGround14Text.copyWith(fontSize: 14.sp),)),
                              const Spacer(),
                              SizedBox(
                                  width: 35.w,
                                  child: Text(viewBooking?.qty.toString()??"",
                                    textAlign: TextAlign.right,
                                    style: AppStyles.backGround14Text.copyWith(fontSize: 14.sp),)),
                             // SizedBox(width: 15.w,),
                              SizedBox(
                                  width: 45.w,
                                  child: Text(viewBooking?.weight.toString()??"",
                                    textAlign: TextAlign.right,
                                    style: AppStyles.backGround14Text.copyWith(fontSize: 14.sp),)),
                              // SizedBox(width: 75.w,),
                              SizedBox(
                                  width: 80.w,
                                  child: Text(viewBooking?.price.toString()??"",
                                    textAlign: TextAlign.right,
                                    style: AppStyles.backGround14Text.copyWith(fontSize: 14.sp),)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Order Status",style: AppStyles.whiteColor20Text.copyWith(color: ColorConstants.themeColor),),
                          SizedBox(height: 10.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Delivered on",style: AppStyles.backGround14Text),
                              Text(viewBookingModel?.data?.orderStatus?.deliveryDate.toString()??"",style: AppStyles.backGround14Text,),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Order id",style: AppStyles.backGround14Text),
                              Text(viewBookingModel?.data?.orderStatus?.bookingId.toString()??"",style: AppStyles.backGround14Text,),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Order Date ",style: AppStyles.backGround14Text),
                              Text(viewBookingModel?.data?.orderStatus?.orderDate.toString()??"",style: AppStyles.backGround14Text,),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Product",style: AppStyles.backGround14Text),
                              Text(viewBookingModel?.data?.orderStatus?.totalProduct.toString()??"",style: AppStyles.backGround14Text,),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("GST",style: AppStyles.backGround14Text),
                              Text("₹ ${viewBookingModel?.data?.orderStatus?.gst.toString()??""}",style: AppStyles.backGround14Text,),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Invoice Amount",style: AppStyles.backGround14Text),
                              Text("₹ ${viewBookingModel?.data?.orderStatus?.invoiceAmount.toString()??""}",style: AppStyles.backGround14Text,),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Discount Amount",style: AppStyles.backGround14Text),
                              Text("₹ ${viewBookingModel?.data?.orderStatus?.discount.toString()??""}",style: AppStyles.backGround14Text,),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Net Amount Payable",style: AppStyles.backGround14Text),
                              Text("₹ ${viewBookingModel?.data?.orderStatus?.netAmount.toString()??""}",style: AppStyles.backGround14Text,),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Payment Mode",style: AppStyles.backGround14Text),
                              Text(viewBookingModel?.data?.orderStatus?.paymentMode.toString()??"",style: AppStyles.backGround14Text,),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Delivery Address ",style: AppStyles.backGround14Text),
                              SizedBox(
                                  width: 180.w,
                                  child: Text(viewBookingModel?.data?.orderStatus?.address.toString()??"",textAlign: TextAlign.end,style: AppStyles.backGround14Text,)),
                            ],
                          ),
                          SizedBox(height: 5.h,),


                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h,),
                ],
              ),
            ),
          ):
          const ListShimmer();
        },
      ),
    );
  }
}
