import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance; // Instance of class/library FirebaseAuth. _auth signifies it is private and is not going to be used in any other file

  CustomUser? _userFromFirebase(User user){ // Extract uid of a user from various other properties returned for a user
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  Stream<CustomUser?> get user{ // Stream to listen to auth change
    return _auth.authStateChanges().map((User? user) => _userFromFirebase(user!));
  }

  // Sign in anonymously
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously(); // AuthResult has been changed to UserCredential
      User? user = result.user; // FirebaseUser has been changed to User
      return _userFromFirebase(user!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future signInWithEmailPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password); // AuthResult has been changed to UserCredential
      User? user = result.user; // FirebaseUser has been changed to User
      return _userFromFirebase(user!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Register with email and password
  Future registerWithEmailPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password); // AuthResult has been changed to UserCredential
      User? user = result.user; // FirebaseUser has been changed to User

      await DatabaseService(uid: user!.uid).updateUserData('0', 'Kunal', 100); // Create a new firestore database document using uid

      return _userFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}