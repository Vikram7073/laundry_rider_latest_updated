import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/color_constants.dart';
import '../constant/font_style.dart';

class CustomField extends StatelessWidget {
  TextInputType? keyboardType;
  EdgeInsetsGeometry? contentPadding;
  String ?labelText;
  String? headingText;
  Color fillColor;
  Widget? prefix;
  Widget? prefixIcon;
  Widget? suffix;
  int? maxLines;
  bool? enable;
  int? maxLength;
  bool? obscureText;
  void Function()? onTap;
  TextCapitalization? textCapitalization;
  List<TextInputFormatter>? inputFormatters;
  String? Function(String?)? validator;
  TextEditingController? controller = TextEditingController();
  void Function(String?)? onSaved;
  void Function(String?)? onChange;
  double ?height;
  CustomField(
      {this.obscureText,
        this.contentPadding,
      this.textCapitalization,
       this.validator,
      this.prefix,this.height,
      this.suffix,
       this.prefixIcon,
      this.onTap,
      this.inputFormatters,
      required this.fillColor,
       this.controller,
       this.labelText,
      this.onSaved,
        this.onChange,
      this.headingText,
      this.keyboardType = TextInputType.multiline,
      this.maxLines,
        this.enable,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: TextFormField(
        textInputAction: TextInputAction.newline,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        cursorWidth: 1,
        validator: validator,
        onChanged: onChange,
        enabled: enable,
        obscureText: obscureText ?? false,
        maxLines: maxLines,
        keyboardType: keyboardType,
        controller: controller,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        onSaved: onSaved,
        style:  TextStyle(
          color: ColorConstants.blackColor,fontSize: 14.sp
        ),
        decoration: InputDecoration(
          counterText: "",
          alignLabelWithHint: true,
          prefix: prefix,
          prefixIcon: prefixIcon,
          suffixIcon: suffix,
          fillColor: fillColor,
          filled: true,
          labelText: labelText,
         labelStyle:  AppStyles.greyBlackColor12Text.copyWith(fontSize: 14.sp),
         // hintText: labelText,
          hintStyle: AppStyles.hintStyle,
          errorStyle: TextStyle(
            color: Colors.red,
          ),
          contentPadding: contentPadding??EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          enabledBorder: OutlineInputBorder(
            borderSide:
                 BorderSide(color: ColorConstants.greenLightColor.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(10.r),
          ),
          border: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorConstants.greenLightColor.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(10.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                 BorderSide(color: ColorConstants.greenLightColor.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(10.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:
                 BorderSide(color: ColorConstants.greenLightColor.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(5.r),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorConstants.greenLightColor.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(10.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide:
                 BorderSide(color: ColorConstants.greenLightColor.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
