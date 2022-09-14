

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:khidmat_app/Widgets/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatelessWidget{
  SignUp({Key? key}):super(key:key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  void showToast(String message){
    Fluttertoast.showToast(msg: message, fontSize: 15, backgroundColor: Colors.grey, textColor: Colors.white, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
  }

  bool isFieldEmpty(String fname, String lname, String email, String password, String age){
    if (fname.isEmpty || lname.isEmpty || email.isEmpty || password.isEmpty || age.isEmpty){
      return true;
    }
    
    return false;
  }

  bool passwordCompare(String password, String confirmPassword){
    if (password == confirmPassword){
      return true;
    }
    return false;
  }

  void createUserAccountAuth(String firstName, String lastName, int age, String email, String password){
     final auth = FirebaseAuth.instance;
     try{
     auth.createUserWithEmailAndPassword(email: email, password: password).then((value){
      final docUser = FirebaseFirestore.instance.collection("users").doc(value.user?.uid);
      Map<String,dynamic> jsonFormatData = {
      "First Name" : firstName,
      "Last Name" : lastName,
      "Age" : age,
      "Email" : email,
      "Amount Donated": 0                  };
    docUser.set(jsonFormatData);
     });
     showToast("User account created");
     } on FirebaseAuthException catch (e){
      showToast(e.code);
     }
  }

  // void addDataToFirestore(String firstName, String lastName, int age, String email){
  //   try{
  //   final docUser = FirebaseFirestore.instance.collection("users").doc();
  //   Map<String,dynamic> jsonFormatData = {
  //     "First Name" : firstName,
  //     "Last Name" : lastName,
  //     "Age" : age,
  //     "Email" : email,
  //     "Amount Donated": 0
  //   };
  //   docUser.set(jsonFormatData);
    
  //   } on FirebaseException catch(e){
  //     showToast(e.code);
  //   }
  // }

  void clearController(){
    _emailController.clear();
    _passwordController.clear();
    _passwordConfirmController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _ageController.clear();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center, 
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: ListView(
        children: [
          const SizedBox(height: 20.0,),
          Container(
            alignment: Alignment.center,
              child: Text("Sign Up", textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.orange[900],
                fontWeight: FontWeight.normal,
                fontSize: 30.0
          )
          )),
          const SizedBox(height: 25.0,),
          textField("First Name", _firstNameController),
          const SizedBox(height: 15.0,),
          textField("Last Name", _lastNameController),
          const SizedBox(height: 15.0,),
          textField("Age", _ageController),
          const SizedBox(height: 15.0,),
          textField("Email", _emailController),
          const SizedBox(height: 15.0,),
          textField("Password", _passwordController),
          const SizedBox(height: 15.0,),
          textField("Confirm Password",_passwordConfirmController),
          const SizedBox(height: 25.0,),
          SizedBox(
            height: 60.0,
            width: 280,
            child: ElevatedButton(
              onPressed: () async {
                if (!passwordCompare(_passwordController.text, _passwordConfirmController.text)){
                  showToast("Passwords do not match");
                }
                else if(isFieldEmpty(_firstNameController.text, _lastNameController.text, _emailController.text, _passwordController.text,_ageController.text)){
                  showToast("Fill all the fields");
                } 
                else { 
                createUserAccountAuth(_firstNameController.text, _lastNameController.text, int.parse(_ageController.text),_emailController.text, _passwordController.text);
                //addDataToFirestore(_firstNameController.text, _lastNameController.text, int.parse(_ageController.text), _emailController.text);
                clearController();
                }
              },
              style: ButtonStyle(
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
               borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.orange[900]),
              ),
              child: const Text('Create Account', 
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 25.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 7.0,),
          TextButton(onPressed: (){Navigator.of(context).pop();}, 
          child: Text("Already have an account? Sign in", style: TextStyle(color: Colors.blue[900], fontSize: 18.0),), 
          ),
        ],
      ))
      );
  }
}