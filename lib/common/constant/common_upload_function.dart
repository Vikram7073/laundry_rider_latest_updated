// import 'dart:io';
//
// import 'package:dio/dio.dart';
//
// import '../../api/network/model/auth/upload_image_model.dart';
// import 'app_utils.dart';
//
// Future<UploadImageModel> commonUploadFunction({String? file,String?type})async{
//   String token = await AppUtils().getToken();
//   String tokenNew = token.replaceAll(RegExp('"'), '');
//
//   try{
//     var response =  await Dio().post("http://apideveloper-env.eba-meb8jzic.ap-south-1.elasticbeanstalk.com/api/zaruiPapers/uploadImage",
//         data: FormData.fromMap({
//           "type": type,
//           "file": MultipartFile.fromFileSync(file??""),
//         }),
//         options: Options(
//             headers: {
//               HttpHeaders.acceptHeader: "application/json",
//               HttpHeaders.authorizationHeader: "Bearer $tokenNew",
//               HttpHeaders.contentTypeHeader : "multipart/form-data"
//             }
//         )
//     );
//     if(response.statusCode==200){
//       return UploadImageModel.fromJson(response.data);
//     }
//   }
//   catch(error, strackt){
//     print(error);
//     print(strackt);
//   }
//   return UploadImageModel();
// }