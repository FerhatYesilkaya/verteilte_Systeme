import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shopper/Bestellung_anlegen.dart';
import 'package:shopper/Homepage.dart';
import 'package:shopper/SignInPage.dart';

class AuthenticationService {

  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> resetPassword({required String email}) async{
    print(email);
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      print("Email verschickt");
    } on FirebaseAuthException catch (e){
      print("Konnte nicht E-Mail verschicken");
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.ref();


  String? inputData() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    return uid;
    // here you write the codes to input the data into firestore
  }
  void insertData(String name, String eMail, String id) {
    databaseRef.child("Student/$id").set({
      'E-Mail': eMail,
      'Name': name
    });
    //nameController.clear();
    //passwordController.clear();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
  Future<String?> signIn({required String email, required String password, String name = "placeholder", required BuildContext context}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print("erfolgreich angemeldet");
      insertData(name, email,inputData().toString());
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
      return "erfolgreich angemeldet";
    } on FirebaseAuthException catch (e){
      print("User nicht gefunden");
          return e.message;
    }

  }
  Future<String?> signUp({required String email, required String password, required int firstRegister, String name = "placeholder", required BuildContext context}) async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      print("Benutzer erstellt");
      if(firstRegister == 1) {
        signIn(email: email, password: password, name: name,context: context);
      }
      return "Benutzer erstellt";
    } on FirebaseAuthException catch (e){
      print("Konnte nicht registrieren");
          return e.message;
    }
  }
}