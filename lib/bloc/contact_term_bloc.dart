import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/network/model/repository/base/auth/auth_repo.dart';
import '../model/contact_term_model.dart';
import '../model/get_profile_model.dart';

abstract class ContactTermState {}

class ContactTermInitialState extends ContactTermState{}

class ContactTermLoadingState extends ContactTermState{}

class ContactTermErrorState extends ContactTermState{
  String ?error;
  ContactTermErrorState(this.error);
}

class ContactTermSuccessState extends ContactTermState{
  ContactTermPrivacyModel ? contactTermPrivacyModel;
  ContactTermSuccessState(this.contactTermPrivacyModel);

}




abstract class ContactTermEvent{}

class ContactTermSubmitEvent extends ContactTermEvent{

}



class ContactTermBloc extends Bloc<ContactTermEvent,ContactTermState>{
  AuthRepository authRepository;

  ContactTermBloc(this.authRepository):super(ContactTermInitialState()){

    on<ContactTermSubmitEvent>((event, emit) async {
      emit(ContactTermLoadingState());
      try{
        var res = await authRepository.getContactTerm();
        if(res.isSuccess){
          emit(ContactTermSuccessState(res.data));
        }
        else{
          emit(ContactTermErrorState(res.error));
        }
      }catch(e){}

    });

  }
}