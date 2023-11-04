import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/network/model/repository/base/auth/auth_repo.dart';
import '../model/get_profile_model.dart';

abstract class GetProfileState {}

class GetProfileInitialState extends GetProfileState{}

class GetProfileLoadingState extends GetProfileState{}

class GetProfileErrorState extends GetProfileState{
  String ?error;
  GetProfileErrorState(this.error);
}

class GetProfileSuccessState extends GetProfileState{
  GetProfileModel ? getProfileModel;
  GetProfileSuccessState(this.getProfileModel);

}




abstract class GetProfileEvent{}

class GetProfileSubmitEvent extends GetProfileEvent{

}



class GetProfileBloc extends Bloc<GetProfileEvent,GetProfileState>{
  AuthRepository authRepository;

  GetProfileBloc(this.authRepository):super(GetProfileInitialState()){

    on<GetProfileSubmitEvent>((event, emit) async {
      emit(GetProfileLoadingState());
      try{
        var res = await authRepository.GetProfile();
        if(res.isSuccess){
          emit(GetProfileSuccessState(res.data));
        }
        else{
          emit(GetProfileErrorState(res.error));
        }

      }catch(e){}

    });

  }
}