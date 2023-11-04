import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/network/model/repository/base/auth/auth_repo.dart';
import '../model/add_profile_model.dart';

abstract class AddProfileState {}

class AddProfileInitialState extends AddProfileState{}

class AddProfileLoadingState extends AddProfileState{}

class AddProfileErrorState extends AddProfileState{
  String ?error;
  AddProfileErrorState(this.error);
}

class AddProfileSuccessState extends AddProfileState{
  AddProfileModel ? addProfileModel;
  AddProfileSuccessState(this.addProfileModel);

}




abstract class AddProfileEvent{}

class AddProfileSubmitEvent extends AddProfileEvent{
  String ? firstName,lastName,email,currentLocation,permanentLocation,city;
  File? profileImage;
  bool ? isSelectedImage;

  AddProfileSubmitEvent(this.firstName,this.lastName,this.email,this.currentLocation,
      this.permanentLocation,this.city,this.profileImage,this.isSelectedImage);
}



class AddProfileBloc extends Bloc<AddProfileEvent,AddProfileState>{
  AuthRepository authRepository;

  AddProfileBloc(this.authRepository):super(AddProfileInitialState()){

    on<AddProfileSubmitEvent>((event, emit) async {
      emit(AddProfileLoadingState());
      try{
        var res = await authRepository.addProfile(first_name: event.firstName,
            last_name: event.lastName,email: event.email,current_location: event.currentLocation,
            permanent_location: event.permanentLocation,city: event.city,
            profile_image: event.profileImage,isImageSelect: event.isSelectedImage );
        if(res.isSuccess){
          emit(AddProfileSuccessState(res.data));
        }
        else{
          emit(AddProfileErrorState(res.error));
        }

      }catch(e){}

    });

  }
}