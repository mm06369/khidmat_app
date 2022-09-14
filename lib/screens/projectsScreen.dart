import 'package:flutter/material.dart';
import 'donationCasesDisplay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectScreen extends StatefulWidget {
  ProjectScreen({Key? key, this.id}) : super(key: key);
  String? id;
  @override
  _ProjectScreen createState() => _ProjectScreen(id);

}

class _ProjectScreen extends State<ProjectScreen> {
  String? id;
  _ProjectScreen(this.id);
  Map<int,dynamic> indexCategory = {0:"Education", 1:"Medical",2:"House",3:"Food",4:"Elderly",5:"Loan Repayment",6:"Mosque",7:"Religious Institution"}; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0)),
        backgroundColor: Colors.orange[900],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(top:15.0) ,
                itemCount: indexCategory.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {

                      },
                      child: Card(
                        child: ListTile(
                          title: Text(indexCategory[index].toString(), style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25.0, letterSpacing: 2.0)),
                          onTap: (){    
                            String categoryName = indexCategory[index];
                            Navigator.push(context,MaterialPageRoute(builder: ((context) => DonationCases(category:categoryName, id:id)),));
                          },
                          trailing: const SizedBox(
                            height: 100.0,
                            width: 70.0,
                            child: Center(
                              child: Icon(Icons.arrow_forward_ios_sharp),
                            ),
                          ),
                        ),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
