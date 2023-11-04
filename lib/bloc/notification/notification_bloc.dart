import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/network/model/repository/base/auth/auth_repo.dart';
import '../../model/rider_notification_model.dart';

abstract class NotificationState {}

class NotificationInitialState extends NotificationState{}

class NotificationLoadingState extends NotificationState{}

class NotificationErrorState extends NotificationState{
  String ?error;
  NotificationErrorState(this.error);
}

class NotificationSuccessState extends NotificationState{
  RiderNotificationModel ? notificationModel;
  NotificationSuccessState(this.notificationModel);

}




abstract class NotificationEvent{}

class NotificationSubmitEvent extends NotificationEvent{

}



class NotificationBloc extends Bloc<NotificationEvent,NotificationState>{
  AuthRepository authRepository;

  NotificationBloc(this.authRepository):super(NotificationInitialState()){

    on<NotificationSubmitEvent>((event, emit) async {
      emit(NotificationLoadingState());
      try{
        var res = await authRepository.getRiderNotify();
        if(res.isSuccess){
          emit(NotificationSuccessState(res.data));
        }
        else{
          emit(NotificationErrorState(res.error));
        }

      }catch(e){}

    });

  }
}