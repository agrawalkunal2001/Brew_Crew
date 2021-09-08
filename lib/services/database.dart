import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew_object.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {

  final String uid;
  DatabaseService({required this.uid});

  // Collection reference to firebase firestore database
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection("brews"); // Any name for a collection

  Future updateUserData (String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({ // Set function takes in a map of key value pairs
      'sugars': sugars,
      'name': name,
      'strength': strength
    }); // Linking user with firestore database using uid. If the document does not exist, a new document is created
  }

  // Brew list from snapshot
  List<BrewObject> _brewListFromSnapshot (QuerySnapshot snapshot){
    return snapshot.docs.map((document) {  // Map through a document of the snapshot
      return BrewObject(
        sugars: document.get('sugars') ?? "0", // Return an empty string if does not exist
        name: document.get('name') ?? "",
        strength: document.get('strength') ?? 0
      );
    }).toList(); // Converting to list because it returns an iterable
  }

  Stream<List<BrewObject>> get brew{  // Snapshot of firestore collection at that moment in time when something changes like addition of document etc.
    return brewCollection.snapshots().map((QuerySnapshot? snapshot) => _brewListFromSnapshot(snapshot!));
  }
}