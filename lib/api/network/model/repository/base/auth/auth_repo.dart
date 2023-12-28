import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:laundry_rider/model/OTP_model.dart';
import 'package:laundry_rider/model/cancel_booking_model.dart';
import 'package:laundry_rider/model/kyc_model.dart';
import 'package:laundry_rider/model/logout_model.dart';
import 'package:laundry_rider/model/rider_notification_model.dart';
import 'package:laundry_rider/model/wallet/wallet_model.dart';

import '../../../../../../model/add_profile_model.dart';
import '../../../../../../model/bank_detail_model.dart';
import '../../../../../../model/booking/accept_booking_model.dart';
import '../../../../../../model/booking/deliver_booking_model.dart';
import '../../../../../../model/booking/ongong_booking_model.dart';
import '../../../../../../model/booking/pickup_booking_model.dart';
import '../../../../../../model/booking/update_booking_detail_model.dart';
import '../../../../../../model/booking/view_booking_model.dart';
import '../../../../../../model/booking_page_model.dart';
import '../../../../../../model/contact_term_model.dart';
import '../../../../../../model/get_profile_model.dart';
import '../../../../../../model/home_model.dart';
import '../../../../../../model/login_model.dart';
import '../../../../../../model/wallet/wallet_request_model.dart';
import '../../../../../service/auth_service.dart';
import '../../../../result.dart';
import '../../base_repo.dart';

@lazySingleton
class AuthRepository extends BaseRepository {
  String? tokenNew;



Future<Result<LoginModel>> loginOtp({
  String? mobile_no,
  String? token,

}) async =>
    safeCall(AuthService(await dio).login("application/json", {
      "mobile_no": mobile_no,
      "token": token,

    }));


Future<Result<OTPModel>> verifyToOtp({
  String ? mobile_no,
  String ? otp,
}) async =>
    safeCall(AuthService(await dio).verifyOtp("application/json", {
      "mobile_no": mobile_no,
      "otp": otp,
    }));





  Future<Result<AddProfileModel>> addProfile({
    String? first_name,last_name,email,current_location,permanent_location,city,
    File? profile_image,bool?isImageSelect

  }) async => safeCall(AuthService(await dio).userProfiles("application/json",
    isImageSelect==true ? {
      "first_name":first_name,
      "last_name":last_name,
      "email":email,
      "current_location":current_location,
      "permanent_location":permanent_location,
      "city":city,
      "profile_image":MultipartFile.fromFileSync(profile_image?.path ?? '')
    }:
    {
      "first_name":first_name,
      "last_name":last_name,
      "email":email,
      "current_location":current_location,
      "permanent_location":permanent_location,
      "city":city,
    },
  ));



Future<Result<GetProfileModel>> GetProfile() async =>
    safeCall(AuthService(await dio).getProfile());


  Future<Result<KYCModel>> kycDetail({
    String?aadhar_no,
    File? aadhar_front_image,aadhar_back_image,pan_image

  }) async => safeCall(AuthService(await dio).kycDetails("application/json",
    {
      "aadhar_no":aadhar_no,
      "aadhar_front_image":MultipartFile.fromFileSync(aadhar_front_image?.path ?? ''),
      "aadhar_back_image" :MultipartFile.fromFileSync(aadhar_back_image?.path ?? ''),
      "pan_image":MultipartFile.fromFileSync(pan_image?.path ?? ''),
    }
  ));




  Future<Result<BankDetailAddModel>> addBankDetail({
    String?account_holder_name,account_no,bank_name,ifsc_code

  }) async => safeCall(AuthService(await dio).bankDetail("application/json",
      {
        "account_holder_name":account_holder_name,
        "account_no":account_no,
        "bank_name" :bank_name,
        "ifsc_code":ifsc_code,

      }
  ));



  Future<Result<ContactTermPrivacyModel>> getContactTerm() async =>
      safeCall(AuthService(await dio).contactTerm());


  Future<Result<HomeModel>> GetHome() async =>
      safeCall(AuthService(await dio).homePage());


  Future<Result<LogOutModel>> GetLogOut() async =>
      safeCall(AuthService(await dio).logout());


  Future<Result<BookingPageModel>> getBookingPage() async =>
      safeCall(AuthService(await dio).bookingPage());


  Future<Result<AcceptBookingModel>> bookingAccept({
    String? bookId,
  }) async =>
      safeCall(AuthService(await dio).accptBooking("application/json", {
        "bookId": bookId,
      }));

  Future<Result<OngoingBookingModel>> bookingOngoing({
    String? bookId,
  }) async =>
      safeCall(AuthService(await dio).OngoingBooking("application/json", {
        "bookId": bookId,
      }));


  Future<Result<PickUpBookingModel>> bookingPickUp({
    String? bookId,
  }) async =>
      safeCall(AuthService(await dio).PickUpBooking("application/json", {
        "bookId": bookId,
      }));


  Future<Result<DeliverBookingModel>> bookingDeliver({
    String? bookId,
  }) async =>
      safeCall(AuthService(await dio).DeliverBooking("application/json", {
        "bookId": bookId,
      }));



Future<Result<ViewBookingModel>> bookingView({int? bookId}) async =>
    safeCall(AuthService(await dio).viewBooking(bookId ?? 0));


  Future<Result<UpdateBookingDetailModel>> updateBookingDetail({

    int? bookId,
    List ?qty,weight

  }) async => safeCall(AuthService(await dio).updateOrder("application/json",
      {
        "bookId":bookId,
        "qty":qty,
        "weight" :weight,


      }
  ));


  Future<Result<WalletEarningModel>> getWalletEarning() async =>
      safeCall(AuthService(await dio).walletEarning());





  Future<Result<WalletRequestModel>> walletRequests({
    String? amount,
  }) async =>
      safeCall(AuthService(await dio).walletRequest("application/json", {
        "amount": amount,
      }));



  Future<Result<BookingCancelModel>> bookingCanceled({
    String? bookId,
  }) async =>
      safeCall(AuthService(await dio).bookingCancel("application/json", {
        "bookId": bookId,
      }));



  Future<Result<RiderNotificationModel>> getRiderNotify() async =>
      safeCall(AuthService(await dio).getRiderNotification());




}
