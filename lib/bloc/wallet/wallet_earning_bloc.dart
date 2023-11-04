import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/network/model/repository/base/auth/auth_repo.dart';
import '../../model/wallet/wallet_model.dart';



abstract class WalletEarningState {}

class WalletEarningInitialState extends WalletEarningState{}

class WalletEarningLoadingState extends WalletEarningState{}

class WalletEarningErrorState extends WalletEarningState{
  String ?error;
  WalletEarningErrorState(this.error);
}

class WalletEarningSuccessState extends WalletEarningState{
  WalletEarningModel ? walletEarningModel;
  WalletEarningSuccessState(this.walletEarningModel);

}




abstract class WalletEarningEvent{}

class WalletEarningSubmitEvent extends WalletEarningEvent{

}



class WalletEarningBloc extends Bloc<WalletEarningEvent,WalletEarningState>{
  AuthRepository authRepository;

  WalletEarningBloc(this.authRepository):super(WalletEarningInitialState()){

    on<WalletEarningSubmitEvent>((event, emit) async {
      emit(WalletEarningLoadingState());
      try{
        var res = await authRepository.getWalletEarning();
        if(res.isSuccess){
          emit(WalletEarningSuccessState(res.data));
        }
        else{
          emit(WalletEarningErrorState(res.error));
        }
      }catch(e){}

    });

  }
}