import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_rider/common/constant/app_utils.dart';
import 'package:laundry_rider/ui/bottom_bar.dart';
import '../common/constant/image.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    next();
    setFcmTokens();
  }
  next(){
    AppUtils().getUserLoggedIn().then((value) {

        Future.delayed(const Duration(seconds: 2)).then((value){
          if(value==true) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DashboardScreen()));
          }
          else{
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));

          }
        });


    });

  }


//fcm set
  setFcmTokens(){
    FirebaseMessaging.instance.getToken().then((value) {
      AppUtils().setFcm(value.toString());
      print("this is fcm token ${value.toString()}");
    });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light
    ));
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage(ImageControl.splashBackGroundImg,),fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset( ImageControl.splashImg,height: 150.h,),
              Image.asset( ImageControl.splashName,height: 150.h,),
            ],
          ),
        ),
      ),
    );
  }
}
