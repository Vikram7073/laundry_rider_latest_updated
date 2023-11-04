import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_rider/common/constant/shimmer/list_shimmer_effect.dart';
import '../bloc/contact_term_bloc.dart';
import '../common/custom_widget/custom_appbar.dart';
import '../model/contact_term_model.dart';
class TermConditionScreen extends StatefulWidget {
  String ? type;
   TermConditionScreen({super.key,this.type});

  @override
  State<TermConditionScreen> createState() => _TermConditionScreenState();
}

class _TermConditionScreenState extends State<TermConditionScreen> {
  ContactTermPrivacyModel ? contactTermPrivacyModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ContactTermBloc>(context).add(ContactTermSubmitEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(45.h), child: CustomAppBar(
        title: Text(widget.type=="Term"?"Term & Condition":"Privacy Policy"),
      )),

      body: BlocConsumer<ContactTermBloc,ContactTermState>(
        listener: (context,state){
          if(state is ContactTermSuccessState){
            contactTermPrivacyModel=state.contactTermPrivacyModel;
          }
        },
          builder: (context,state){
          return  contactTermPrivacyModel!=null?
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.type=="Term" ? Html(data: contactTermPrivacyModel?.data?.terms??''):
                Html(data:contactTermPrivacyModel?.data?.policy.toString()??"",),
              ),
            ):
          const ListShimmer();
          },
          ),
    );
  }
}
