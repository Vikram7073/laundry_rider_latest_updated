import 'package:dio/dio.dart';
import 'package:laundry_rider/common/constant/app_config.dart';
import 'package:laundry_rider/model/OTP_model.dart';
import 'package:laundry_rider/model/add_profile_model.dart';
import 'package:laundry_rider/model/cancel_booking_model.dart';
import 'package:laundry_rider/model/rider_notification_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../model/bank_detail_model.dart';
import '../../model/booking/accept_booking_model.dart';
import '../../model/booking/deliver_booking_model.dart';
import '../../model/booking/ongong_booking_model.dart';
import '../../model/booking/pickup_booking_model.dart';
import '../../model/booking/update_booking_detail_model.dart';
import '../../model/booking/view_booking_model.dart';
import '../../model/booking_page_model.dart';
import '../../model/contact_term_model.dart';
import '../../model/get_profile_model.dart';
import '../../model/home_model.dart';
import '../../model/kyc_model.dart';
import '../../model/login_model.dart';
import '../../model/logout_model.dart';
import '../../model/wallet/wallet_model.dart';
import '../../model/wallet/wallet_request_model.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio) = _AuthService;


  @POST(AppConfig.login)
  Future<LoginModel> login(@Header("Content-Type") String contentType,@Body() Map<String, dynamic> data);


  @POST(AppConfig.otp)
  Future<OTPModel> verifyOtp(@Header("Content-Type") String contentType,@Body() Map<String, dynamic> data);

  @POST(AppConfig.addProfile)
  Future<AddProfileModel> userProfiles(@Header("Content-Type") String contentType,@Part() Map<String, dynamic> data);


  @GET(AppConfig.getRiderProfile)
  Future<GetProfileModel> getProfile();

  @POST(AppConfig.kyc)
  Future<KYCModel> kycDetails(@Header("Content-Type") String contentType,@Part() Map<String, dynamic> data);


  @POST(AppConfig.bankDetail)
  Future<BankDetailAddModel> bankDetail(@Header("Content-Type") String contentType,@Body() Map<String, dynamic> data);


  @GET(AppConfig.contactTerm)
  Future<ContactTermPrivacyModel> contactTerm();


  @GET(AppConfig.userHomePage)
  Future<HomeModel> homePage();



  @GET(AppConfig.logOut)
  Future<LogOutModel> logout();

  @GET(AppConfig.booking)
  Future<BookingPageModel> bookingPage();

  @POST(AppConfig.acceptBooking)
  Future<AcceptBookingModel> accptBooking(@Header("Content-Type") String contentType,@Body() Map<String, dynamic> data);


  @POST(AppConfig.ongoingBooking)
  Future<OngoingBookingModel> OngoingBooking(@Header("Content-Type") String contentType,@Body() Map<String, dynamic> data);


  @POST(AppConfig.pickupBooking)
  Future<PickUpBookingModel> PickUpBooking(@Header("Content-Type") String contentType,@Body() Map<String, dynamic> data);



  @POST(AppConfig.deliverBooking)
  Future<DeliverBookingModel> DeliverBooking(@Header("Content-Type") String contentType,@Body() Map<String, dynamic> data);


  @GET(AppConfig.viewBooking)
  Future<ViewBookingModel> viewBooking(@Query('bookId') int bookId);




  @POST(AppConfig.updateBooking)
  Future<UpdateBookingDetailModel> updateOrder(@Header("Content-Type") String contentType,@Body() Map<String, dynamic> data);

  @GET(AppConfig.walletEarning)
  Future<WalletEarningModel> walletEarning();


  @POST(AppConfig.walletRequest)
  Future<WalletRequestModel> walletRequest(@Header("Content-Type") String contentType,@Body() Map<String, dynamic> data);


  @GET(AppConfig.riderNotifications)
  Future<RiderNotificationModel> getRiderNotification();


  @POST(AppConfig.boookCancel)
  Future<BookingCancelModel> bookingCancel(@Header("Content-Type") String contentType,@Body() Map<String, dynamic> data);



}