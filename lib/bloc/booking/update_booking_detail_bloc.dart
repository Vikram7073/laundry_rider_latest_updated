import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/network/model/repository/base/auth/auth_repo.dart';
import '../../model/booking/update_booking_detail_model.dart';



abstract class UpdateBookingDetailState {}

class UpdateBookingDetailInitialState extends UpdateBookingDetailState{}

class UpdateBookingDetailLoadingState extends UpdateBookingDetailState{}

class UpdateBookingDetailErrorState extends UpdateBookingDetailState{
  String ?error;
  UpdateBookingDetailErrorState(this.error);
}

class UpdateBookingDetailSuccessState extends UpdateBookingDetailState{
  UpdateBookingDetailModel ? updateBookingDetailModel;
  UpdateBookingDetailSuccessState(this.updateBookingDetailModel);

}




abstract class UpdateBookingDetailEvent{}

class UpdateBookingDetailSubmitEvent extends UpdateBookingDetailEvent{
  int? bookId;
  List ? weight,quantity;



  UpdateBookingDetailSubmitEvent(this.bookId,this.quantity,this.weight);
}



class UpdateBookingDetailBloc extends Bloc<UpdateBookingDetailEvent,UpdateBookingDetailState>{
  AuthRepository authRepository;

  UpdateBookingDetailBloc(this.authRepository):super(UpdateBookingDetailInitialState()){

    on<UpdateBookingDetailSubmitEvent>((event, emit) async {
      emit(UpdateBookingDetailLoadingState());
      try{
        var res = await authRepository.updateBookingDetail(bookId: event.bookId,qty: event.quantity,weight: event.weight);
        if(res.isSuccess){
          emit(UpdateBookingDetailSuccessState(res.data));
        }
        else{
          emit(UpdateBookingDetailErrorState(res.error));
        }

      }catch(e){}

    });

  }
}