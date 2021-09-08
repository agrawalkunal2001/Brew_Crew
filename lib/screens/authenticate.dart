import 'package:brew_crew/screens/register.dart';
import 'package:brew_crew/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Authenticate extends StatefulWidget {

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView(){
    setState(() {
      showSignIn = !showSignIn; // Reverses the value of showSignIn
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(changeView: toggleView); // Passing the function as parameter as the function is not available in Register or SignIn widgets
    }
    else{
      return Register(changeView: toggleView); // Passing the function as parameter as the function is not available in Register or SignIn widgets
    }
  }
}
