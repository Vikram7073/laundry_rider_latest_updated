import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/network/model/repository/base/auth/auth_repo.dart';
import '../model/bank_detail_model.dart';

abstract class BankDetailState {}

class BankDetailInitialState extends BankDetailState{}

class BankDetailLoadingState extends BankDetailState{}

class BankDetailErrorState extends BankDetailState{
  String ?error;
  BankDetailErrorState(this.error);
}

class BankDetailSuccessState extends BankDetailState{
  BankDetailAddModel ? bankDetailAddModel;
  BankDetailSuccessState(this.bankDetailAddModel);

}




abstract class BankDetailEvent{}

class BankDetailSubmitEvent extends BankDetailEvent{
  String ? account_holder_name,account_no,bank_name,ifsc_code;


  BankDetailSubmitEvent(this.account_holder_name,this.account_no,this.bank_name,this.ifsc_code);
}



class BankDetailBloc extends Bloc<BankDetailEvent,BankDetailState>{
  AuthRepository authRepository;

  BankDetailBloc(this.authRepository):super(BankDetailInitialState()){

    on<BankDetailSubmitEvent>((event, emit) async {
      emit(BankDetailLoadingState());
      try{
        var res = await authRepository.addBankDetail(account_holder_name: event.account_holder_name,account_no: event.account_no,
        bank_name: event.bank_name,ifsc_code: event.ifsc_code);
        if(res.isSuccess){
          emit(BankDetailSuccessState(res.data));
        }
        else{
          emit(BankDetailErrorState(res.error));
        }

      }catch(e){}

    });

  }
}