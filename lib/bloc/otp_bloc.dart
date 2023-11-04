import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_rider/model/OTP_model.dart';

import '../api/network/model/repository/base/auth/auth_repo.dart';

abstract class OTPState {}

class OTPInitialState extends OTPState{}

class OTPLoadingState extends OTPState{}

class OTPErrorState extends OTPState{
  String ?error;
  OTPErrorState(this.error);
}

class OTPSuccessState extends OTPState{
  OTPModel ? otpModel;
  OTPSuccessState(this.otpModel);

}




abstract class OTPEvent{}

class OTPSubmitEvent extends OTPEvent{
  String ? mobileNumber,otp;
  OTPSubmitEvent(this.mobileNumber,this.otp);
}



class OTPBloc extends Bloc<OTPEvent,OTPState>{
  AuthRepository authRepository;

  OTPBloc(this.authRepository):super(OTPInitialState()){

    on<OTPSubmitEvent>((event, emit) async {
      emit(OTPLoadingState());
      try{
        var res = await authRepository.verifyToOtp(mobile_no: event.mobileNumber,otp: event.otp );
        if(res.isSuccess){
          emit(OTPSuccessState(res.data));
        }
        else{
          emit(OTPErrorState(res.error));
        }

      }catch(e){}

    });

  }
}