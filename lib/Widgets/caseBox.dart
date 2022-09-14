


import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class CaseBox extends StatelessWidget{
  String description, title;
  int amount;
  CaseBox({this.description = "null", this.title = "null", this.amount = 0});
@override
Widget build(BuildContext context){
  return Column( 
          children: [ 
            const SizedBox(height: 10.0,),
            Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.orange[600],
             boxShadow: const [BoxShadow( color: Colors.grey, blurRadius: 10.0, offset: Offset(10, 0))],
            ),
            padding: const EdgeInsets.only(top: 20.0, bottom: 8.0,left: 15.0, right: 15.0),
            alignment: Alignment.center,
            height: 350,
            width: MediaQuery.of(context).size.width - 30,
            child: Column( 
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("Title: $title",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500,
            fontSize: 25.0),
            textAlign: TextAlign.left,
            ),
            //const SizedBox(height: 20.0,),
            Text("Description: $description",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500,
            fontSize: 20.0),
            textAlign: TextAlign.left,
            ),
            //const SizedBox(height: 25.0,),
            Text("Amount Required: Rs.$amount",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 18.0
            ),
            textAlign: TextAlign.center,
            ),
          ],
          )
          ),
          const SizedBox(height: 10.0,)
          ]
          );
      }
    }