import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../constant/color_constants.dart';

class CustomAppBar extends StatefulWidget {
  Widget? title;
  bool? centerTile;
  bool LeadingIcon;
 List<Widget> ? actionIcon;
  Widget? leading;

  CustomAppBar({Key? key,this.title,this.centerTile,this.LeadingIcon=false,
     this.actionIcon,this.leading}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {


  @override
  Widget build(BuildContext context) {
    return  AppBar(

      titleSpacing: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      backgroundColor: ColorConstants.themeColor,
       elevation: 0,
       title: widget.title,
       centerTitle: widget.centerTile,
      leading: widget.LeadingIcon ? IconButton(onPressed: (){
        setState(() {
          Navigator.pop(context);
          //locator<NavigationService>().pop(context);
        });
      }, icon:  Icon(Icons.arrow_back,size: 30.sp,)
      ) : widget.leading,
      actions:widget.actionIcon,
    );
  }
}
