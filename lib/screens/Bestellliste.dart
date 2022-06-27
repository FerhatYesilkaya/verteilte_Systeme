import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:snapshot/snapshot.dart';
import 'package:provider/provider.dart';

import '../authentication_class.dart';
import 'add_Bestellliste.dart';

class Bestellliste extends StatefulWidget {
  const Bestellliste({Key? key}) : super(key: key);

  @override
  State<Bestellliste> createState() => _BestelllisteState();
}

class _BestelllisteState extends State<Bestellliste> {

  final databaseRef = FirebaseDatabase.instance.ref().child("Bestellungen");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          new IconButton(onPressed: (){
            context.read<AuthenticationService>().clearDatabaseProducts();
          }, icon: Icon(Icons.delete)),

          new IconButton(onPressed: (){
            context.read<AuthenticationService>().signOut(context);
          }, icon: Icon(Icons.logout)),

        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x665ac18e),
                    Color(0x995ac18e),
                    Color(0xcc5ac18e),
                    Color(0xff5ac18e),
                  ]
              )
          ),
        ),
        title: Text("Einkaufsliste"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder:  (_) {
                return add_Bestellliste();
              }
          ));
        },

        child: Container(
          width: 60,
          height: 60,
          child: Icon(Icons.add),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x665ac18e),
                    Color(0x995ac18e),
                    Color(0xcc5ac18e),
                    Color(0xff5ac18e),
                  ]
              )
          ),
        ),
      ),
      body: SafeArea(
        child: FirebaseAnimatedList(
          query: databaseRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
            var data = snapshot.value as Map?;
            return ListTile(
              title: Text(data!["Name"]),
              subtitle: Text(data!["Produkte"].toString().replaceAll(" \\n ", "\n")),
            );
          },
        ),
      ),
    );
  }
}
