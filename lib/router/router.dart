import 'package:auto_route/auto_route.dart';
import 'package:laundry_rider/ui/login_with_otp_screen.dart';
import 'package:laundry_rider/ui/otp_screen.dart';
import 'package:laundry_rider/ui/splash_screen.dart';


import '../../ui/bottom_bar.dart';




// import '../../ui/profile/settings/profile_settings/training_Consultantation/Training_course_details.dart';




@MaterialAutoRouter(
    routes: (<AutoRoute>[
  MaterialRoute(page: SplashScreen, initial: true),
  MaterialRoute(page: LoginWithOtpScreen),
      MaterialRoute(page: OtpScreen),




]))

class $AppRouter {}
