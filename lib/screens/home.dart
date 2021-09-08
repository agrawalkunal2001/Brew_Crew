import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/screens/brew_list.dart';
import 'package:brew_crew/models/brew_object.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService(); // Instance of AuthService class from auth.dart to access signOut method

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<BrewObject?>?>.value( // Wrap a widget tree with a provider to listen to auth changes from stream
      value: DatabaseService(uid: "").brew, // .brew means the name of stream in auth.dart
      initialData: null,
      catchError: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          actions: <Widget>[ // List of widgets that will appear in app bar
            FlatButton.icon(
              icon: Icon(Icons.person),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                return await _auth.signOut();
              },
              label: Text("Log out"),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
