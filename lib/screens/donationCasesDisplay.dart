

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khidmat_app/Widgets/caseBox.dart';
import "package:khidmat_app/screens/completeDetails.dart";



class DonationCases extends StatefulWidget{ 
  String category = "x";
  String? id;
  DonationCases({Key ? key, this.category = "x", this.id}):super(key:key);
  
  _DonationCases createState() => _DonationCases(this.category, this.id);

}

class _DonationCases extends State<DonationCases>{

  String? id;
  String category;
  _DonationCases(this.category, this.id);
    
  @override
  Widget build(BuildContext context){
    final Stream<QuerySnapshot> users = FirebaseFirestore.instance.collection("projects").where('category', isEqualTo: category).snapshots();
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.orange[900]),
      body: StreamBuilder<QuerySnapshot>(stream: users, builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if (snapshot.hasError){
                    return const Text("Problem loading data");
                  }
                if (snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(color: Colors.orange[900],),
                    );
                  }
                final data = snapshot.requireData;
                if (data.size == 0){
                  return Padding( 
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                        child: Text("No cases available for this category at the moment", textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 30.0, color: Colors.orange[900])
                        ),
                        ));
                }
                return ListView.builder(
                  itemCount: data.size,
                  itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          //print(index);
                          Map<String,dynamic> caseDetails = {"Title":data.docs[index]["Title"],"Name":data.docs[index]["Person Name"],"Description":data.docs[index]["Long Description"],"Amount":data.docs[index]["Amount Required"], "Contact": data.docs[index]["Contact"]};
                          Navigator.push(context, MaterialPageRoute(builder: ((context) =>  CompleteDetailScreen(caseDetails, id)),),);
                        },
                        child: CaseBox(title:"${data.docs[index]["Title"]}", description:"${data.docs[index]["Description"]}", amount: data.docs[index]["Amount Required"],)
                        );
                      
      });
  }
)
);
}
}