import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/network/model/repository/base/auth/auth_repo.dart';
import '../model/add_profile_model.dart';
import '../model/kyc_model.dart';

abstract class KYCState {}

class KYCInitialState extends KYCState{}

class KYCLoadingState extends KYCState{}

class KYCErrorState extends KYCState{
  String ?error;
  KYCErrorState(this.error);
}

class KYCSuccessState extends KYCState{
  KYCModel ? kycModel;
  KYCSuccessState(this.kycModel);

}




abstract class KYCEvent{}

class KYCSubmitEvent extends KYCEvent{
  String ?  aadhar_no;
  File ? aadhar_front_image,aadhar_back_imagepan_image,pan_image;


  KYCSubmitEvent(this.aadhar_no,this.aadhar_front_image,this.aadhar_back_imagepan_image,this.pan_image);
}



class KYCBloc extends Bloc<KYCEvent,KYCState>{
  AuthRepository authRepository;

  KYCBloc(this.authRepository):super(KYCInitialState()){

    on<KYCSubmitEvent>((event, emit) async {
      emit(KYCLoadingState());
      try{
        var res = await authRepository.kycDetail(aadhar_no: event.aadhar_no,aadhar_front_image: event.aadhar_front_image,
            aadhar_back_image: event.aadhar_back_imagepan_image,pan_image: event.pan_image);
        if(res.isSuccess){
          emit(KYCSuccessState(res.data));
        }
        else{
          emit(KYCErrorState(res.data.message));
        }

      }catch(e){}

    });

  }
}