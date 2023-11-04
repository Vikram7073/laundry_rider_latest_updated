import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/network/model/repository/base/auth/auth_repo.dart';
import '../../model/wallet/wallet_request_model.dart';


abstract class WalletRequestState {}

class WalletRequestInitialState extends WalletRequestState{}

class WalletRequestLoadingState extends WalletRequestState{}

class WalletRequestErrorState extends WalletRequestState{
  String ?error;
  WalletRequestErrorState(this.error);
}

class WalletRequestSuccessState extends WalletRequestState{
  WalletRequestModel ? walletRequestModel;
  WalletRequestSuccessState(this.walletRequestModel);

}




abstract class WalletRequestEvent{}

class WalletRequestSubmitEvent extends WalletRequestEvent{
  String ? amount;
  WalletRequestSubmitEvent(this.amount);
}



class WalletRequestBloc extends Bloc<WalletRequestEvent,WalletRequestState>{
  AuthRepository authRepository;

  WalletRequestBloc(this.authRepository):super(WalletRequestInitialState()){

    on<WalletRequestSubmitEvent>((event, emit) async {
      emit(WalletRequestLoadingState());
      try{
        var res = await authRepository.walletRequests(amount: event.amount );
        if(res.isSuccess){
          emit(WalletRequestSuccessState(res.data));
        }
        else{
          emit(WalletRequestErrorState(res.error));
        }

      }catch(e){}

    });

  }
}