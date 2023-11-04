import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';


@lazySingleton
class AppUtils {

  String myData = "my_data";
  String name = "name";
  String userId = "user_id";
  String token = "token";
  String remember = "false";
  String firstName = "firstName";
  String fcmToken="FcmToken";
  String lastName = "lastName";
  String roll="roll";
  String profileImage = 'profileImage';

  String tokenExpire="tokenExpire";
//this is how save model data in sharedPreference

  // Future<void> setMyAccountInfo(GetMyProfileModel? user) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String userData = jsonEncode(user);
  //   print("this is our data ${userData}");
  //   prefs.setString(myData, userData);
  // }
  //
  //
  //
  // Future<GetMyProfileModel> getMyAccountInfo() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Map<String,dynamic> json=jsonDecode(prefs.getString(myData)??"");
  //   print("this is the json ${json}");
  //   GetMyProfileModel? data = GetMyProfileModel.fromJson(json);
  //   return data ;
  // }



  Future<void> setFcm(String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(fcmToken,data);
  }

  Future<String> getFcm() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data= preferences.getString(fcmToken)??"";
    return data;
  }








  Future<bool> getUserTokenExpire( ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('tokenExpire') ?? false;
    return isLoggedIn;
  }

  void setUserTokenExpire(bool data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('tokenExpire', true);
  }






  Future<bool> getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('user_logged_in') ?? false;
    return isLoggedIn;
  }

  void setUserLoggedIn( bool loginStatus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('user_logged_in', loginStatus);
  }

  Future<void> setFirstName(String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(firstName,data);
  }

  Future<String> getFirstName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data= preferences.getString(firstName)??"";
    return data;
  }


  Future<void> setLastName(String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(lastName,data);
  }

  Future<String> getLastName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data= preferences.getString(lastName)??"";
    return data;
  }


  Future<void> setRole(int  id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(roll,id);
  }

  Future<int> getRole() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? data= preferences.getInt(roll);
    return data??0;
  }




  Future<void> setId(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(userId,id);
  }

  Future<int> getId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? data= preferences.getInt(userId);
    return data??0;
  }

  Future<void> setToken(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(token, data);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString(token)??"";
    return data;
  }
  Future logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(token);
    await preferences.remove(firstName);
    await preferences.remove(name);
  }

}
