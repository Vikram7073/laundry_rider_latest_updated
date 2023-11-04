import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:laundry_rider/router/router.gr.dart';

import '../../../../common/constant/alert_message.dart';
import '../../../../common/constant/app_config.dart';
import '../../../../common/constant/app_utils.dart';

import '../../../../locator/locator.dart';
import '../../../service/navigation_service.dart';
import '../../../service/toast_service.dart';
import '../../result.dart';

typedef EntityMapper<Entity, Model> = Model Function(Entity entity);

abstract class _ErrorCode {
  static const message = "message";
}

abstract class BaseRepository {
  final String _apiEndpoint = AppConfig.host;
  final ToastService _toastService = locator<ToastService>();


  Future<Map<String, String>> _getHeaders() async {
    String token = await AppUtils().getToken();
    String tokenNew = token.replaceAll(RegExp('"'), '');
    return {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $tokenNew"
    };
  }

  Future<Dio> get dio => _getDio();

  Future<Dio> _getDio() async {
    final dio = Dio();
    final headers = await _getHeaders();
    dio.options = BaseOptions(
      baseUrl: _apiEndpoint,
      connectTimeout: 40000,
      receiveTimeout: 40000,
      headers: headers,
      followRedirects: true,
    );
    dio.interceptors.add(LogInterceptor(
        responseBody: !kReleaseMode,
        requestBody: !kReleaseMode,
        responseHeader: !kReleaseMode,
        requestHeader: !kReleaseMode,
        error: !kReleaseMode,
        logPrint: (object) {
          if (!kReleaseMode) {
            debugPrint(object.toString());
          }
        },
        request: !kReleaseMode));

    dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.next(options);
          },
          onResponse:(response, handler) {
            return handler.next(response);
          },
          onError: (error, handler) async {
            if (error.response?.statusCode == 401) {
              try {
                dio.lock();
                dio.interceptors.responseLock.lock();
                dio.interceptors.errorLock.lock();
                dio.interceptors.requestLock..clear();
                dio.clear();
                dio.unlock();
                dio.interceptors.responseLock.unlock();
                dio.interceptors.errorLock.unlock();
                AppUtils().logout();
                locator<NavigationService>().pushAndRemoveUntil(const LoginWithOtpScreenRoute());
              } catch (e) {
                // return e;
              }
            }
            return handler.next(error);
          },
        )
    );

    return dio;
  }

  Future<Result<T>> safeCall<T>(Future<T> call) async {
    try {
      var response = await call;
      return Success(response);
    } catch (exception, stackTrace) {
      print(stackTrace);
      print(exception);
      if (exception is DioError) {
        switch (exception.type) {
          case DioErrorType.connectTimeout:
          case DioErrorType.sendTimeout:
          case DioErrorType.receiveTimeout:
          case DioErrorType.cancel:
            return Error(AlertMessages.TIMEOUT_ERROR_MSG);
          case DioErrorType.other:
            return Error(AlertMessages.OFFLINE_ERROR_MSG);
          case DioErrorType.response:
            return _getError(exception.response);
          default:
            return Error(AlertMessages.GENERIC_ERROR_MSG);
        }
      }
      return Error(AlertMessages.GENERIC_ERROR_MSG);
    }
  }

  Future<Result<T>> _getError<T>(Response? response) async {
    if (response?.data != null && response?.data is Map<String, dynamic>) {
      if ((response!.data as Map<String, dynamic>).containsKey(_ErrorCode.message)) {
        var errorMessage = response.data[_ErrorCode.message] as String;
        // if(response.data[_ErrorCode.errors] != null && (response.data[_ErrorCode.errors] as List<dynamic>) != null && (response.data[_ErrorCode.errors] as List<dynamic>).length > 0) {
        // errorMessage = (response.data[_ErrorCode.errors] as List<dynamic>)[0][_ErrorCode.message];
        // }
        // if (errorMessage.toLowerCase() == _ErrorCode.unauthorized.toLowerCase()) {
        // /// show session expired toast
        // _toastService.show(AlertMessages.SESSION_EXPIRED);
        //
        // /// logout user and navigate user to login screen
        // // await _navigationService.logout();
        //
        // /// return
        // return Error(errorMessage);
        // }
        return Error(errorMessage);
      }
    }
    return Error(
      AlertMessages.GENERIC_ERROR_MSG,
    );
  }
}
