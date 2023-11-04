import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:ndialog/ndialog.dart';
import '../../common/constant/color_constants.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../router/router.gr.dart';


@lazySingleton
class DialogService {
  final AppRouter _router;
  DialogService(this._router);

  ProgressDialog? _pr;
  CustomProgressDialog? _cpr;

  BuildContext _getSafeContext() {
    final context = _router.navigatorKey.currentContext;
    return context != null ? context : throw ('Have you forgot to setup routes?');
  }

  void showLoader({String? message}) {
    hideLoader();
    if (message == null) {
      _cpr = CustomProgressDialog(
          _getSafeContext(),
          loadingWidget: Container(
            padding: const EdgeInsets.all(20),
            // child: AppProgressIndicator(),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
              shape: BoxShape.rectangle,
            ),
            child: const CircularProgressIndicator(color: ColorConstants.blueLightColor),
          ),
          dismissable: true
      );
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        _cpr!.show();
      });
    } else {
      _pr = ProgressDialog(_getSafeContext(),
          title: null,
          dialogStyle: DialogStyle(
            borderRadius: BorderRadius.circular(10.0),
            backgroundColor: Colors.white,
            elevation: 10.0,
          ),
          // defaultLoadingWidget: AppProgressIndicator(),
          message: Text(message),
          dismissable: true
      );
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        _pr!.show();
      });
    }
  }

  void showLoader2({String? message}) {
    hideLoader();
    if (message == null) {
      _cpr = CustomProgressDialog(
          _getSafeContext(),
          loadingWidget: Container(
            height: double.infinity,
            width: double.infinity,
            //padding: const EdgeInsets.all(20),
            // child: AppProgressIndicator(),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.transparent,
              shape: BoxShape.rectangle,
            ),
            child: Center(
              child: Container(
                  height: 20,
                  width: 200,
                  child: LoadingIndicator(
                      indicatorType: Indicator.ballPulse, /// Required, The loading type of the widget
                      colors:  [Colors.black.withOpacity(0.6),Colors.blueAccent],       /// Optional, The color collections
                      strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                      backgroundColor: Colors.transparent,      /// Optional, Background of the widget
                      pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
                  )),
            ),
          ),
          dismissable: true
      );
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _cpr!.show();
      });
    } else {
      _pr = ProgressDialog(_getSafeContext(),
          title: null,
          dialogStyle: DialogStyle(
            borderRadius: BorderRadius.circular(10.0),
            backgroundColor: Colors.white,
            elevation: 10.0,
          ),
          // defaultLoadingWidget: AppProgressIndicator(),
          message: Text(message),
          dismissable: true
      );
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        _pr!.show();
      });
    }
  }


  void hideLoader() {
    if (_pr?.isShowed ?? false) {
      _pr?.dismiss();
    }
    if (_cpr?.isShowed ?? false) {
      _cpr?.dismiss();
    }
  }

  viewLoader() {
    return const Center(
      child: Card(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(color: ColorConstants.themeColor),
          )),
    );
  }
}



/*
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:ndialog/ndialog.dart';
import '../../common/constant/color_constants.dart';
import '../../common/router/router.gr.dart';

@lazySingleton
class DialogService {
  final AppRouter _router;
  DialogService(this._router);

  ProgressDialog? _pr;
  CustomProgressDialog? _cpr;

  BuildContext _getSafeContext() {
    final context = _router.navigatorKey.currentContext;
    return context != null ? context : throw ('Have you forgot to setup routes?');
  }

  void showLoader({String? message}) {
    hideLoader();
    if (message == null) {
      _cpr = CustomProgressDialog(
          _getSafeContext(),
          loadingWidget: Container(
            padding: const EdgeInsets.all(20),
            // child: AppProgressIndicator(),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
              shape: BoxShape.rectangle,
            ),
            child: const CircularProgressIndicator(color: ColorConstants.blueLightColor),
          ),
          dismissable: true
      );
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        _cpr!.show();
      });
    } else {
      _pr = ProgressDialog(_getSafeContext(),
          title: null,
          dialogStyle: DialogStyle(
            borderRadius: BorderRadius.circular(10.0),
            backgroundColor: Colors.white,
            elevation: 10.0,
          ),
          // defaultLoadingWidget: AppProgressIndicator(),
          message: Text(message),
          dismissable: true
      );
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        _pr!.show();
      });
    }
  }
  void showLoader2({String? message}) {
    hideLoader();
    if (message == null) {
      _cpr = CustomProgressDialog(
          _getSafeContext(),
          loadingWidget: Container(
            height: double.infinity,
            width: double.infinity,
            //padding: const EdgeInsets.all(20),
            // child: AppProgressIndicator(),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.transparent,
              shape: BoxShape.rectangle,
            ),
            child: Center(
              child: Container(
                  height: 50,
                  width: 50,
                  child: const CircularProgressIndicator(color: ColorConstants.blueLightColor,)),
            ),
          ),
          dismissable: true
      );
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _cpr!.show();
      });
    } else {
      _pr = ProgressDialog(_getSafeContext(),
          title: null,
          dialogStyle: DialogStyle(
            borderRadius: BorderRadius.circular(10.0),
            backgroundColor: Colors.white,
            elevation: 10.0,
          ),
          // defaultLoadingWidget: AppProgressIndicator(),
          message: Text(message),
          dismissable: true
      );
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        _pr!.show();
      });
    }
  }


  void hideLoader() {
    if (_pr?.isShowed ?? false) {
      _pr?.dismiss();
    }
    if (_cpr?.isShowed ?? false) {
      _cpr?.dismiss();
    }
  }

  viewLoader() {
    return const Center(
      child: Card(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(color: ColorConstants.themeColor),
          )),
    );
  }
}
*/
