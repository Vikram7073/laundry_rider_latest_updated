import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/network/model/repository/base/auth/auth_repo.dart';
import '../model/login_model.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState{}

class LoginLoadingState extends LoginState{}

class LoginErrorState extends LoginState{
  String ?error;
  LoginErrorState(this.error);
}

class LoginSuccessState extends LoginState{
  LoginModel ? loginModel;
  LoginSuccessState(this.loginModel);

}




abstract class LoginEvent{}

class LoginSubmitEvent extends LoginEvent{
  String ? mobileNumber,fcm;
  LoginSubmitEvent(this.mobileNumber,this.fcm);
}



class LoginBloc extends Bloc<LoginEvent,LoginState>{
  AuthRepository authRepository;

  LoginBloc(this.authRepository):super(LoginInitialState()){

    on<LoginSubmitEvent>((event, emit) async {
      emit(LoginLoadingState());
      try{
        var res = await authRepository.loginOtp(mobile_no: event.mobileNumber,token: event.fcm );
        if(res.isSuccess){
          emit(LoginSuccessState(res.data));
        }
        else{
          emit(LoginErrorState(res.error));
        }

      }catch(e){}

    });

  }
}