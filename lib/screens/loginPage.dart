

import 'package:flutter/material.dart';
import 'SignUp.dart';
//import 'projectsScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:khidmat_app/Widgets/DialogBox.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dashboard.dart';

class LoginPage extends StatelessWidget{

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  
  void showToast(String message) => 
  Fluttertoast.showToast(msg: message, fontSize: 15, backgroundColor: Colors.grey, textColor: Colors.white, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);

  String errorMessageGenerator(String errorCode){
     if (errorCode == 'user-not-found')
      {
        return "User does not exists";
      }
     else if(errorCode == 'wrong-password')
      {
        return  "Password is incorrect";
      }
     else if(errorCode == 'invalid-email')
     {
        return "Email is incorrect";
     }
     else if(errorCode == "unknown")
     {
      return "Please enter email and password";
     }
     return "null";
  }




  @override
  Widget build(BuildContext context){

    // void DialogCreater(String text){
        
    //     openDialog() => showDialog(
    //     context: context, builder: (context){
    //       return DialogBox(text: text);
    //     }
    //   );
    //   openDialog();
    // }
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Fund me",
        style: TextStyle(color: Colors.orange[900], fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    backgroundColor: Colors.white,
      body: 
      Padding(padding: const EdgeInsets.only(left: 10.0, right: 10.0), 
      child: ListView(
        children: [
          SizedBox(height: 180.0,
          width: 200.0,
          child: Image.asset('assets/images/helpingHand.png'),),
          Text('HAPPINESS IS IN HELPING OTHERS',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue[900],
          ) ,
          ),
          const SizedBox(height: 20.0,),
          Text("Sign In", 
          style: TextStyle(fontSize: 30.0, color: Colors.orange[900]),
          textAlign: TextAlign.center,
          ),
          // sized box for space
          const SizedBox(height: 25.0,),
          //Container(
            //width: MediaQuery.of(context).size.width - 40,
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'abc@provider.com',
              hintStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.blue[600]),
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(color: Colors.orange)
              ),
              prefixIcon: Icon(Icons.email, color: Colors.orange[900],)
            ),
          ),
          //),
          const SizedBox(height: 15.0,),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(color: Colors.orange)
              ),
              prefixIcon: Icon(Icons.password, color: Colors.orange[900],)
            ),
          ),
          //sized box for space
          const SizedBox(height: 50.0,),
          SizedBox(
            height: 40.0,
            width: 320,
            child: ElevatedButton(
              onPressed: () async{
                    bool noError = true;
                    String errorMessage = 'NULL';
                    try {
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text
                          ).then((value) => {
                            Navigator.push(context, MaterialPageRoute(builder: ((context) =>  Dashboard(value.user?.uid)),),)
                          });
                          
                        } on FirebaseAuthException catch (e) {
                          noError = false;
                          //print(e.code);
                          errorMessage = errorMessageGenerator(e.code);
                        }
                        if (!noError){
                          Fluttertoast.showToast(msg: errorMessage, fontSize: 15, backgroundColor: Colors.grey, textColor: Colors.white, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
                          //DialogCreater(errorMessage);
                        }
                        _emailController.clear();
                        _passwordController.clear();
                        
                        },
              style: ButtonStyle(
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
               borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.orange[900]),
              ),
              child: const Text('Login', 
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0,
                ),
              ),
            ),
          ),
          //sized box for space
          const SizedBox(height: 25.0,),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: ((context) =>  SignUp()
                ),
              )
            );
          }, 
          child: Text("Don't have an account? Sign Up", style: TextStyle(color: Colors.orange[900], fontSize: 14.0),), 
          ),
        ],
      ),
      ),
    );
  }
}
