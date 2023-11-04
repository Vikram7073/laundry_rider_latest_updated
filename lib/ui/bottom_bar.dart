import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/constant/common_fuction.dart';
import '../../common/constant/image.dart';
import '../../common/constant/string.dart';
import '../bloc/bottom_bar_model.dart';
import '../common/constant/color_constants.dart';

//ignore: must_be_immutable
class DashboardScreen extends StatefulWidget {
  String ? type;
  int? index;
  bool? fromListCon;
  bool? fromConfirm;
  int? from;
  DashboardScreen({Key? key,this.fromListCon = false,this.type,this.fromConfirm= false,this.from,this.index}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      BlocProvider.of<BottomNavigationSelectionBloc>(context).add(BottomNavigationSelectionRefreshEvent(position: widget.index ?? 0));
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        CommonFunction.onWillPop(context);
        return Future.value(false);
      },
      child: BlocBuilder<BottomNavigationSelectionBloc,BottomNavigationSelectionState>(
          builder: (context,state){
            if(state is BottomNavigationSelectionIndexState){
              return Scaffold(
                resizeToAvoidBottomInset: false,
                extendBody: true,
                body:
                     BlocProvider.of<BottomNavigationSelectionBloc>(context).widgetOptions.elementAt(state.index),
                bottomNavigationBar: SizedBox(

                  child:

                  BottomNavigationBar(

                    selectedFontSize: 12.sp,
                    unselectedFontSize: 12.sp,
                    backgroundColor: Colors.white,
                    selectedLabelStyle: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.themeColor,
                      fontSize: 12.sp,
                    ),
                    showSelectedLabels: true,
                    unselectedLabelStyle:  GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.backGroundColor,
                      fontSize: 12.sp,
                    ),
                    items:  <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: BlocProvider.of<BottomNavigationSelectionBloc>(context).onSelectedHomes == false ?
                        Image.asset(
                          ImageControl.homeImg,
                          height: 25.h,
                          color: ColorConstants.backGroundColor,
                        ):Image.asset(
                          ImageControl.homeImg, height: 25.h,
                          color: ColorConstants.themeColor,
                        ),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: BlocProvider.of<BottomNavigationSelectionBloc>(context).onSelectedJob  == false?
                        Image.asset(
                          ImageControl.fileImg,
                          height: 25.h,
                          color: ColorConstants.backGroundColor,
                        ):Image.asset(
                          ImageControl.fileImg, height: 25.h,
                          color: ColorConstants.themeColor,
                        ),
                        label: StringControl.booking,
                      ),
                      BottomNavigationBarItem(
                        icon: BlocProvider.of<BottomNavigationSelectionBloc>(context).onSelectedNotification  == false?
                        Image.asset(
                          ImageControl.truckImg,
                          height: 25.h,
                          color: ColorConstants.backGroundColor,
                        ):Image.asset(
                          ImageControl.truckImg,
                          height: 25.h,color: ColorConstants.themeColor,
                        ),
                        label:"Wallet",
                      ),
                      BottomNavigationBarItem(

                        icon: BlocProvider.of<BottomNavigationSelectionBloc>(context).onSelectedProfile  == false ?
                        Image.asset(
                          ImageControl.profileImg,
                          height: 25.h,
                          color: ColorConstants.backGroundColor,
                        ):Image.asset(
                          ImageControl.profileImg, height: 25.h,
                          color: ColorConstants.themeColor,
                        ),
                        label: "Profile",
                      ),

                    ],
                    type: BottomNavigationBarType.fixed,
                    currentIndex: state.index,
                    iconSize: 40.h,
                    onTap: (index){
                      BlocProvider.of<BottomNavigationSelectionBloc>(context).add(UpdateSelectedRefreshEvent(index));
                      if (index == 0) {
                        BlocProvider.of<BottomNavigationSelectionBloc>(context).add(
                            BottomNavigationSelectionRefreshEvent(position: index));
                      }
                      if (index == 1) {
                        BlocProvider.of<BottomNavigationSelectionBloc>(context).add(
                            BottomNavigationSelectionRefreshEvent(position: index));
                      }
                      if (index == 2) {
                        BlocProvider.of<BottomNavigationSelectionBloc>(context).add(
                            BottomNavigationSelectionRefreshEvent(position: index));
                      }
                      if (index == 3) {
                        BlocProvider.of<BottomNavigationSelectionBloc>(context).add(
                            BottomNavigationSelectionRefreshEvent(position: index));
                      }
                    },
                    elevation: 5,
                    unselectedItemColor:ColorConstants.backGroundColor,
                    selectedItemColor: ColorConstants.themeColor,
                    showUnselectedLabels: true,
                  ),
                ),
              );
            }
            else {
              return const SizedBox();
            }
          }),
    );
  }

}
