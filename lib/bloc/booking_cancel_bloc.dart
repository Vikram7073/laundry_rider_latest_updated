import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_rider/model/cancel_booking_model.dart';

import '../../api/network/model/repository/base/auth/auth_repo.dart';



abstract class BooingCancelState {}

class BooingCancelInitialState extends BooingCancelState{}

class BooingCancelLoadingState extends BooingCancelState{}

class BooingCancelErrorState extends BooingCancelState{
  String ?error;
  BooingCancelErrorState(this.error);
}

class BooingCancelSuccessState extends BooingCancelState{
  BookingCancelModel ? bookingCancelModel;
  BooingCancelSuccessState(this.bookingCancelModel);

}




abstract class BooingCancelEvent{}

class BooingCancelSubmitEvent extends BooingCancelEvent{
  String ? bookId;
  BooingCancelSubmitEvent(this.bookId);
}



class BooingCancelBloc extends Bloc<BooingCancelEvent,BooingCancelState>{
  AuthRepository authRepository;

  BooingCancelBloc(this.authRepository):super(BooingCancelInitialState()){

    on<BooingCancelSubmitEvent>((event, emit) async {
      emit(BooingCancelLoadingState());
      try{
        var res = await authRepository.bookingCanceled(bookId: event.bookId);
        if(res.isSuccess){
          emit(BooingCancelSuccessState(res.data));
        }
        else{
          emit(BooingCancelErrorState(res.error));
        }

      }catch(e){}

    });

  }
}