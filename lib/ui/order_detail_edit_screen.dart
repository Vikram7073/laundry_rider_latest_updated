import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_rider/api/service/dialog_service.dart';
import 'package:laundry_rider/api/service/navigation_service.dart';
import 'package:laundry_rider/api/service/toast_service.dart';
import 'package:laundry_rider/bloc/booking/update_booking_detail_bloc.dart';
import 'package:laundry_rider/locator/locator.dart';

import '../bloc/booking/view_booking_bloc.dart';
import '../common/constant/color_constants.dart';
import '../common/constant/font_style.dart';
import '../common/custom_widget/custom_appbar.dart';
import '../common/custom_widget/custom_button.dart';
import '../model/booking/view_booking_model.dart';
class OrderDetailEditScreen extends StatefulWidget {
  int ? bookId;
   OrderDetailEditScreen({super.key,this.bookId});
  @override
  State<OrderDetailEditScreen> createState() => _OrderDetailEditScreenState();
}

class _OrderDetailEditScreenState extends State<OrderDetailEditScreen> {
  ViewBookingModel ? viewBookingModel;
  List itemProductList=[];
  List totalItemList=[];
  int? currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ViewBookingBloc>(context).add(ViewBookingSubmitEvent(widget.bookId??0));
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.h),
          child: CustomAppBar(
            title:  Text("Edit Order Detail",style:
            AppStyles.whiteColor16Text.copyWith(fontSize: 20.sp),),)),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
        child: BlocConsumer<ViewBookingBloc,ViewBookingState>(
          listener: (context,state){
            if(state is ViewBookingSuccessState){
              viewBookingModel=state.viewBookingModel;
              viewBookingModel?.data?.itemList?.forEach((element) {
                setState(() {
                  itemProductList.add(element.itemId);
                  totalItemList.add(element.qty);
                });
              });
            }
          },
          builder: (context,state){
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Items ",style: AppStyles.backGround16Text,),
                        const Spacer(),

                        Text("Quantity ",style: AppStyles.backGround16Text),
                        SizedBox(width: 15.w,),
                        Text("Price ",style: AppStyles.backGround16Text),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  SizedBox(
                    height: totalItemList.length >2?totalItemList.length*45:30,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: totalItemList.length /*viewBookingModel?.data?.itemList?.length*/,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, index) {
                        var viewBooking=viewBookingModel?.data?.itemList?[index];
                        return    Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 8.w),
                          child: Row(
                            children: [
                              Text(viewBooking?.productName??"",style: AppStyles.backGround14Text.copyWith(fontSize: 14.sp),),
                              const Spacer(),
                              Row(
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                      onPressed: (){
                                    setState(() {
                                      if(totalItemList.contains(0)){
                                      }else{
                                        totalItemList[index]--;
                                      }
                                     /* if(totalItemList.contains(0)){
                                        itemProductList.removeAt(index);
                                        totalItemList.removeAt(index);
                                      }*/

                                    });
                                  }, icon: const Icon(Icons.remove)),

                                  (totalItemList.length==0 ||itemProductList.length==0)?
                                  Text("0",style: AppStyles.backGround14Text.copyWith(fontSize: 14.sp),):
                                  Text(totalItemList[index].toString(),style: AppStyles.backGround14Text.copyWith(fontSize: 14.sp),),

                                  IconButton(
                                    padding: EdgeInsets.zero,
                                      onPressed: (){
                                    setState(() {
                                      currentIndex=index;
                                      totalItemList[index]++;

                                      //  if(viewBooking?.qty!=null){
                                      //    setState(() {
                                      //      viewBooking?.qty =( viewBooking?.qty)! + 1;
                                      //    });
                                      //    totalItemList.add(viewBooking?.qty);
                                      //  }

                                      //
                                      //
                                      // if((viewBooking?.qty)!>=0){
                                      //   if(itemProductList.contains(viewBooking?.itemId)){
                                      //     setState(() {
                                      //       itemProductList.toSet();
                                      //     });
                                      //   }else{
                                      //     setState(() {
                                      //       itemProductList.add(viewBooking?.itemId);
                                      //     });
                                      //   }
                                      // }
                                    });
                                  }, icon: const Icon(Icons.add)),
                                ],
                              ),
                              SizedBox(width: 20.w,),
                              Text(viewBooking?.price.toString()??"",style: AppStyles.backGround14Text.copyWith(fontSize: 14.sp),),
                              SizedBox(width: 5.w,),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 15.h,),
                  Card(

                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Order Status",style: AppStyles.whiteColor20Text.copyWith(color: ColorConstants.themeColor),),
                          SizedBox(height: 10.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Delivered on",style: AppStyles.backGround14Text),
                              Text(viewBookingModel?.data?.deliverOn.toString()??"",style: AppStyles.backGround14Text,),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Order id",style: AppStyles.backGround14Text),
                              Text(viewBookingModel?.data?.bookId.toString()??"",style: AppStyles.backGround14Text,),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Order Date ",style: AppStyles.backGround14Text),
                              Text(viewBookingModel?.data?.orderDate.toString()??"",style: AppStyles.backGround14Text,),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Product",style: AppStyles.backGround14Text),
                              Text("₹ ${viewBookingModel?.data?.totalProduct.toString()??""}",style: AppStyles.backGround14Text,),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Invoice Amount",style: AppStyles.backGround14Text),
                              Text("₹ ${viewBookingModel?.data?.invoiceAmount.toString()??""}",style: AppStyles.backGround14Text,),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Discount Amount",style: AppStyles.backGround14Text),
                              Text("₹ ${viewBookingModel?.data?.discount.toString()??""}",style: AppStyles.backGround14Text,),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Net Amount Payable",style: AppStyles.backGround14Text),
                              Text("₹ ${viewBookingModel?.data?.netAmount.toString()??""}",style: AppStyles.backGround14Text,),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Payment Mode",style: AppStyles.backGround14Text),
                              Text("Cash On Delivery",style: AppStyles.backGround14Text,),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Delivery Address ",style: AppStyles.backGround14Text),
                              SizedBox(
                                  width: 170.w,
                                  child: Text(viewBookingModel?.data?.address.toString()??"",textAlign: TextAlign.end,style: AppStyles.backGround14Text,)),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  BlocListener<UpdateBookingDetailBloc,UpdateBookingDetailState>(
                    listener: (context,state){
                      if(state is UpdateBookingDetailLoadingState){
                        locator<DialogService>().showLoader2();
                      }else if(state is UpdateBookingDetailSuccessState){
                        locator<DialogService>().hideLoader();
                        locator<ToastService>().show(state.updateBookingDetailModel?.message??"");
                        locator<NavigationService>().pop().then((value) {
                          BlocProvider.of<ViewBookingBloc>(context).add(ViewBookingSubmitEvent(widget.bookId??0));

                        });
                      }
                    },
                    child: CustomButton(onTap: (){
                      print("this is product id  $itemProductList");
                      print("this is product qty  $totalItemList");
                      BlocProvider.of<UpdateBookingDetailBloc>(context).add(UpdateBookingDetailSubmitEvent(viewBookingModel?.data?.bookId, itemProductList, totalItemList, "this is msg"));

                    },text: "Update Orders",
                      color: ColorConstants.backGroundColor,textStyle: AppStyles.whiteColor16Text,),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
