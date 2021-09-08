// This sits beneath main.dart and listens to auth changes. It is either going to show home widget or authentication widget
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/authenticate.dart';
import 'package:brew_crew/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser?>(context); // Accessing data from provider. Specifying the type of data needed to ensure it listens to correct stream
    print(user);
    // Return either home widget or authentication widget
    if(user == null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}
