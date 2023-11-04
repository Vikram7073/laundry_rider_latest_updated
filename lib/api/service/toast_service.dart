import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ToastService {
  show(String message) {
    if (message.isNotEmpty) {
      Fluttertoast.showToast(msg: message, backgroundColor: Colors.black,
          toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
    }
  }

  showLong(String message) {
    if (message.isNotEmpty) {
      Fluttertoast.showToast(
          msg: message,
          backgroundColor: Colors.black,
          toastLength: Toast.LENGTH_LONG);
    }
  }

  showInCenter(String message) {
    if (message.isNotEmpty) {
      Fluttertoast.showToast(
          msg: message,
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER);
    }
  }

  showTop(String message) {
    if (message.isNotEmpty) {
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: const Color(0xFF1BC5BD),
          textColor: Colors.white,
          fontSize: 16.0.sp);
    }
  }
}
