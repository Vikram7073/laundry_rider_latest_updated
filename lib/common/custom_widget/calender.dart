import 'package:flutter/material.dart';

import '../constant/color_constants.dart';
class Calender extends StatefulWidget {
  DateTime ? picked;

   Calender({Key? key,this.picked}) : super(key: key);

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime selectedDate = DateTime(2020, 1, 1);
  DateTime ? picked;
  @override
  Widget build(BuildContext context) {
    return _selectDate(context);
  }
  _selectDate(BuildContext context) async {
    picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme:  const ColorScheme.light(
              primary: ColorConstants.blueLightColor,
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked!;
      });
    }
  }
}
