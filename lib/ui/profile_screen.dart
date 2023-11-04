import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundry_rider/common/custom_widget/custom_appbar.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../api/service/dialog_service.dart';
import '../api/service/navigation_service.dart';
import '../api/service/toast_service.dart';
import '../bloc/add_profile_bloc.dart';
import '../bloc/get_profile_bloc.dart';
import '../common/constant/color_constants.dart';
import '../common/constant/font_style.dart';
import '../common/constant/image.dart';
import '../common/custom_widget/custom_button.dart';
import '../common/custom_widget/custom_textfield.dart';
import '../locator/locator.dart';
import '../model/get_profile_model.dart';
class ProfileScreen extends StatefulWidget {
  GetProfileModel ? getProfileModel;

   ProfileScreen({Key? key,this.getProfileModel}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController emailNameController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController currentAddressController=TextEditingController();
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileData();
  }

  ProfileData(){
    firstNameController.text=widget.getProfileModel?.data?.firstName??'';
    lastNameController.text=widget.getProfileModel?.data?.lastName??'';
    emailNameController.text=widget.getProfileModel?.data?.email??'';
    currentAddressController.text=widget.getProfileModel?.data?.currentLocation??'';
    cityController.text=widget.getProfileModel?.data?.city??'';
    permanentAddressController.text=widget.getProfileModel?.data?.permanentLocation??'';
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(45.h), child: CustomAppBar(
        title: Text("Edit Profile",style: AppStyles.whiteColor20Text,),
      )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:10.w,vertical: 20.h),
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
                            imageUrl: widget.getProfileModel?.data?.profileImage??"",
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
                maxLength: 30,
              ),
              CustomTextField(
                controller: cityController,
                headingText: "Current City",
                maxLines: 1,
                maxLength: 50,
              ),
              CustomTextField(
                enable: false,
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
                      locator<NavigationService>().pop().then((value){
                        BlocProvider.of<GetProfileBloc>(context).add(GetProfileSubmitEvent());
                      });

                    }
                  }
                },

                child: CustomButton(onTap: (){

                  BlocProvider.of<AddProfileBloc>(context).add(AddProfileSubmitEvent(firstNameController.text,
                      lastNameController.text, emailNameController.text, currentAddressController.text,
                      permanentAddressController.text, cityController.text, imageTemp, isImageSelect));
                },text:"Update",
                  color: ColorConstants.themeColor,
                  textStyle: AppStyles.whiteColor16Text,),
              )
            ],
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

}
