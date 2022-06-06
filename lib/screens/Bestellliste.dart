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
            context.read<AuthenticationService>().signOut(context);
          }, icon: Icon(Icons.logout)),
        ],
        title: Text("Bestellungen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder:  (_) {
                return add_Bestellliste();
              }
          ));
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: FirebaseAnimatedList(
          query: databaseRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
            var data = snapshot.value as Map?;
            return ListTile(
              onTap: (){
                print(data!["Name"]);
              },
              title: Text(data!["Name"]),
              subtitle: Text(data!["Produkte"].toString().replaceAll(" \\n ", "\n")),
              trailing: IconButton(
                onPressed: (){
                  var keyFinder = snapshot.key;
                  print(keyFinder);
                },
                icon: Icon(Icons.delete),
              ),
            );
          },
        ),
      ),
    );
  }
}
