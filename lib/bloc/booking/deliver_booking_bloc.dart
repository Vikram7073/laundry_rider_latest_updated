import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/network/model/repository/base/auth/auth_repo.dart';
import '../../model/booking/deliver_booking_model.dart';

abstract class DeliverBookingState {}

class DeliverBookingInitialState extends DeliverBookingState{}

class DeliverBookingLoadingState extends DeliverBookingState{}

class DeliverBookingErrorState extends DeliverBookingState{
  String ?error;
  DeliverBookingErrorState(this.error);
}

class DeliverBookingSuccessState extends DeliverBookingState{
  DeliverBookingModel ? deliverBookingModel;
  int ? index;
  DeliverBookingSuccessState(this.deliverBookingModel,this.index);

}




abstract class DeliverBookingEvent{}

class DeliverBookingSubmitEvent extends DeliverBookingEvent{
  String ? bookId;
  int ? index;
  DeliverBookingSubmitEvent(this.bookId,this.index);
}



class DeliverBookingBloc extends Bloc<DeliverBookingEvent,DeliverBookingState>{
  AuthRepository authRepository;

  DeliverBookingBloc(this.authRepository):super(DeliverBookingInitialState()){

    on<DeliverBookingSubmitEvent>((event, emit) async {
      emit(DeliverBookingLoadingState());
      try{
        var res = await authRepository.bookingDeliver(bookId: event.bookId );
        if(res.isSuccess){
          emit(DeliverBookingSuccessState(res.data,event.index));
        }
        else{
          emit(DeliverBookingErrorState(res.error));
        }

      }catch(e){}

    });

  }
}