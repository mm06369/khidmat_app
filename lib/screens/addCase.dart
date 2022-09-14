

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:khidmat_app/Widgets/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class addCase extends StatefulWidget{
  _addCase createState() => _addCase();
}

class _addCase extends State<addCase>{
  String? value;
  final TextEditingController _personNameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _shortDescriptionController = TextEditingController();
  final TextEditingController _longDescriptionController = TextEditingController();
  final TextEditingController _amountRequiredController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  final categoryOptions = ["Medical","Education","Religious Institution","Elderly","House","Food","Loan Repayment","Mosque"];

  void showToast(String message){
    Fluttertoast.showToast(msg: message, fontSize: 15, backgroundColor: Colors.grey, textColor: Colors.white, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
  }

  bool isFieldEmpty(String personName, String title, String description, String longDescription, String contact, String category, String amountRequired){
    if (personName.isEmpty || title.isEmpty || description.isEmpty || longDescription.isEmpty || contact.isEmpty || amountRequired.isEmpty){
      return true;
    }
    
    return false;
  }

  void addDataToFirestore(String personName, String title, String description, String longDescription, String contact, String? category, int amountRequired){
    try{
      final docUser = FirebaseFirestore.instance.collection("projects").doc();
      Map<String,dynamic> jsonFormatData = {
        "Amount Required" : amountRequired,
        "Contact" : contact,
        "Date Added" : DateTime.now(),
        "Description" : description,
        "Long Description": longDescription,
        "Person Name": personName,
        "Title" : title,
        "category": category
      };
      docUser.set(jsonFormatData);
      Fluttertoast.showToast(msg: "Case added succesfully!", backgroundColor: Colors.grey[800]);    
     } on FirebaseException catch(e){
        showToast(e.code);
     }
  }

  void clearController(){
    _personNameController.clear();
    _titleController.clear();
    _shortDescriptionController.clear();
    _longDescriptionController.clear();
    _contactController.clear();
    _amountRequiredController.clear();
    
  }

  @override
  Widget build(BuildContext context){

    DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(value: item,
      child: Text(item, 
      style: const TextStyle(fontSize: 20)
      ),
      );
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center, 
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: ListView(
        children: [
          const SizedBox(height: 10.0,),
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton( 
            onPressed:(){
              Navigator.of(context).pop();
            } ,
            icon: Icon(Icons.arrow_back_ios_new,
            size: 30,
            color: Colors.orange[900],
            
            ) 
          ,)),
          Container(
            alignment: Alignment.center,
              child: Text("Add a case", textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.orange[900],
                fontWeight: FontWeight.normal,
                fontSize: 30.0
          )
          )),
          const SizedBox(height: 25.0,),
          textField("Person Name", _personNameController),
          const SizedBox(height: 15.0,),
          textField("Contact",_contactController),
          const SizedBox(height: 15.0,),
          textField("Title", _titleController),
          const SizedBox(height: 15.0,),
          Container(
            height: 50,
            margin: EdgeInsets.only(left:2, right: 2),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width:1)
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                hint: Text("Categories",style: TextStyle(fontWeight: FontWeight.bold),),
                isExpanded: true,
                onChanged: ((value) => setState(() {
                  this.value = value;
                })),
                items: categoryOptions.map(buildMenuItem).toList(),
              ),
            )
          ),
          const SizedBox(height: 15.0,),
          TextFormField(
            minLines: 2,
            maxLines: 3,
            maxLength: 100,
            controller: _shortDescriptionController,
            decoration: const InputDecoration(
              labelText: "Short Description",
              labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange)
              ),
            ),
          ),
          const SizedBox(height: 15.0,),
          TextFormField(
            minLines: 8,
            maxLines: 15,
            maxLength: 500,
            controller: _longDescriptionController,
            decoration: const InputDecoration(
              labelText: "Long Description",
              labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange)
              ),
            ),
          ),
          const SizedBox(height: 15.0,),
          textField("Amount Required",_amountRequiredController),
          const SizedBox(height: 25.0,),
          SizedBox(
            height: 60.0,
            width: 280,
            child: ElevatedButton(
              onPressed: () async {
                addDataToFirestore(_personNameController.text, _titleController.text, _shortDescriptionController.text, _longDescriptionController.text, _contactController.text, value, int.parse(_amountRequiredController.text));
                clearController();
              },
              style: ButtonStyle(
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
               borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.orange[900]),
              ),
              child: const Text('Submit', 
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 25.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 7.0,),
        ],
      ))
      );
  }
}