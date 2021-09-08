import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:brew_crew/shared/loading.dart';

class Register extends StatefulWidget {

  final Function changeView;
  Register({required this.changeView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService(); // Instance of AuthService class from auth.dart to access signInAnon method
  final _formkey = GlobalKey<FormState>(); // Key used to identify the form and associate with the global key
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[600],
        title: Text("Sign Up to Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign In"),
            onPressed: (){
              widget.changeView();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: formInputDecoration.copyWith(hintText: "Enter email"),
                validator: (val) => val!.isEmpty ? "Enter an email" : null, // Property for a valid email
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: formInputDecoration.copyWith(hintText: "Enter password"),
                  validator: (val) => val!.length < 6 ? "Enter a password of minimum 6 characters" : null, // Property for a valid password
                  obscureText: true, // to hide password
                  onChanged: (val){
                    setState(() {
                      password = val;
                    });
                  }
              ),
              SizedBox(height: 20.0),
              Text("Already have an account? Sign in to Brew Crew", style: TextStyle(fontSize: 13.5)),
              SizedBox(height: 40.0),
              RaisedButton(
                color: Colors.brown[700],
                child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                onPressed: () async {
                  if(_formkey.currentState!.validate()){ // If the form is valid, proceed
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.registerWithEmailPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = "Enter a valid email";
                        loading = false;
                      });
                    }
                    // Else statement is not needed because stream is set up to listen to auth changes. If a user successfully registers, it will automatically switch to Home
                  }
                } ,
              ),
              SizedBox(height: 15.0),
              Text(error, style: TextStyle(color: Colors.black, fontSize: 15.0)),
            ],
          ),
        ),
      ),
    );
  }
}
