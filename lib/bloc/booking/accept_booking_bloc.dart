import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/network/model/repository/base/auth/auth_repo.dart';
import '../../model/booking/accept_booking_model.dart';

abstract class AcceptBookingState {}

class AcceptBookingInitialState extends AcceptBookingState{}

class AcceptBookingLoadingState extends AcceptBookingState{}

class AcceptBookingErrorState extends AcceptBookingState{
  String ?error;
  AcceptBookingErrorState(this.error);
}

class AcceptBookingSuccessState extends AcceptBookingState{
  AcceptBookingModel ? acceptBookingModel;
  int ? index;
  AcceptBookingSuccessState(this.acceptBookingModel,this.index);

}




abstract class AcceptBookingEvent{}

class AcceptBookingSubmitEvent extends AcceptBookingEvent{
  String ? bookId;
  int ? index;
  AcceptBookingSubmitEvent(this.bookId,this.index);
}



class AcceptBookingBloc extends Bloc<AcceptBookingEvent,AcceptBookingState>{
  AuthRepository authRepository;

  AcceptBookingBloc(this.authRepository):super(AcceptBookingInitialState()){

    on<AcceptBookingSubmitEvent>((event, emit) async {
      emit(AcceptBookingLoadingState());
      try{
        var res = await authRepository.bookingAccept(bookId: event.bookId );
        if(res.isSuccess){
          emit(AcceptBookingSuccessState(res.data,event.index));
        }
        else{
          emit(AcceptBookingErrorState(res.error));
        }

      }catch(e){}

    });

  }
}