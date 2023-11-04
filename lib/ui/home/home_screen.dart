import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_rider/common/constant/color_constants.dart';
import 'package:laundry_rider/common/constant/font_style.dart';
import 'package:laundry_rider/common/constant/shimmer/list_shimmer_effect.dart';
import 'package:laundry_rider/ui/notification/notification_screen.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../bloc/home_bloc.dart';
import '../../common/constant/image.dart';
import '../../model/home_model.dart';
import '../profile_setting_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  HomeModel ? homeModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeSubmitEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>const NotificationScreen()));
        }, icon:const Icon(Icons.notifications)),SizedBox(width: 10.w,)],
        backgroundColor: ColorConstants.themeColor,
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width*0.9,
        child:  ProfileSettingScreen(),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<HomeBloc,HomeState>(
          listener: (context,state){
            if(state is HomeSuccessState){
              homeModel=state.homeModel;
            }
          },
          builder: (context,state){
            return homeModel!=null?
            Column(
              children: [
                SizedBox(height: 10.h,),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 8.h),
                    child: Text("Welcome ${homeModel?.data?.name??""} !",style: AppStyles.themeColor14text.copyWith(fontSize: 20.sp),),
                  ),
                ),
                SizedBox(height: 10.h,),
                Image.asset(ImageControl.riderHomeImg,fit: BoxFit.fill,),
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 20.h),
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      itemCount: homeModel?.data?.bookingList?.length,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                          crossAxisSpacing: 5,mainAxisSpacing: 5,childAspectRatio: 2/1),
                      itemBuilder: (context,index){
                    return Container(
                      padding: EdgeInsets.all(3.r),
                      decoration: BoxDecoration(
                        gradient:  LinearGradient(colors: [Color(int.parse(homeModel?.data?.bookingList?[index].colorCode.toString()??"")),
                          ColorConstants.themeColor],begin: Alignment.bottomCenter,end: Alignment.topLeft),
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.cyan,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5.r),
                            height: 40.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                            ),
                            child: CachedNetworkImage(
                              imageUrl: homeModel?.data?.bookingList?[index].image.toString()??'',
                              imageBuilder:
                                  (context, imageProvider) =>
                                  Container(
                                    height: 35.h,
                                    width: 35.w,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                              placeholder: (context, url) =>
                                  Shimmer(
                                    duration: const Duration(seconds: 1),
                                    //Default value
                                    interval: const Duration(seconds: 0),
                                    //Default value: Duration(seconds: 0)
                                    color: ColorConstants.whiteColor,
                                    //Default value
                                    colorOpacity: 0,
                                    //Default value
                                    enabled: true,
                                    //Default value
                                    direction: const ShimmerDirection
                                        .fromLTRB(),
                                    //Default Value
                                    child: Container(
                                      color:
                                      ColorConstants.greyDarkColor,
                                    ),
                                  ),
                              errorWidget: (context, url, error) =>
                                  Image.asset(
                                      ImageControl.profileImg,height: 50.h,width: 50.w,),
                            ),
                          ),
                          SizedBox(width: 15.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(homeModel?.data?.bookingList?[index].totalBooking.toString()??"",style: AppStyles.backGround16Text.copyWith(fontSize: 13.sp),),
                              Text(homeModel?.data?.bookingList?[index].listName??"",style: AppStyles.backGround16Text.copyWith(fontSize: 13.sp),)
                            ],
                          ),

                        ],
                      ),
                    );
                  }),
                ),
                SizedBox(height: 110.h,)
              ],
            ):
            const ListShimmer();
          },
        ),
      ),
    );
  }
}
