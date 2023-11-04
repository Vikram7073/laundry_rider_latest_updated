import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/network/model/repository/base/auth/auth_repo.dart';
import '../../model/booking_page_model.dart';



abstract class BookingPageState {}

class BookingPageInitialState extends BookingPageState{}

class BookingPageLoadingState extends BookingPageState{}

class BookingPageErrorState extends BookingPageState{
  String ?error;
  BookingPageErrorState(this.error);
}

class BookingPageSuccessState extends BookingPageState{
  BookingPageModel ? bookingPageModel;
  BookingPageSuccessState(this.bookingPageModel);

}




abstract class BookingPageEvent{}

class BookingPageSubmitEvent extends BookingPageEvent{

}



class BookingPageBloc extends Bloc<BookingPageEvent,BookingPageState>{
  AuthRepository authRepository;

  BookingPageBloc(this.authRepository):super(BookingPageInitialState()){

    on<BookingPageSubmitEvent>((event, emit) async {
      emit(BookingPageLoadingState());
      try{
        var res = await authRepository.getBookingPage();
        if(res.isSuccess){
          emit(BookingPageSuccessState(res.data));
        }
        else{
          emit(BookingPageErrorState(res.error));
        }

      }catch(e){}

    });

  }
}