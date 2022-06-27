import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shopper/Bestellung_anlegen.dart';
import 'package:shopper/Homepage.dart';
import 'package:shopper/SignInPage.dart';
import 'package:shopper/main.dart';

class AuthenticationService {

  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> resetPassword({required String email, required BuildContext context}) async{
    print(email);
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      showAlertDialog(context,"E-Mail wurde verschickt","Passwort zurücksetzen");
      print("Email verschickt");
    } on FirebaseAuthException catch (e){
      showAlertDialog(context,"E-Mail konnte nicht verschickt werden. Überprüfen Sie die Daten!","Passwort zurücksetzen");
      print("Konnte nicht E-Mail verschicken");
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.ref();



  clearDatabaseProducts() {
    databaseRef.child("Bestellungen").remove();
  }


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

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthenticationWrapper()));
  }

  showAlertDialog(BuildContext context, String text, String title) {

    // set up the button
    Widget okButton = TextButton(
      style: TextButton.styleFrom(
        primary: Colors.green,
      ),
      child: Text("OK"),
      onPressed: () => Navigator.pop(context),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<Object?> signIn({required String email, required String password, String name = "placeholder", required BuildContext context}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print("erfolgreich angemeldet");
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthenticationWrapper()));
      return "erfolgreich angemeldet";
    } on FirebaseAuthException catch (e){
      print("User nicht gefunden");
      showAlertDialog(context,"E-Mail oder Passwort ist falsch","Anmeldung fehlgeschlagen");
    }

  }
  Future<String?> signUp({required String email, required String password, required int firstRegister, String name = "placeholder", required BuildContext context}) async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      print("Benutzer erstellt");
      if(firstRegister == 1) {
        insertData(name, email,inputData().toString());
        signIn(email: email, password: password, name: name,context: context);
      }
      return "Benutzer erstellt";
    } on FirebaseAuthException catch (e){
      print("Konnte nicht registrieren");
      showAlertDialog(context,"Bitte prüfen Sie die Daten auf Richtigkeit","Registrierung fehlgeschlagen");
          return e.message;
    }
  }

  String? getuserID(){
    final User? userx = _firebaseAuth.currentUser;
    final userID = userx?.uid;
    return userID;
  }

  Future<void> addProdukt(String produkt) async {

    var changeString = produkt.replaceAll("\n", " \\n ");
    var userID = getuserID();

    final snapshot = await databaseRef.child('Student/$userID/Name').get();

    databaseRef.child("Bestellungen/$userID").set({
      "Name": snapshot.value,
      "Produkte": changeString,
    }
    );
  }
  Future<String> loadImage(String userID
      ) async{
    final ref = FirebaseStorage.instance.ref().child('files///$userID');
    var url = await ref.getDownloadURL();
    print(url);
    return url;
  }
}