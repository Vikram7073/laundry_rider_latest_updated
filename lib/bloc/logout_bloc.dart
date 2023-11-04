import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/network/model/repository/base/auth/auth_repo.dart';
import '../model/get_profile_model.dart';
import '../model/logout_model.dart';

abstract class LogOutState {}

class LogOutInitialState extends LogOutState{}

class LogOutLoadingState extends LogOutState{}

class LogOutErrorState extends LogOutState{
  String ?error;
  LogOutErrorState(this.error);
}

class LogOutSuccessState extends LogOutState{
  LogOutModel ? logOutModel;
  LogOutSuccessState(this.logOutModel);

}




abstract class LogOutEvent{}

class LogOutSubmitEvent extends LogOutEvent{

}



class LogOutBloc extends Bloc<LogOutEvent,LogOutState>{
  AuthRepository authRepository;

  LogOutBloc(this.authRepository):super(LogOutInitialState()){

    on<LogOutSubmitEvent>((event, emit) async {
      emit(LogOutLoadingState());
      try{
        var res = await authRepository.GetLogOut();
        if(res.isSuccess){
          emit(LogOutSuccessState(res.data));
        }
        else{
          emit(LogOutErrorState(res.error));
        }

      }catch(e){}

    });

  }
}