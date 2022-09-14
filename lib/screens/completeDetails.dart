



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CompleteDetailScreen extends StatelessWidget{
CompleteDetailScreen(this.caseDetails, this.id);

  void incrementAmount(int amount){
    final docUser = FirebaseFirestore.instance.collection("users").doc(id);
    docUser.get().then((value){
    Map<String,dynamic>? data = value.data();
    int amountDonated = data?["Amount Donated"];
    amountDonated += amount;
    docUser.update({
      "Amount Donated": amountDonated
    });
    });
    Fluttertoast.showToast(msg: "Amount Donated Succesfully!", backgroundColor: Colors.grey[700]);
    amountController.text = "";
  }

final TextEditingController amountController = TextEditingController();
String? id;
Map<String,dynamic> caseDetails = {"Title":"null","Name":"null","Description":"null","Amount":0, "Contact": "null"};

@override
Widget build(BuildContext context){
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.orange[900],
      elevation: 10.0,
    ),
    body: ListView(
      padding: EdgeInsets.all(10.0),
      children: [
        const SizedBox(height: 35.0,),
        const Text("Title", textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
        ),
        const SizedBox(height: 20.0,),
        Container(
          height: 80,
          //width: 5,
          decoration: BoxDecoration(
            color: Colors.orange[400],
            borderRadius: BorderRadius.circular(10)
          ),
          alignment: Alignment.center,
          child: Text(caseDetails['Title'],
          style: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.normal,
          )
          ),
        ),
        const SizedBox(height: 40.0,),
        const Text("Description", textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
        ),
        const SizedBox(height: 20.0,),
        Container(
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.orange[400],
            borderRadius: BorderRadius.circular(10)
          ),
          child: Text(caseDetails['Description'],
          textAlign: TextAlign.justify,
          style:const TextStyle(
            height: 1.5,
            fontSize: 25.0,
            fontWeight: FontWeight.normal,
          )
          ),
        ),
        const SizedBox(height: 35.0,),

          const Text("Contact Details",
          style:TextStyle(fontSize: 25, fontWeight: FontWeight.bold) ,
          ),
        const SizedBox(height: 20.0,),
        Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
            color: Colors.orange[400],
            borderRadius: BorderRadius.circular(10)
          ),
          //alignment: Alignment.center,
          child: Column( 
          children: [
            const SizedBox(height: 20.0,),
            Text("Person Name: ${caseDetails['Name']}",
          style:const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.normal,
          )
          ),
          const SizedBox(height: 20.0,),
          Text("Contact: ${caseDetails['Contact']}",
          style:const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.normal,
          )
          ),
          const SizedBox(height: 20.0,)
          ],
          ),),
        const SizedBox(height: 50.0,),
        Container(
          height: 80.0,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
           decoration: BoxDecoration(
            color: Colors.orange[400],
            borderRadius: BorderRadius.circular(10)
          ),
          //alignment: Alignment.center,
          child: Text("Amount Required: Rs.${caseDetails['Amount']}",
          style:const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.normal,
          )
          ),
        ),
      const SizedBox(height: 30.0,),
      Container(
        padding: EdgeInsets.only(left:15.0, right: 15.0),
        child: TextField(
          controller: amountController,
            decoration: const InputDecoration(
            hintText: 'Amount'
            ),),
      ),
      const SizedBox(height: 20.0,),
      Container(
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0)
        ),
        //alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: (){
            if (amountController.text == ""){
              Fluttertoast.showToast(msg: "Enter any amount", backgroundColor: Colors.grey[900]);
            } 
          else{
          incrementAmount(int.parse(amountController.text));
          }
        }, 
        child: const Text("Donate",
        style: TextStyle(
          fontSize: 25.0,

        ),),
        style: ButtonStyle(
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
               borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.orange[900]),
              ),
        ),
      ),
      const SizedBox(height: 20.0,)
      ],

    ),
  );
}
}