import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser?>.value( // Wrap a widget tree with a provider to listen to auth changes from stream
      catchError: (User, CustomUser) => null,
      value: AuthService().user, // .user means the name of stream in auth.dart
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

