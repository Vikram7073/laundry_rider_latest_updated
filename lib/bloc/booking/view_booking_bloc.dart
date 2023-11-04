import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/network/model/repository/base/auth/auth_repo.dart';
import '../../model/booking/ongong_booking_model.dart';
import '../../model/booking/pickup_booking_model.dart';
import '../../model/booking/view_booking_model.dart';

abstract class ViewBookingState {}

class ViewBookingInitialState extends ViewBookingState{}

class ViewBookingLoadingState extends ViewBookingState{}

class ViewBookingErrorState extends ViewBookingState{
  String ?error;
  ViewBookingErrorState(this.error);
}

class ViewBookingSuccessState extends ViewBookingState{
  ViewBookingModel ? viewBookingModel;
  int ? index;
  ViewBookingSuccessState(this.viewBookingModel,);

}




abstract class ViewBookingEvent{}

class ViewBookingSubmitEvent extends ViewBookingEvent{
  int ? bookId;
  int ? index;
  ViewBookingSubmitEvent(this.bookId);
}



class ViewBookingBloc extends Bloc<ViewBookingEvent,ViewBookingState>{
  AuthRepository authRepository;

  ViewBookingBloc(this.authRepository):super(ViewBookingInitialState()){

    on<ViewBookingSubmitEvent>((event, emit) async {
      emit(ViewBookingLoadingState());
      try{
        var res = await authRepository.bookingView(bookId: event.bookId);
        if(res.isSuccess){
          emit(ViewBookingSuccessState(res.data));
        }
        else{
          emit(ViewBookingErrorState(res.error));
        }

      }catch(e){}

    });

  }
}