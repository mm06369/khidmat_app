
import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';

class textField extends StatelessWidget{
  String label = "null";
  TextEditingController controller;
  textField(String labelvalue, this.controller){
    label = labelvalue;
    controller = controller;
  }
@override
Widget build(BuildContext context){
  return TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange)
              ),
            ),
          );
}
}