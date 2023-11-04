import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_rider/api/service/dialog_service.dart';
import 'package:laundry_rider/api/service/navigation_service.dart';
import 'package:laundry_rider/bloc/wallet/wallet_request_bloc.dart';
import 'package:laundry_rider/common/constant/color_constants.dart';
import 'package:laundry_rider/common/constant/font_style.dart';
import 'package:laundry_rider/common/constant/shimmer/list_shimmer_effect.dart';
import 'package:laundry_rider/common/custom_widget/custom_appbar.dart';

import '../../api/service/toast_service.dart';
import '../../bloc/wallet/wallet_earning_bloc.dart';
import '../../common/constant/image.dart';
import '../../common/constant/no data.dart';
import '../../common/custom_widget/custom_button.dart';
import '../../common/custom_widget/custom_textfield.dart';
import '../../locator/locator.dart';
import '../../model/wallet/wallet_model.dart';
class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool earning=true;
  bool withdrawal=false;
  WalletEarningModel ? walletEarningModel;
  TextEditingController amountController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<WalletEarningBloc>(context).add(WalletEarningSubmitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: PreferredSize(preferredSize: Size.fromHeight(45.h), child: CustomAppBar(
        centerTile: true,
          leading: const Text(""),
          title:Text("Wallet",style: AppStyles.whiteColor20Text,))),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
        child: BlocConsumer<WalletEarningBloc,WalletEarningState>(
          listener: (context,state){
            if(state is WalletEarningSuccessState){
              walletEarningModel=state.walletEarningModel;
            }
          },
          builder: (context,state){
            return walletEarningModel != null ?
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 170.w,
                      child: Card(

                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 30.w,),
                                Image.asset(ImageControl.walletRedImg,height: 50.h,),
                                SizedBox(width: 10.w,),

                                Text("₹ ${walletEarningModel?.data?.currentBalance.toString()??''}",style: AppStyles.backGround16Text,),

                              ],
                            ),
                            Text("wallet",style: AppStyles.backGround16Text,),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        walletRequest();
                      },
                      child: SizedBox(
                        width: 170.w,
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(ImageControl.walletRequestImg,height: 50.h,width: 50.w,),
                              Text("Wallet Request",style: AppStyles.backGround16Text,),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            earning=true;
                            withdrawal=false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(5.r),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(color: earning == true ? ColorConstants.themeColor : ColorConstants.backGroundColor)
                          ),
                          child: Text("Earning",style: AppStyles.whiteColor16Text.copyWith(color: earning==true?ColorConstants.themeColor:ColorConstants.backGroundColor),),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w,),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          setState((){});
                          earning=false;
                          withdrawal=true;
                        },
                        child: Container(
                          padding: EdgeInsets.all(5.r),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(color: withdrawal == true ? ColorConstants.themeColor:ColorConstants.backGroundColor)
                          ),
                          child: Text("Withdrawal",style: AppStyles.whiteColor16Text.copyWith(color: withdrawal == true ? ColorConstants.themeColor :
                          ColorConstants.backGroundColor),),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.h,),
                earning == true ?
                walletEarningModel?.data?.earnList?.length!=0 ?
                Expanded(
                  child: Visibility(
                    visible: earning,
                    child: ListView.builder(
                        itemCount: walletEarningModel?.data?.earnList?.length,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          var earning=walletEarningModel?.data?.earnList?[index];
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 5.h),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Booking Id",style: AppStyles.backGround14Text,),
                                      Text(earning?.bookId.toString()??'',style: AppStyles.backGround14Text,)
                                    ],
                                  ),
                                  SizedBox(height: 5.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Pickup Date",style: AppStyles.backGround14Text,),
                                      Text(earning?.pickDate.toString()??"",style: AppStyles.backGround14Text,)
                                    ],
                                  ),
                                  SizedBox(height: 5.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Earning Amount",style: AppStyles.backGround14Text,),
                                      Text("₹${earning?.amount.toString()??""}",style: AppStyles.backGround14Text,)
                                    ],
                                  ),
                                  SizedBox(height: 5.h,),

                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ): NoDataFound().noData()
                    :const SizedBox(),


                withdrawal == true ?
                walletEarningModel?.data?.withdrawlList?.length!=0?
                Expanded(
                  child: Visibility(
                    visible: withdrawal,
                    child: ListView.builder(
                        itemCount: walletEarningModel?.data?.withdrawlList?.length,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          var withdraw=walletEarningModel?.data?.withdrawlList?[index];
                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 5.h),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Withdrawal Amount",style: AppStyles.backGround14Text,),
                                      Text("₹${withdraw?.withdrawlAmount.toString()??""}",style: AppStyles.backGround14Text,)
                                    ],
                                  ),

                                  SizedBox(height: 5.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Date",style: AppStyles.backGround14Text,),
                                      Text(withdraw?.date.toString()??"",style: AppStyles.backGround14Text,)
                                    ],
                                  ),
                                  SizedBox(height: 5.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Status",style: AppStyles.backGround14Text,),
                                      Text(withdraw?.status??"",style: AppStyles.backGround14Text.copyWith(
                                        color: withdraw?.status == "Rejected" ? Colors.red :
                                        withdraw?.status == "Approved" ? Colors.green :
                                        Colors.amber
                                      ),)
                                    ],
                                  ),
                                  SizedBox(height: 5.h,),

                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ):NoDataFound().noData():
                const SizedBox(),
              ],
            ):
            const ListShimmer();
          },
        ),
      ),
    );
  }
   walletRequest(){
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
        constraints: BoxConstraints(maxHeight: 250.h,maxWidth: double.infinity),
        context: context, builder: (context){
      return Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
        child: Column(
          children: [
            CustomTextField(
              keyboardType: TextInputType.phone,
              controller: amountController,
              headingText: "Amount",
              maxLines: 1,
              maxLength: 6,
            ),
           SizedBox(height: 15.h,),

           BlocListener<WalletRequestBloc,WalletRequestState>(
             listener: (context,state){
               if(state is WalletRequestLoadingState){
                 locator<DialogService>().showLoader2();
               }
               else if(state is WalletRequestSuccessState){
                 locator<DialogService>().hideLoader();
                 if(state.walletRequestModel?.status==false){
                   locator<ToastService>().show(state.walletRequestModel?.message??"");
                 }else{
                   locator<ToastService>().show(state.walletRequestModel?.message??"");
                   locator<NavigationService>().pop().then((value) {
                     BlocProvider.of<WalletEarningBloc>(context).add(WalletEarningSubmitEvent());


                   });

                 }
               }
             },
             child: CustomButton(onTap: (){
               BlocProvider.of<WalletRequestBloc>(context).add(WalletRequestSubmitEvent(amountController.text));
             },text: "Request",
             textStyle: AppStyles.whiteColor16Text,buttonWidth: 150.w,),
           )
          ],
        ),
      );
    });
  }
}
