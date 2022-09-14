

import 'package:flutter/material.dart';

class Square extends StatelessWidget{
  const Square({Key ? key}):super(key:key);
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height:200.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          color: Colors.orange[300],
        ),
      ),
    );
  }
}