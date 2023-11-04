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
  List ? itemId,itemQty;
  String ? note;


  UpdateBookingDetailSubmitEvent(this.bookId,this.itemId,this.itemQty,this.note);
}



class UpdateBookingDetailBloc extends Bloc<UpdateBookingDetailEvent,UpdateBookingDetailState>{
  AuthRepository authRepository;

  UpdateBookingDetailBloc(this.authRepository):super(UpdateBookingDetailInitialState()){

    on<UpdateBookingDetailSubmitEvent>((event, emit) async {
      emit(UpdateBookingDetailLoadingState());
      try{
        var res = await authRepository.updateBookingDetail(bookId: event.bookId,itemId: event.itemId,itemQty: event.itemQty,note: event.note);
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