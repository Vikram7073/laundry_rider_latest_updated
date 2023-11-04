import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_rider/common/constant/font_style.dart';
import 'package:laundry_rider/common/custom_widget/custom_appbar.dart';
import 'package:laundry_rider/common/custom_widget/custom_button.dart';

import '../common/custom_widget/custom_textfield.dart';
class BankDetailScreen extends StatefulWidget {
  const BankDetailScreen({Key? key}) : super(key: key);

  @override
  State<BankDetailScreen> createState() => _BankDetailScreenState();
}

class _BankDetailScreenState extends State<BankDetailScreen> {
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController bankNameController = TextEditingController(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(45.h), child: CustomAppBar(
        title: Text("Bank Detail",style: AppStyles.whiteColor20Text,),
      )),

      body:Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        child: Column(
          children: [
            CustomTextField(
              keyboardType: TextInputType.phone,
              controller: accountNumberController,
              headingText: "Account Number",
              maxLines: 1,
              maxLength: 20,
            ),
            CustomTextField(
              controller: ifscController,
              headingText: "IFSC Code",
              maxLines: 1,
              maxLength: 11,
            ),
            CustomTextField(
              controller: bankNameController,
              headingText: "Bank Name",
              maxLines: 1,
              maxLength: 50,
            ),
            const Spacer(),
            CustomButton(
              onTap: (){},
              text: "Save",textStyle: AppStyles.whiteColor16Text,)

          ],
        ),
      ),
    );
  }
}
