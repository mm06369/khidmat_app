
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget{
  DialogBox({this.text = "X"});
  String text;
  @override
  Widget build(BuildContext context){
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),
     ),
     child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
    ),
      alignment: Alignment.center,
      height: 200.0,
      width: MediaQuery.of(context).size.width - 30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
      children: [
        const SizedBox(height: 30.0,),
      Text(text,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w400,
        color: Colors.orange[900],
      ),
      textAlign: TextAlign.center,
      ),
      const SizedBox(height: 60.0,),
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text('Close',
        style: TextStyle(
          color: Colors.blue[700],
          fontWeight: FontWeight.w400,
          fontSize: 20.0,
        ), 
        )
      ),
      ],
     ),
     ),
    );
  }
}
