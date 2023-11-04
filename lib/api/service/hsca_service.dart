// import 'package:dio/dio.dart';
// import 'package:retrofit/retrofit.dart';
//
// import '../../common/constant/app_config.dart';
//
//
// part 'hsca_service.g.dart';
//
// @RestApi()
// abstract class HSCAService {
//   factory HSCAService(Dio dio) = _HSCAService;
//
//   @POST(AppConfig.urlRegistrationUser)
//   Future<RegisterResponse> registerUser(@Body() Map<String, dynamic> data);
//
//   @PATCH(AppConfig.urlUpdateUserProfile)
//   Future<EditProfileResponse> updateUserProfile(@Header("Content-Type") String contentType, @Body() Map<String, dynamic> data);
//
//   @GET(AppConfig.mixingData)
//   Future<AppUpdateModel> mixingData(@Header("Content-Type") String contentType);
//
//   @GET(AppConfig.urlHouseListing)
//   Future<dynamic> getHouseListApi(@Header("Content-Type") String contentType);
//
//   @POST(AppConfig.urlAddUpdateHouseList)
//   Future<AddHouseResponse> addUpdateHouseListApi(@Header("Content-Type") String contentType,  @Body() Map<String, dynamic> data);
//
//   @POST(AppConfig.urlLoginUser)
//   Future<LoginModel> login(@Header("Content-Type") String contentType,  @Body() Map<String, dynamic> data);
//
//   @DELETE(AppConfig.urlDeleteHouse)
//   Future<GetDeleteResponse> deleteHouseApi(@Header("Content-Type") String contentType, @Body() Map<String, dynamic> data);
//
// }