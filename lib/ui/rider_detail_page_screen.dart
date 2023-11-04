// import 'dart:async';
// import 'dart:io';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:laundry_rider/ui/bank_detail_screen.dart';
// import 'package:linear_step_indicator/linear_step_indicator.dart';
// import 'package:shimmer_animation/shimmer_animation.dart';
// import '../common/constant/color_constants.dart';
// import '../common/constant/font_style.dart';
// import '../common/constant/image.dart';
// import '../common/custom_widget/custom_appbar.dart';
// import '../common/custom_widget/custom_button.dart';
// import '../common/custom_widget/custom_textfield.dart';
// import 'bottom_bar.dart';
// import 'kyc_screen.dart';
//  class ProfileScreen extends StatefulWidget {
//   String ? type;
//   ProfileScreen({Key? key,this.type}) : super(key: key);
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   TextEditingController firstNameController=TextEditingController();
//   TextEditingController lastNameController=TextEditingController();
//   TextEditingController emailNameController=TextEditingController();
//   TextEditingController phoneNameController=TextEditingController();
//   TextEditingController currentAddressController=TextEditingController();
//   TextEditingController permanentAddressController=TextEditingController();
//   TextEditingController pinCodeController=TextEditingController();
//
//   File ? imageTemp;
//   File ? image;
//
//   Future pickImage(ImageSource) async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource);
//       if(image == null) return;
//       imageTemp = File(image.path);
//       //isImageSelect=true;
//       setState(() => this.image = imageTemp);
//     } on PlatformException catch(e) {
//       print('Failed to pick image: $e');
//     }
//   }
//
//
//   //kyc
//
//
//   TextEditingController aadharController=TextEditingController();
//   FilePickerResult? result;
//   FilePickerResult? back;
//   FilePickerResult? pan;
//
//   var fileNames;
//
//   Future pick( ) async {
//     result =
//     await FilePicker.platform.pickFiles();
//     if (result == null) {
//       print("No file selected");
//     } else {
//       setState(() {});
//       for (var element in result!.files) {
//         fileNames=element.name;
//         print(element.name);
//       }
//     }
//   }
//   //bank
//   TextEditingController accountNumberController = TextEditingController();
//   TextEditingController ifscController = TextEditingController();
//   TextEditingController bankNameController = TextEditingController();
//   int STEPS = 3;
//   List name =["Profile","Kyc","Bank Detail"];
//   List stepPage=[KycScreen(),BankDetailScreen(),BankDetailScreen()];
//   final pageController = PageController();
//   int initialPage = 0;
//
//
//   @override
//   Widget build(BuildContext context) {
//     var size=MediaQuery.of(context).size.width;
//
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//             preferredSize: Size.fromHeight(45.h),
//             child: (widget.type == "Add" || widget.type == "Edit") ? CustomAppBar(
//               leading:  IconButton(
//                   onPressed: (){
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(Icons.arrow_back)),
//               title: Text(widget.type=="Add"?" Profile":widget.type=="Edit"?"Edit Profile":"Profile",style:
//               AppStyles.whiteColor16Text.copyWith(fontSize: 22.sp),),):
//             SizedBox()
//         ),
//         body: Padding(
//           padding:  EdgeInsets.symmetric(vertical: 15.h),
//           child: Expanded(
//             child: StepIndicatorPageView(
//               completedIcon: Icons.radio_button_unchecked,
//               backgroundColor: Colors.transparent,
//               inActiveBorderColor: ColorConstants.greyColor,
//               inActiveLineColor:ColorConstants.greyColor,
//               physics: const NeverScrollableScrollPhysics(),
//               steps: STEPS,
//               indicatorPosition: IndicatorPosition.top,
//               labels: List<String>.generate(STEPS, (index) => name[index]),
//               controller: pageController,
//               complete: () {
//                 return Future.value(true);
//               },
//               children: List<Widget>.generate(
//                 STEPS,
//                     (index) {
//
//                   return (initialPage == STEPS - 3) ?
//                       SingleChildScrollView(
//                         physics: const BouncingScrollPhysics(),
//                         child: Padding(
//                           padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
//                           child: Column(
//                             children: [
//                                Stack(
//                                  clipBehavior: Clip.none,
//                                  children: [
//                                    Center(
//                                      child: SizedBox(
//                                        height: size*0.2,width: size*0.2,
//                                        child: ClipRRect(
//                                            borderRadius: BorderRadius.circular(50.r),
//                                            child:image!= null ?
//                                            Image.file(image!,fit: BoxFit.fill,):
//                                            CachedNetworkImage(
//                                              imageUrl: "",
//                                              imageBuilder:
//                                                  (context, imageProvider) =>
//                                                  Container(
//                                                    height: 100.h,
//                                                    width: 100.w,
//                                                    decoration: BoxDecoration(
//                                                      image: DecorationImage(
//                                                        image: imageProvider,
//                                                        fit: BoxFit.fill,
//                                                      ),
//                                                    ),
//                                                  ),
//                                              placeholder: (context, url) =>
//                                                  Shimmer(
//                                                    duration: const Duration(seconds: 1),
//                                                    //Default value
//                                                    interval: const Duration(seconds: 0),
//                                                    //Default value: Duration(seconds: 0)
//                                                    color: ColorConstants.whiteColor,
//                                                    //Default value
//                                                    colorOpacity: 0,
//                                                    //Default value
//                                                    enabled: true,
//                                                    //Default value
//                                                    direction: const ShimmerDirection
//                                                        .fromLTRB(),
//                                                    //Default Value
//                                                    child: Container(
//                                                      color:
//                                                      ColorConstants.greyDarkColor,
//                                                    ),
//                                                  ),
//                                              errorWidget: (context, url, error) =>
//                                                  Image.asset(
//                                                      ImageControl.dummyProfile),
//                                            )
//
//
//                                        ),
//                                      ),
//                                    ),
//                                    Positioned(top: size*0.04,right:  size*0.33,
//                                        child: InkWell(
//                                          onTap: (){
//                                            showAlertDialog();
//                                            // pickImage(ImageSource.gallery);
//                                          },
//                                          child: Container(
//                                              height: 30.h,width: 30.w,
//                                              decoration: const BoxDecoration(
//                                                  shape: BoxShape.circle,
//                                                  color: Colors.purpleAccent
//                                              ),
//                                              child: Icon(Icons.camera_alt,color: Colors.white,size: 20.sp,)),
//                                        )),
//                                  ],
//                                ),
//                                CustomTextField(
//                                  controller: firstNameController,
//                                  headingText: "First Name",
//                                  maxLines: 1,
//                                  maxLength: 20,
//                                ),
//                               // SizedBox(width: 20.w,),
//                                CustomTextField(
//                                  controller: lastNameController,
//                                  headingText: "Last Name",
//                                  maxLines: 1,
//                                  maxLength: 20,
//                                ),
//
//                                CustomTextField(
//                                  controller: emailNameController,
//                                  headingText: "Email Address",
//                                  maxLines: 1,
//                                  maxLength: 35,
//                                ),
//                                CustomTextField(
//                                  controller: phoneNameController,
//                                  headingText: "Mobile Number",
//                                  maxLines: 1,
//                                  maxLength: 10,
//                                  keyboardType: TextInputType.phone,
//                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                                ),
//                                CustomTextField(
//                                  controller: currentAddressController,
//                                  headingText: "Current Location",
//                                  maxLines: 1,
//                                  maxLength: 50,
//                                ),
//                                CustomTextField(
//                                  controller: permanentAddressController,
//                                  headingText: "Permanent Location",
//                                  maxLines: 1,
//                                  maxLength: 50,
//                                ),
//                                SizedBox(height: 30.h,),
//                                CustomButton(onTap: (){
//                                  if (initialPage == STEPS - 1) {
//                                  } else {
//                                    initialPage += 1;
//                                    pageController.jumpToPage(initialPage);
//                                  }
//                                  setState(() {
//
//                                  });
//
//
//
//                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>const KycScreen()));
//                                },text: widget.type=="Add"?"Next":widget.type=="Edit"?"Update":"Next",
//                                  color: ColorConstants.themeColor,
//                                  textStyle: AppStyles.whiteColor16Text,)
//                             ],
//                           ),
//                         ),
//                       )
//                       :(initialPage == STEPS - 2)?
//                   kyc():
//                   bankDetail();
//                     }
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   Future showAlertDialog(){
//     return    showDialog(context: (context), builder: (context){
//       return
//         AlertDialog(
//           title:  Text("Choose Option",style: AppStyles.blackDark14Colortext.copyWith(fontSize: 16.sp),),
//           content: SizedBox(
//             height: 65.h,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InkWell(
//                   onTap: (){
//                     pickImage(ImageSource.gallery);
//                     Navigator.pop(context);
//
//                   },
//                   child: Row(
//                     children: [
//                       const Icon(Icons.image),
//                       SizedBox(width: 15.h,),
//                       Text('Gallery',style: AppStyles.blackDark14Colortext,),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 15.h,),
//                 InkWell(
//                   onTap: (){
//                     pickImage(ImageSource.camera);
//                     Navigator.pop(context);
//
//                   },
//                   child: Row(
//                     children: [
//                       const Icon(Icons.camera_alt),
//                       SizedBox(width: 15.h,),
//
//                       Text('Camera',style: AppStyles.blackDark14Colortext,),
//                     ],
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//
//         );
//     }
//
//     );
//   }
//
//
//   Widget kyc(){
//     return
//     Padding(
//       padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
//       child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           children: [
//             CustomTextField(
//               inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
//               keyboardType: TextInputType.number,
//               controller: aadharController,
//               headingText: "Aadhaar Number ",
//               maxLines: 1,
//               maxLength: 16,
//             ),
//             SizedBox(height: 20.h,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: InkWell(
//                     onTap: (){
//                       pick( );
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//
//                       height: 40.h,
//                       padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: ColorConstants.darkGrayColor.withOpacity(0.3)
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(width: 105.w,
//                               child: Text(result==null?"Aadhaar Front":fileNames.toString(),overflow: TextOverflow.ellipsis,)),
//                           SizedBox(width: 10.w,),
//                           Image.asset(ImageControl.uploadImg,height: 25.h,width: 25.w,color: ColorConstants.backgroundColor,),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 20.w,),
//                 Expanded(
//                   child: InkWell(
//                     onTap: (){
//                       pick();
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       height: 40.h,
//                       padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: ColorConstants.darkGrayColor.withOpacity(0.3)
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(width: 105.w,
//                               child: Text(result==null?"Aadhaar Back":fileNames.toString(),overflow: TextOverflow.ellipsis,)),
//                           SizedBox(width: 10.w,),
//                           Image.asset(ImageControl.uploadImg,height: 25.h,width: 25.w,color: ColorConstants.backgroundColor,),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(height: 20.h,),
//             InkWell(
//               onTap: (){
//                 pick();
//               },
//               child: Container(
//                 alignment: Alignment.center,
//                 height: 40.h,
//                 padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: ColorConstants.darkGrayColor.withOpacity(0.3)              ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(result==null?"Pan Aadhaar Number":fileNames.toString(),overflow: TextOverflow.ellipsis,),
//                     SizedBox(width: 10.w,),
//                     Image.asset(ImageControl.uploadImg,height: 25.h,width: 25.w,color: ColorConstants.backgroundColor,),
//                   ],
//                 ),
//               ),
//             ),
//            SizedBox(height: 150.h,),
//             CustomButton(
//               onTap: (){
//                 if (initialPage == STEPS - 1) {
//                 } else {
//                   initialPage += 1;
//                   pageController.jumpToPage(initialPage);
//                 }
//                 setState(() {
//
//                 });
//                 //Navigator.push(context, MaterialPageRoute(builder: (context)=>const BankDetailScreen()));
//               },
//               text: "Next",textStyle: AppStyles.whiteColor16Text,)
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget bankDetail(){
//     return Padding(
//       padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
//       child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           children: [
//             CustomTextField(
//               inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
//               keyboardType: TextInputType.phone,
//               controller: accountNumberController,
//               headingText: "Account Number",
//               maxLines: 1,
//               maxLength: 20,
//             ),
//             CustomTextField(
//               controller: ifscController,
//               headingText: "IFSC Code",
//               maxLines: 1,
//               maxLength: 11,
//             ),
//             CustomTextField (
//               controller: bankNameController,
//               headingText: "Bank Name",
//               maxLines: 1,
//               maxLength: 50,
//             ),
//            SizedBox(height: 100.h,),
//             CustomButton(
//               onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen(index: 3,)));
//               },
//               text: "Save",textStyle: AppStyles.whiteColor16Text,)
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundry_rider/api/service/dialog_service.dart';
import 'package:laundry_rider/api/service/toast_service.dart';
import 'package:laundry_rider/bloc/add_bank_detail_bloc.dart';
import 'package:laundry_rider/bloc/add_profile_bloc.dart';
import 'package:laundry_rider/bloc/get_profile_bloc.dart';
import 'package:laundry_rider/bloc/kyc_bloc.dart';
import 'package:laundry_rider/locator/locator.dart';
import 'package:linear_step_indicator/linear_step_indicator.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../common/constant/app_utils.dart';
import '../common/constant/color_constants.dart';
import '../common/constant/font_style.dart';
import '../common/constant/image.dart';
import '../common/custom_widget/custom_appbar.dart';
import '../common/custom_widget/custom_button.dart';
import '../common/custom_widget/custom_textfield.dart';
import '../model/get_profile_model.dart';
import 'bottom_bar.dart';
class RiderDetailPageScreen extends StatefulWidget {
  GetProfileModel ? getProfileModel;
   RiderDetailPageScreen({Key? key,this.getProfileModel}) : super(key: key);

  @override
  State<RiderDetailPageScreen> createState() => _RiderDetailPageScreenState();
}

class _RiderDetailPageScreenState extends State<RiderDetailPageScreen> {

  //var kGoogleApiKey="AIzaSyAyx9mft3FiEBZKON7mbbttS67Rsal4d68";

  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController emailNameController=TextEditingController();
  TextEditingController phoneNameController=TextEditingController();
  TextEditingController currentAddressController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController permanentAddressController=TextEditingController();
  TextEditingController pinCodeController=TextEditingController();

  File ? imageTemp;
  File ? image;
  bool ? isImageSelect;

  Future pickImage(ImageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource);
      if(image == null) return;
      imageTemp = File(image.path);
      isImageSelect=true;
      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }


  //kyc


  TextEditingController aadharController=TextEditingController();
  FilePickerResult? result;
  FilePickerResult? back;
  FilePickerResult? pan;

  var fileNames;
  File ? picImage;
  File ?tempImage;
  File ?aadhaarBackImage;
  File ? panImage;


  Future pickImages(ImageSource,int index) async {
    try {
      final picImage = await ImagePicker().pickImage(source: ImageSource);
      if(picImage == null) return;
      tempImage = File(picImage.path);
      if(index==0){
        setState(() => this.picImage = tempImage);
      }
      else if(index==1){
        setState(() => this.aadhaarBackImage = tempImage);
      }
      else if(index==2){
        setState(() => this.panImage = tempImage);

      }

    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

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
  //bank
  TextEditingController accountHolderName=TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  int STEPS = 3;
  List name =["Profile","Kyc","Bank Detail"];
  final pageController = PageController();
  int initialPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     BlocProvider.of<GetProfileBloc>(context).add(GetProfileSubmitEvent());

    profileData();
  }

  profileData(){
    firstNameController.text=widget.getProfileModel?.data?.firstName??"";
    lastNameController.text=widget.getProfileModel?.data?.lastName??"";
    emailNameController.text=widget.getProfileModel?.data?.email??"";
    phoneNameController.text=widget.getProfileModel?.data?.mobileNo.toString()??"";
    currentAddressController.text=widget.getProfileModel?.data?.currentLocation??"";
    cityController.text=widget.getProfileModel?.data?.city??"";
    permanentAddressController.text=widget.getProfileModel?.data?.currentLocation??"";

  }



  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.h),
          child:  CustomAppBar(
            leading:  const Text(""),
            centerTile: true,
            title: Text(" Rider Profile",style:
            AppStyles.whiteColor16Text.copyWith(fontSize: 22.sp),),)

      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: 15.h,),
        child: StepIndicatorPageView(
          completedIcon: Icons.radio_button_unchecked,
          backgroundColor: Colors.transparent,
          inActiveBorderColor: ColorConstants.greyColor,
          inActiveLineColor:ColorConstants.greyColor,
          physics: const NeverScrollableScrollPhysics(),
          steps: STEPS,
          indicatorPosition: IndicatorPosition.top,
          labels: List<String>.generate(STEPS, (index) => name[index]),
          controller: pageController,

          complete: () {
            return Future.value(true);
          },
          children: List<Widget>.generate(
              STEPS,
                  (index) {
                   return (initialPage == STEPS - 3) ?
                    SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Center(
                              child: SizedBox(
                                height: size*0.2,width: size*0.2,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.r),
                                    child:image!= null ?
                                    Image.file(image!,fit: BoxFit.fill,):
                                    CachedNetworkImage(
                                      imageUrl: "",
                                      imageBuilder:
                                          (context, imageProvider) =>
                                          Container(
                                            height: 100.h,
                                            width: 100.w,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                      placeholder: (context, url) =>
                                          Shimmer(
                                            duration: const Duration(seconds: 1),
                                            //Default value
                                            interval: const Duration(seconds: 0),
                                            //Default value: Duration(seconds: 0)
                                            color: ColorConstants.whiteColor,
                                            //Default value
                                            colorOpacity: 0,
                                            //Default value
                                            enabled: true,
                                            //Default value
                                            direction: const ShimmerDirection
                                                .fromLTRB(),
                                            //Default Value
                                            child: Container(
                                              color:
                                              ColorConstants.greyDarkColor,
                                            ),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              ImageControl.dummyProfile),
                                    )


                                ),
                              ),
                            ),
                            Positioned(top: size*0.04,right:  size*0.33,
                                child: InkWell(
                                  onTap: (){
                                    showAlertDialog();
                                    // pickImage(ImageSource.gallery);
                                  },
                                  child: Container(
                                      height: 30.h,width: 30.w,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.purpleAccent
                                      ),
                                      child: Icon(Icons.camera_alt,color: Colors.white,size: 20.sp,)),
                                )),
                          ],
                        ),
                        CustomTextField(
                          controller: firstNameController,
                          headingText: "First Name",
                          maxLines: 1,
                          maxLength: 20,
                        ),
                        // SizedBox(width: 20.w,),
                        CustomTextField(
                          controller: lastNameController,
                          headingText: "Last Name",
                          maxLines: 1,
                          maxLength: 20,
                        ),
                        CustomTextField(
                          controller: emailNameController,
                          headingText: "Email Address",
                          maxLines: 1,
                          maxLength: 35,
                        ),
                        CustomTextField(
                          controller: currentAddressController,
                          headingText: "Current Location",
                          maxLines: 1,
                          maxLength: 50,
                        ),
                        CustomTextField(
                          controller: cityController,
                          headingText: " Current City",
                          maxLines: 1,
                          maxLength: 50,
                        ),
                        CustomTextField(
                          controller: permanentAddressController,
                          headingText: "Permanent Location",
                          maxLines: 1,
                          maxLength: 50,
                        ),
                        SizedBox(height: 30.h,),

                        BlocListener<AddProfileBloc,AddProfileState>(
                          listener: (context,state){
                            if(state is AddProfileLoadingState){
                              locator<DialogService>().showLoader2();
                            }else if(state is AddProfileSuccessState){
                              locator<DialogService>().hideLoader();
                              if(state.addProfileModel?.status==false){
                                locator<ToastService>().show(state.addProfileModel?.message??"");
                              }else{
                                locator<ToastService>().show(state.addProfileModel?.message??"");
                               setState(() {
                                 initialPage += 1;
                                 pageController.jumpToPage(initialPage);
                               });


                              }
                            }
                          },
                          child: CustomButton(onTap: (){
                            if (initialPage == STEPS - 1) {
                            } else {
                              BlocProvider.of<AddProfileBloc>(context).add(AddProfileSubmitEvent(firstNameController.text,
                                  lastNameController.text, emailNameController.text, currentAddressController.text,
                                  permanentAddressController.text, cityController.text, imageTemp, isImageSelect));
                              // initialPage += 1;
                              // pageController.jumpToPage(initialPage);
                            }
                            setState(() {

                            });



                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>const KycScreen()));
                          },text:"Next",
                            color: ColorConstants.themeColor,
                            textStyle: AppStyles.whiteColor16Text,),
                        )
                      ],
                    ),
                  ),
                )
                    :(initialPage == STEPS - 2)?
                   //kyc
                   kyc():
                    bankDetail();
              }
          ),
        ),
      ),
    );
  }
  Future showAlertDialog(){
    return    showDialog(context: (context), builder: (context){
      return
        AlertDialog(
          title:  Text("Choose Option",style: AppStyles.blackDark14Colortext.copyWith(fontSize: 16.sp),),
          content: SizedBox(
            height: 65.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    pickImage(ImageSource.gallery);
                    Navigator.pop(context);

                  },
                  child: Row(
                    children: [
                      const Icon(Icons.image),
                      SizedBox(width: 15.h,),
                      Text('Gallery',style: AppStyles.blackDark14Colortext,),
                    ],
                  ),
                ),
                SizedBox(height: 15.h,),
                InkWell(
                  onTap: (){
                    pickImage(ImageSource.camera);
                    Navigator.pop(context);

                  },
                  child: Row(
                    children: [
                      const Icon(Icons.camera_alt),
                      SizedBox(width: 15.h,),

                      Text('Camera',style: AppStyles.blackDark14Colortext,),
                    ],
                  ),
                ),

              ],
            ),
          ),

        );
    }

    );
  }


  Widget kyc(){
    return
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
                keyboardType: TextInputType.number,
                controller: aadharController,
                headingText: "Aadhaar Number ",
                maxLines: 1,
                maxLength: 12,
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 95.h,width: 155.w,


                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: picImage!= null ?
                      Image.file(picImage!,fit: BoxFit.fill,):
                      Image.asset(ImageControl.verificationDummyImg,height: 100.h,width: 130.w,),
                    ),
                  ),
                  Container(
                    height: 95.h,width: 155.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: aadhaarBackImage!= null ?
                      Image.file(aadhaarBackImage!,fit: BoxFit.fill,):
                      Image.asset(ImageControl.verificationDummyImg,height: 100,width: 130.w,),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        pickImages(ImageSource.gallery,0);
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
                            Text("Aadhaar Front",overflow: TextOverflow.ellipsis,),
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
                        pickImages(ImageSource.gallery,1);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 35.h,
                        padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorConstants.darkGrayColor.withOpacity(0.3)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(result==null?"Aadhaar Back":fileNames.toString(),overflow: TextOverflow.ellipsis,),
                            SizedBox(width: 10.w,),
                            Image.asset(ImageControl.uploadImg,height: 25.h,width: 25.w,color: ColorConstants.backgroundColor,),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h,),
              Container(
                height: 95.h,width: 155.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: panImage!= null ?
                  Image.file(panImage!,fit: BoxFit.fill,):
                  Image.asset(ImageControl.verificationDummyImg,fit: BoxFit.fill,),
                ),
              ),
              SizedBox(height: 10.h,),

              InkWell(
                onTap: (){
                  pickImages(ImageSource.gallery,2);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 35.h,width: 160.w,
                  padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.darkGrayColor.withOpacity(0.3)              ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(result==null?"Pan Upload":fileNames.toString(),overflow: TextOverflow.ellipsis,),
                      SizedBox(width: 10.w,),
                      Image.asset(ImageControl.uploadImg,height: 25.h,width: 25.w,color: ColorConstants.backgroundColor,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h,),
              BlocListener<KYCBloc,KYCState>(
                listener: (context,state){
                  if(state is KYCLoadingState){
                    locator<DialogService>().showLoader2();
                  }
                  else if(state is KYCSuccessState){
                    locator<DialogService>().hideLoader();
                    if(state.kycModel?.status==false){
                      locator<ToastService>().show(state.kycModel?.message??"");
                    }
                    else{
                      locator<ToastService>().show(state.kycModel?.message??"");
                      AppUtils().setUserLoggedIn(state.kycModel?.status??false);
                      setState(() {
                        initialPage += 1;
                        pageController.jumpToPage(initialPage);
                      });
                    }
                  }
                },
                child: CustomButton(
                  onTap: (){
                    if (initialPage == STEPS - 1) {
                    } else {
                      if(aadharController.text.isEmpty){
                        locator<ToastService>().show("Please enter aadhaar number");
                      }
                      else if(!(RegExp(r'^[2-9]{1}[0-9]{3}[0-9]{8}$').hasMatch(aadharController.text))){
                        locator<ToastService>().show("Enter a valid aadhaar number");
                      }
                      else if(picImage==null){
                        locator<ToastService>().show("Please select aadhaar front image");
                      }
                      else if(aadhaarBackImage==null){
                        locator<ToastService>().show("Please select aadhaar back image");
                      }
                      else if(panImage==null){
                        locator<ToastService>().show("Please select pan image");
                      }else{
                        BlocProvider.of<KYCBloc>(context).add(KYCSubmitEvent(aadharController.text, picImage, aadhaarBackImage, panImage));
                      }
                    }
                    setState(() {

                    });
                  },
                  text: "Next",textStyle: AppStyles.whiteColor16Text,),
              )

            ],
          ),
        ),
      );
  }

  Widget bankDetail(){
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomTextField(
              controller: accountHolderName,
              headingText: "Account Holder Name",
              maxLines: 1,
              maxLength: 20,
            ),
            CustomTextField(
              inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
              keyboardType: TextInputType.phone,
              controller: accountNumberController,
              headingText: "Account Number",
              maxLines: 1,
              maxLength: 16,
            ),
            CustomTextField(
              controller: ifscController,
              headingText: "IFSC Code",
              maxLines: 1,
              maxLength: 11,
            ),
            CustomTextField (
              controller: bankNameController,
              headingText: "Bank Name",
              maxLines: 1,
              maxLength: 50,
            ),
            SizedBox(height: 100.h,),
            BlocListener<BankDetailBloc,BankDetailState>(
              listener: (context,state){
                if(state is BankDetailLoadingState){
                  locator<DialogService>().showLoader2();
                }
                else if(state is BankDetailSuccessState){
                  locator<DialogService>().hideLoader();
                  if(state.bankDetailAddModel?.status==false){
                    locator<ToastService>().show(state.bankDetailAddModel?.message??'');
                  }else{
                    locator<ToastService>().show(state.bankDetailAddModel?.message??'');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen(index: 0,)));
                  }
                }
              },
              child: CustomButton(
                onTap: (){
                  if(!( RegExp(r"^[A-Za-z]{4}0[A-Z0-9a-z]{6}$")
                      .hasMatch((ifscController.text)))){
                    locator<ToastService>().show("Enter valid ifsc code");
                  }
                  else{
                    BlocProvider.of<BankDetailBloc>(context).add(BankDetailSubmitEvent(accountHolderName.text,
                        accountNumberController.text, bankNameController.text, ifscController.text.toUpperCase()));
                  }
                },
                text: "Save",textStyle: AppStyles.whiteColor16Text,),
            )
          ],
        ),
      ),
    );
  }


//   Future GetLocationFromGoogle( int? index) async {
//     Prediction? p = await PlacesAutocomplete.show(
//         context: context,
//         apiKey: kGoogleApiKey,
//         mode: Mode.fullscreen,
//         offset: 5.0,
//         language: 'en',
//         strictbounds: false,
//         types: [""],
//         decoration: const InputDecoration(
//             hintStyle: TextStyle(fontSize: 16), hintText: 'Enter Location'),
//         components: [Component(Component.country, "in")]);
//     displayPrediction(p!,index)
//         .whenComplete(() {});
//   }
//
//   Future displayPrediction(
//       Prediction p,index) async {
//     GoogleMapsPlaces places = GoogleMapsPlaces(
//         apiKey: kGoogleApiKey,
//         apiHeaders: await const GoogleApiHeaders().getHeaders());
//     PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
//     final latitude = detail.result.geometry!.location.lat;
//     final longitude = detail.result.geometry!.location.lng;
//     fetch_address(latitude, longitude,index);
//   }
// //  create functon  get  location from cordinates
//
//   fetch_address(lat, long,index) async {
//     final coordinates = Coordinates(lat, long);
//
//     var addresses =
//     await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     if(index==1){
//       currentAddressController.text =
//       "${addresses.first.addressLine.toString()} ${addresses.first.subLocality.toString()} ${addresses.first.locality.toString()}";
//       cityController.text="${addresses.first.locality.toString()}";
//     }else if(index==2){
//       permanentAddressController.text =
//       "${addresses.first.addressLine.toString()} ${addresses.first.subLocality.toString()} ${addresses.first.locality.toString()}";
//     }
//     print("this is address ${addresses.first.locality}");
//     setState(() {});
//     return addresses.first;
//   }

}

