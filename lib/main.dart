import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_rider/bloc/get_profile_bloc.dart';
import 'package:laundry_rider/common/constant/app_utils.dart';
import 'package:laundry_rider/router/router.gr.dart';
import 'api/network/model/repository/base/auth/auth_repo.dart';
import 'bloc/add_bank_detail_bloc.dart';
import 'bloc/add_profile_bloc.dart';
import 'bloc/booking/accept_booking_bloc.dart';
import 'bloc/booking/booking_page_bloc.dart';
import 'bloc/booking/deliver_booking_bloc.dart';
import 'bloc/booking/ongoing_booking_bloc.dart';
import 'bloc/booking/picup_booking_bloc.dart';
import 'bloc/booking/update_booking_detail_bloc.dart';
import 'bloc/booking/view_booking_bloc.dart';
import 'bloc/booking_cancel_bloc.dart';
import 'bloc/bottom_bar_model.dart';
import 'bloc/contact_term_bloc.dart';
import 'bloc/home_bloc.dart';
import 'bloc/kyc_bloc.dart';
import 'bloc/login_bloc.dart';
import 'bloc/logout_bloc.dart';
import 'bloc/notification/notification_bloc.dart';
import 'bloc/otp_bloc.dart';
import 'bloc/wallet/wallet_earning_bloc.dart';
import 'bloc/wallet/wallet_request_bloc.dart';
import 'locator/locator.dart';

Future<void> main() async {
  await setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  final AuthRepository _authRepository = locator<AuthRepository>();
   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFcmToken();
    getMessage();
  }

  getFcmToken(){
    FirebaseMessaging.instance.getToken().then((value) {
      AppUtils().setFcm(value.toString());
     print("this is fcm token ${value.toString()}");
    });
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      useInheritedMediaQuery: true,
      builder: (BuildContext context, Widget? child) {
      return MultiBlocProvider(
          providers: [
            BlocProvider<BottomNavigationSelectionBloc>(create: (context)=>BottomNavigationSelectionBloc()),
            BlocProvider<LoginBloc>(create: (context)=>LoginBloc(_authRepository)),
            BlocProvider<OTPBloc>(create: (context)=>OTPBloc(_authRepository)),
            BlocProvider<AddProfileBloc>(create: (context)=>AddProfileBloc(_authRepository)),
            BlocProvider<GetProfileBloc>(create: (context)=>GetProfileBloc(_authRepository)),
            BlocProvider<KYCBloc>(create: (context)=>KYCBloc(_authRepository)),
            BlocProvider<BankDetailBloc>(create: (context)=>BankDetailBloc(_authRepository)),
            BlocProvider<ContactTermBloc>(create: (context)=>ContactTermBloc(_authRepository)),
            BlocProvider<HomeBloc>(create: (context)=>HomeBloc(_authRepository)),
            BlocProvider<LogOutBloc>(create: (context)=>LogOutBloc(_authRepository)),
            BlocProvider<BookingPageBloc>(create: (context)=>BookingPageBloc(_authRepository)),
            BlocProvider<AcceptBookingBloc>(create: (context)=>AcceptBookingBloc(_authRepository)),
            BlocProvider<OngoingBookingBloc>(create: (context)=>OngoingBookingBloc(_authRepository)),
            BlocProvider<DeliverBookingBloc>(create: (context)=>DeliverBookingBloc(_authRepository)),
            BlocProvider<PickUpBookingBloc>(create: (context)=>PickUpBookingBloc(_authRepository)),
            BlocProvider<ViewBookingBloc>(create: (context)=>ViewBookingBloc(_authRepository)),
            BlocProvider<UpdateBookingDetailBloc>(create: (context)=>UpdateBookingDetailBloc(_authRepository)),
            BlocProvider<WalletEarningBloc>(create: (context)=>WalletEarningBloc(_authRepository)),
            BlocProvider<WalletRequestBloc>(create: (context)=>WalletRequestBloc(_authRepository)),
            BlocProvider<NotificationBloc>(create: (context)=>NotificationBloc(_authRepository)),
            BlocProvider<BooingCancelBloc>(create: (context)=>BooingCancelBloc(_authRepository)),

          ],
          child:  MaterialApp.router(
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
           // locale: DevicePreview.locale(context),
            title: "Laundry-rider",
            debugShowCheckedModeBanner: false,
            routerDelegate: locator<AppRouter>().delegate(),
            routeInformationParser: locator<AppRouter>().defaultRouteParser(),
          ));
    },
    );
  }

void getMessage() {
  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage? message) {
    if (message != null) {}
  });



  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null ) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              '01',
              'CG',
              channelDescription: 'laundry-rider',
              importance: Importance.max,
              playSound: true,
              showProgress: true,
              priority: Priority.high,
              enableLights: true,
              enableVibration: true,
              ticker: 'ticker',
              icon: 'mipmap/launcher_icon',
            ),
          )
      );
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              '01',
              'CG',
              channelDescription: 'laundry-rider',
              importance: Importance.max,
              playSound: true,
              showProgress: true,
              priority: Priority.high,
              enableLights: true,
              enableVibration: true,
              ticker: 'ticker',
              icon: 'mipmap/launcher_icon',
            ),
          ));
    }
  });
}
}


