import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_rider/api/service/dialog_service.dart';
import 'package:laundry_rider/api/service/navigation_service.dart';
import 'package:laundry_rider/api/service/toast_service.dart';
import 'package:laundry_rider/bloc/booking/update_booking_detail_bloc.dart';
import 'package:laundry_rider/common/constant/shimmer/list_shimmer_effect.dart';
import 'package:laundry_rider/locator/locator.dart';

import '../bloc/booking/view_booking_bloc.dart';
import '../common/constant/color_constants.dart';
import '../common/constant/font_style.dart';
import '../common/custom_widget/custom_appbar.dart';
import '../common/custom_widget/custom_button.dart';
import '../common/custom_widget/custom_field.dart';
import '../model/booking/view_booking_model.dart';
class OrderDetailEditScreen extends StatefulWidget {
  int ? bookId;
   OrderDetailEditScreen({super.key,this.bookId});
  @override
  State<OrderDetailEditScreen> createState() => _OrderDetailEditScreenState();
}

class _OrderDetailEditScreenState extends State<OrderDetailEditScreen> {


  List<TextEditingController> _controllers = [];
  List<TextEditingController> weightController = [];

  List qtyc=[];
  List wt=[];


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
      floatingActionButton:  BlocListener<UpdateBookingDetailBloc,UpdateBookingDetailState>(
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(onTap: (){
            for (int i = 0; i < _controllers.length; i++) {
              qtyc.add(_controllers[i].text);
              // print("this is qtyc${_controllers[i].text}");
            }
            for (int i = 0; i < weightController.length; i++) {
              wt.add(weightController[i].text);
              // print("this is qtyc${_controllers[i].text}");
            }
            print("this is qtyc  $qtyc");
            print("this is product id  $itemProductList");
            print("this is product qty  $totalItemList");

            BlocProvider.of<UpdateBookingDetailBloc>(context).add(UpdateBookingDetailSubmitEvent(viewBookingModel?.data?.orderStatus?.id,qtyc, wt, ));



          },text: "Update Orders",
            color: ColorConstants.backGroundColor,textStyle: AppStyles.whiteColor16Text,),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                  _controllers.add(TextEditingController(text:element.qty ));
                  weightController.add(TextEditingController(text: element.weight));
                  //itemProductList.add(element.itemId);
                 // totalItemList.add(double.parse(element.qty.toString()));
                });
              });
            }
          },
          builder: (context,state){
            return viewBookingModel!=null?
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Items ",style: AppStyles.backGround16Text,),
                        const Spacer(),

                        Text("Piece",style: AppStyles.backGround16Text),
                        SizedBox(width: 25.w,),
                        Text("Kg",style: AppStyles.backGround16Text),
                        SizedBox(width: 25.w,),
                        Text("Price ",style: AppStyles.backGround16Text),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  SizedBox(
                    height: ((_controllers.length??0) >1?(_controllers.length)*40.h.h:35.h),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount:viewBookingModel?.data?.itemList?.length /*viewBookingModel?.data?.itemList?.length*/,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, index) {
                        var viewBooking=viewBookingModel?.data?.itemList?[index];
                        //qtyc.add( _controllers[index].text);

                        return    Padding(
                          padding:  EdgeInsets.only(bottom: 5.h,left: 8.w,right: 8.w),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 145.w,
                                  child: Text(viewBooking?.productName??"",maxLines: 2,overflow: TextOverflow.ellipsis,
                                    style: AppStyles.backGround14Text.copyWith(fontSize: 14.sp),)),
                              const Spacer(),

                                SizedBox(
                                        height: 30.h,
                                        width: 60.w,
                                        child: CustomField(
                                          maxLines: 1,
                                          maxLength: 5,
                                          // labelText: "pin",
                                          controller: _controllers[index],
                                          fillColor: Colors.white30,
                                          keyboardType: TextInputType.number,
                                          contentPadding: EdgeInsets.only(left: 15.w),

                                        ),
                                      ),
                              SizedBox(width: 4.w,),
                              SizedBox(
                                height: 30.h,
                                width: 60.w,
                                child: CustomField(
                                  maxLines: 1,
                                  maxLength: 5,
                                  // labelText: "pin",
                                  controller: weightController[index],
                                  fillColor: Colors.white30,
                                  keyboardType: TextInputType.number,
                                  contentPadding: EdgeInsets.only(left: 15.w),
                                ),
                              ),
                             
                             // SizedBox(width: 10.w,),
                              SizedBox(
                                  width: 55.w,
                                  child: Text("₹${viewBooking?.price.toString()??""}",
                                    textAlign: TextAlign.right,
                                    style: AppStyles.backGround14Text.copyWith(fontSize: 14.sp),)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 15.h,),
                  // Card(
                  //
                  //   elevation: 8,
                  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  //   child: Padding(
                  //     padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.h),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text("Order Status",style: AppStyles.whiteColor20Text.copyWith(color: ColorConstants.themeColor),),
                  //         SizedBox(height: 10.h,),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text("Delivered on",style: AppStyles.backGround14Text),
                  //             Text(viewBookingModel?.data?.deliverOn.toString()??"",style: AppStyles.backGround14Text,),
                  //           ],
                  //         ),
                  //         SizedBox(height: 5.h,),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text("Order id",style: AppStyles.backGround14Text),
                  //             Text(viewBookingModel?.data?.orderId.toString()??"",style: AppStyles.backGround14Text,),
                  //           ],
                  //         ),
                  //         SizedBox(height: 5.h,),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text("Order Date ",style: AppStyles.backGround14Text),
                  //             Text(viewBookingModel?.data?.orderDate.toString()??"",style: AppStyles.backGround14Text,),
                  //           ],
                  //         ),
                  //         SizedBox(height: 5.h,),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text("Total Product",style: AppStyles.backGround14Text),
                  //             Text("₹ ${viewBookingModel?.data?.totalProduct.toString()??""}",style: AppStyles.backGround14Text,),
                  //           ],
                  //         ),
                  //         SizedBox(height: 5.h,),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text("Invoice Amount",style: AppStyles.backGround14Text),
                  //             Text("₹ ${viewBookingModel?.data?.invoiceAmount.toString()??""}",style: AppStyles.backGround14Text,),
                  //           ],
                  //         ),
                  //         SizedBox(height: 5.h,),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text("Discount Amount",style: AppStyles.backGround14Text),
                  //             Text("₹ ${viewBookingModel?.data?.discount.toString()??""}",style: AppStyles.backGround14Text,),
                  //           ],
                  //         ),
                  //         SizedBox(height: 5.h,),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text("Net Amount Payable",style: AppStyles.backGround14Text),
                  //             Text("₹ ${viewBookingModel?.data?.netAmount.toString()??""}",style: AppStyles.backGround14Text,),
                  //           ],
                  //         ),
                  //         SizedBox(height: 5.h,),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text("Payment Mode",style: AppStyles.backGround14Text),
                  //             Text("Cash On Delivery",style: AppStyles.backGround14Text,),
                  //           ],
                  //         ),
                  //         SizedBox(height: 5.h,),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text("Delivery Address ",style: AppStyles.backGround14Text),
                  //             SizedBox(
                  //                 width: 170.w,
                  //                 child: Text(viewBookingModel?.data?.address.toString()??"",textAlign: TextAlign.end,style: AppStyles.backGround14Text,)),
                  //           ],
                  //         ),
                  //         SizedBox(height: 5.h,),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 20.h,),
                  // BlocListener<UpdateBookingDetailBloc,UpdateBookingDetailState>(
                  //   listener: (context,state){
                  //     if(state is UpdateBookingDetailLoadingState){
                  //       locator<DialogService>().showLoader2();
                  //     }else if(state is UpdateBookingDetailSuccessState){
                  //       locator<DialogService>().hideLoader();
                  //       locator<ToastService>().show(state.updateBookingDetailModel?.message??"");
                  //       locator<NavigationService>().pop().then((value) {
                  //         BlocProvider.of<ViewBookingBloc>(context).add(ViewBookingSubmitEvent(widget.bookId??0));
                  //
                  //       });
                  //     }
                  //   },
                  //   child: CustomButton(onTap: (){
                  //     for (int i = 0; i < _controllers.length; i++) {
                  //       qtyc.add(_controllers[i].text);
                  //      // print("this is qtyc${_controllers[i].text}");
                  //     }
                  //     print("this is qtyc  $qtyc");
                  //     print("this is product id  $itemProductList");
                  //     print("this is product qty  $totalItemList");
                  //
                  //       BlocProvider.of<UpdateBookingDetailBloc>(context).add(UpdateBookingDetailSubmitEvent(viewBookingModel?.data?.orderStatus?.id, itemProductList, totalItemList, "this is msg"));
                  //
                  //
                  //
                  //   },text: "Update Orders",
                  //     color: ColorConstants.backGroundColor,textStyle: AppStyles.whiteColor16Text,),
                  // ),
                ],
              ),
            ):
            ListShimmer();
          },
        ),
      ),
    );
  }
}
