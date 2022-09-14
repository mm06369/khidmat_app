

import 'package:cloud_firestore/cloud_firestore.dart';



class DatabaseManager {
  
  final CollectionReference profileList = FirebaseFirestore.instance.collection('projects');

  Future<void> createUserData(
      String title, String category, int amountRequired, String description, String uid) async {
        return await profileList.doc(uid).set({'Title': title, 'Category': category, 'Amount Required': amountRequired, 'Description': description});
  }

  Future updateUserList(String title, String category, int amountRequired, String description, String uid) async {
    return await profileList.doc(uid).update({'Title': title, 'Category':category, 'Amount Required': amountRequired, 'Description': description});
  }

  Future getUsersList() async {
    List itemsList = [];

    try {
      await profileList.get().then((querySnapshot){
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
          });
        });
        //print(itemsList);
        return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
