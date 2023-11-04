import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_rider/common/constant/font_style.dart';
import 'package:laundry_rider/common/constant/no%20data.dart';
import 'package:laundry_rider/common/constant/shimmer/list_shimmer_effect.dart';
import 'package:laundry_rider/common/custom_widget/custom_appbar.dart';
import 'package:laundry_rider/model/rider_notification_model.dart';
import '../../bloc/notification/notification_bloc.dart';
import '../../common/constant/color_constants.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}
class _NotificationScreenState extends State<NotificationScreen> {
  RiderNotificationModel ? notificationModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NotificationBloc>(context).add(NotificationSubmitEvent());
  }
  Future<void> _pullRefresh() async {
   Future.delayed(const Duration(seconds: 1)).then((value) {
     BlocProvider.of<NotificationBloc>(context).add(NotificationSubmitEvent());
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(45.h), child: CustomAppBar(
        title: Text("Notification",style: AppStyles.whiteColor20Text,),
        centerTile: true,
      )),
      body: BlocBuilder<NotificationBloc,NotificationState>(
        builder: (context,state){
          if(state is NotificationSuccessState){
            notificationModel=state.notificationModel;
            return notificationModel!=null?
            notificationModel?.data?.length!=0?
            RefreshIndicator(
              onRefresh: _pullRefresh,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  itemCount: notificationModel?.data?.length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 15.w,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("${index+1}",style: AppStyles.whiteColor16Text.copyWith(color: Colors.black87)),
                              SizedBox(width: 25.w,),
                              Text(notificationModel?.data?[index].name.toString()??"",style: AppStyles.whiteColor16Text.copyWith(color: Colors.black87)),
                              const Spacer(),
                              Text(notificationModel?.data?[index].time??"",style: AppStyles.greyBlackColor10Text),

                            ],
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 35.w),
                              child: Text(notificationModel?.data?[index].message??"",style: AppStyles.greyBlackColor12Text)),
                          Divider( color: ColorConstants.greyBlackColor.withOpacity(0.7))

                        ],
                      ),
                    );
                  }),
            ):
            NoDataFound().noData():
            const ListShimmer();
          }
          return const ListShimmer();

        },
      ),
    );
  }
}
