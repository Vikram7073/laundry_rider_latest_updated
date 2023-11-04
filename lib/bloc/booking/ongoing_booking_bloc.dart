import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/network/model/repository/base/auth/auth_repo.dart';
import '../../model/booking/ongong_booking_model.dart';

abstract class OngoingBookingState {}

class OngoingBookingInitialState extends OngoingBookingState{}

class OngoingBookingLoadingState extends OngoingBookingState{}

class OngoingBookingErrorState extends OngoingBookingState{
  String ?error;
  OngoingBookingErrorState(this.error);
}

class OngoingBookingSuccessState extends OngoingBookingState{
  OngoingBookingModel ? ongoingBookingModel;
  int ? index;
  OngoingBookingSuccessState(this.ongoingBookingModel,this.index);

}




abstract class OngoingBookingEvent{}

class OngoingBookingSubmitEvent extends OngoingBookingEvent{
  String ? bookId;
  int ? index;
  OngoingBookingSubmitEvent(this.bookId,this.index);
}



class OngoingBookingBloc extends Bloc<OngoingBookingEvent,OngoingBookingState>{
  AuthRepository authRepository;

  OngoingBookingBloc(this.authRepository):super(OngoingBookingInitialState()){

    on<OngoingBookingSubmitEvent>((event, emit) async {
      emit(OngoingBookingLoadingState());
      try{
        var res = await authRepository.bookingOngoing(bookId: event.bookId );
        if(res.isSuccess){
          emit(OngoingBookingSuccessState(res.data,event.index));
        }
        else{
          emit(OngoingBookingErrorState(res.error));
        }

      }catch(e){}

    });

  }
}