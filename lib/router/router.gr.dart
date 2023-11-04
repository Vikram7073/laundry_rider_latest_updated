// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../ui/login_with_otp_screen.dart' as _i2;
import '../ui/otp_screen.dart' as _i3;
import '../ui/splash_screen.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashScreen(),
      );
    },
    LoginWithOtpScreenRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginWithOtpScreen(),
      );
    },
    OtpScreenRoute.name: (routeData) {
      final args = routeData.argsAs<OtpScreenRouteArgs>(
          orElse: () => const OtpScreenRouteArgs());
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.OtpScreen(
          key: args.key,
          mobileNumber: args.mobileNumber,
        ),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          SplashScreenRoute.name,
          path: '/',
        ),
        _i4.RouteConfig(
          LoginWithOtpScreenRoute.name,
          path: '/login-with-otp-screen',
        ),
        _i4.RouteConfig(
          OtpScreenRoute.name,
          path: '/otp-screen',
        ),
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashScreenRoute extends _i4.PageRouteInfo<void> {
  const SplashScreenRoute()
      : super(
          SplashScreenRoute.name,
          path: '/',
        );

  static const String name = 'SplashScreenRoute';
}

/// generated route for
/// [_i2.LoginWithOtpScreen]
class LoginWithOtpScreenRoute extends _i4.PageRouteInfo<void> {
  const LoginWithOtpScreenRoute()
      : super(
          LoginWithOtpScreenRoute.name,
          path: '/login-with-otp-screen',
        );

  static const String name = 'LoginWithOtpScreenRoute';
}

/// generated route for
/// [_i3.OtpScreen]
class OtpScreenRoute extends _i4.PageRouteInfo<OtpScreenRouteArgs> {
  OtpScreenRoute({
    _i5.Key? key,
    String? mobileNumber,
  }) : super(
          OtpScreenRoute.name,
          path: '/otp-screen',
          args: OtpScreenRouteArgs(
            key: key,
            mobileNumber: mobileNumber,
          ),
        );

  static const String name = 'OtpScreenRoute';
}

class OtpScreenRouteArgs {
  const OtpScreenRouteArgs({
    this.key,
    this.mobileNumber,
  });

  final _i5.Key? key;

  final String? mobileNumber;

  @override
  String toString() {
    return 'OtpScreenRouteArgs{key: $key, mobileNumber: $mobileNumber}';
  }
}
