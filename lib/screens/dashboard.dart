

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:khidmat_app/screens/projectsScreen.dart';
import 'package:khidmat_app/screens/addCase.dart';

class Dashboard extends StatefulWidget{
  String? id;
  Dashboard(this.id);
  String? personName;
  
  _Dashboard createState() => _Dashboard(id);
}
class _Dashboard extends State<Dashboard>{
  
  _Dashboard(this.id){
  }
  String? id;
  late bool isloading;
  String? personName;
  Map<String,dynamic>? data = {};

  createAlertDialog(){
    return showDialog(context: context,
    barrierDismissible: false, 
    builder: (context){
      return AlertDialog(
        
        title: const Text("Do you want to logout?"),
        actions: [
          MaterialButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: const Text("Yes"),
          ),
          MaterialButton(onPressed: (){
            Navigator.of(context).pop(); 
          },
          child: const Text("No"),
          )
        ],
      );
    }
    );
  }



@override
void initState(){
  isloading = true;
  getData();
  Future.delayed(const Duration(seconds: 1),(){
    setState(() {
      isloading = false;
    });
  });
  super.initState();
}

  void getData(){
    FirebaseFirestore.instance.collection("users").doc(id).get().then((value){
    data = value.data();
    personName = data?["First Name"] + "" + data?["Last Name"];
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        actions: [
          IconButton(onPressed: (){
            createAlertDialog();
          }, icon: const Icon(Icons.logout))
        ],
      ),
      body: isloading?
      Center(
        child: CircularProgressIndicator(color: Colors.orange[900],),
      ): 
      Container( 
        padding: const EdgeInsets.only(left: 15.0, right: 10.0),
      child: ListView(
        children: [
          const SizedBox(height: 10.0,),
          //Text("Hello $personName,", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500, color: Colors.orange[900]),),
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.orange[900]),
              children: [
                TextSpan(text: "Hello ",style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300, color: Colors.blue[900])),
                TextSpan(text: "$personName", style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w300)),
              ]
            ) 
          ),
          const SizedBox(height: 30.0,),
          Container(
            height: 100.0,
            width: MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(children: [
              Container(
                padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                alignment: Alignment.topLeft,
                child: const Text("Amount Donated", textAlign: TextAlign.left, style: TextStyle(fontSize: 28.0, color: Colors.white, fontWeight: FontWeight.bold),)),
                //const SizedBox(height: 5.0,),
                Container(
                padding: const EdgeInsets.only(right: 20.0, top: 20.0),
                alignment: Alignment.bottomRight,
                child:  Text("Rs. ${data?["Amount Donated"]}", textAlign: TextAlign.left, style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500, color: Colors.orange[900]),),
              //StreamBuilder(
              //  stream: FirebaseFirestore.instance.collection("users").doc(id).snapshots(),
              //  builder: (context,snapshot){
              //    if (!snapshot.hasData) {
              //        return const Center(child: Text("Loading"));
              //    }
                    //final userDocument = snapshot.requireData;
                    //return ListView.builder(
                    //  itemCount: 1,
                    //  itemBuilder: (context, index){
                    //    return  Text("Rs. ${userDocument?.docs[index]["Amount Donated"]}", textAlign: TextAlign.left, style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500, color: Colors.orange[900]),);
                    //  },
                    //);
               //   },
              // )
                ),
                
            ]),
          ),
          const SizedBox(height: 30.0,),
          SizedBox(
            height: 100.0,
            width: MediaQuery.of(context).size.width - 30, 
            child: ElevatedButton( 
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: ((context) =>  addCase()),),);
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
               borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),  
                backgroundColor: MaterialStateProperty.all(Colors.purpleAccent),
            ),
            child: Container(
              alignment: Alignment.center,
              child: const Text("Add a donation case", 
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
            ),),
            const SizedBox(height: 30.0,),
            SizedBox(
            height: 100.0,
            width: MediaQuery.of(context).size.width - 30, 
            child: ElevatedButton( 
            onPressed: (){},
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
               borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),  
                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
            ),
            child: Container(
              alignment: Alignment.center,
              child: const Text("Manage payment methods", 
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
            ),),
            const SizedBox(height: 30.0,),
            SizedBox(
            height: 100.0,
            width: MediaQuery.of(context).size.width - 30, 
            child: ElevatedButton( 
            onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: ((context) =>  ProjectScreen(id:id)),),);
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
               borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),  
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
            ),
            child: Container(
              alignment: Alignment.center,
              child: const Text("Donate Now", 
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
            ),),


        ]),
    ));
  }  
  }

  // Text("Rs. ${data?["Amount Donated"]}", textAlign: TextAlign.left, style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500, color: Colors.orange[900]),)