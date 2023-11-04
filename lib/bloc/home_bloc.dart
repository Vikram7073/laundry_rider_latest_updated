import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/network/model/repository/base/auth/auth_repo.dart';
import '../model/get_profile_model.dart';
import '../model/home_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState{}

class HomeLoadingState extends HomeState{}

class HomeErrorState extends HomeState{
  String ?error;
  HomeErrorState(this.error);
}

class HomeSuccessState extends HomeState{
  HomeModel ? homeModel;
  HomeSuccessState(this.homeModel);

}




abstract class HomeEvent{}

class HomeSubmitEvent extends HomeEvent{

}



class HomeBloc extends Bloc<HomeEvent,HomeState>{
  AuthRepository authRepository;

  HomeBloc(this.authRepository):super(HomeInitialState()){

    on<HomeSubmitEvent>((event, emit) async {
      emit(HomeLoadingState());
      try{
        var res = await authRepository.GetHome();
        if(res.isSuccess){
          emit(HomeSuccessState(res.data));
        }
        else{
          emit(HomeErrorState(res.error));
        }

      }catch(e){}

    });

  }
}