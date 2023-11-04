import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/network/model/repository/base/auth/auth_repo.dart';
import '../../model/booking/ongong_booking_model.dart';
import '../../model/booking/pickup_booking_model.dart';

abstract class PickUpBookingState {}

class PickUpBookingInitialState extends PickUpBookingState{}

class PickUpBookingLoadingState extends PickUpBookingState{}

class PickUpBookingErrorState extends PickUpBookingState{
  String ?error;
  PickUpBookingErrorState(this.error);
}

class PickUpBookingSuccessState extends PickUpBookingState{
  PickUpBookingModel ? pickUpBookingModel;
  int ? index;
  PickUpBookingSuccessState(this.pickUpBookingModel,this.index);

}




abstract class PickUpBookingEvent{}

class PickUpBookingSubmitEvent extends PickUpBookingEvent{
  String ? bookId;
  int ? index;
  PickUpBookingSubmitEvent(this.bookId,this.index);
}



class PickUpBookingBloc extends Bloc<PickUpBookingEvent,PickUpBookingState>{
  AuthRepository authRepository;

  PickUpBookingBloc(this.authRepository):super(PickUpBookingInitialState()){

    on<PickUpBookingSubmitEvent>((event, emit) async {
      emit(PickUpBookingLoadingState());
      try{
        var res = await authRepository.bookingPickUp(bookId: event.bookId );
        if(res.isSuccess){
          emit(PickUpBookingSuccessState(res.data,event.index));
        }
        else{
          emit(PickUpBookingErrorState(res.error));
        }

      }catch(e){}

    });

  }
}