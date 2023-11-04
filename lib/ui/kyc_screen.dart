import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_rider/common/constant/color_constants.dart';
import 'package:laundry_rider/common/constant/font_style.dart';
import 'package:laundry_rider/common/custom_widget/custom_appbar.dart';
import 'package:laundry_rider/common/custom_widget/custom_button.dart';

import '../common/constant/image.dart';
import '../common/custom_widget/custom_textfield.dart';
import 'bank_detail_screen.dart';
class KycScreen extends StatefulWidget {
  const KycScreen({Key? key}) : super(key: key);

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  TextEditingController aadharController=TextEditingController();
  FilePickerResult? result;
  FilePickerResult? back;
  FilePickerResult? pan;

  var fileNames;

 Future pick( ) async {
   result =
   await FilePicker.platform.pickFiles();
   if (result == null) {
     print("No file selected");
   } else {
     setState(() {});
     for (var element in result!.files) {
        fileNames=element.name;
       print(element.name);
     }
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(preferredSize:Size.fromHeight(45.h), child: CustomAppBar(
      //   title: Text("Kyc",style: AppStyles.whiteColor20Text,),
      //
      // )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        child: Column(
          children: [
            CustomTextField(
              keyboardType: TextInputType.phone,
              controller: aadharController,
              headingText: "Aadhaar Number ",
              maxLines: 1,
              maxLength: 16,
            ),
            SizedBox(height: 15.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      pick( );
                      },
                    child: Container(
                      alignment: Alignment.center,

                      height: 40.h,
                      padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstants.darkGrayColor.withOpacity(0.3)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 105.w,
                              child: Text(result==null?"Aadhaar Front":fileNames.toString(),overflow: TextOverflow.ellipsis,)),
                          SizedBox(width: 10.w,),
                         Image.asset(ImageControl.uploadImg,height: 25.h,width: 25.w,color: ColorConstants.backgroundColor,),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.w,),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      pick();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40.h,
                      padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorConstants.darkGrayColor.withOpacity(0.3)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 105.w,
                              child: Text(result==null?"Aadhaar Back":fileNames.toString(),overflow: TextOverflow.ellipsis,)),
                          SizedBox(width: 10.w,),
                          Image.asset(ImageControl.uploadImg,height: 25.h,width: 25.w,color: ColorConstants.backgroundColor,),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15.h,),
            InkWell(
              onTap: (){
                pick();
              },
              child: Container(
                alignment: Alignment.center,
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstants.darkGrayColor.withOpacity(0.3)              ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(result==null?"Pan Aadhaar Number":fileNames.toString(),overflow: TextOverflow.ellipsis,),
                    SizedBox(width: 10.w,),
                    Image.asset(ImageControl.uploadImg,height: 25.h,width: 25.w,color: ColorConstants.backgroundColor,),
                  ],
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>const BankDetailScreen()));
              },
              text: "Next",textStyle: AppStyles.whiteColor16Text,)

          ],
        ),
      ),
    );
  }
}
