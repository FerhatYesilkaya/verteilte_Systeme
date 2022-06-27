import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'authentication_class.dart';
import 'main.dart';
import 'Bestellung_anlegen.dart';


class HomePage extends StatelessWidget{
  late final dref = FirebaseDatabase.instance.ref();
  late DatabaseReference databaseReference;

  setData(){
    dref.child("Bestellungen").set({
      'id': 'Test',
    }
    );
  }
  showData() {
    dref.once().then((snapshot) {
      print(snapshot);
    });
  }

  Widget build(BuildContext context) {
    List toDo = [];

    return Scaffold(
      appBar: AppBar(
        title: Text("Einkaufsliste"),
        actions: <Widget>[
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
      ),
      body: ListView.builder(
          itemCount: toDo.length,
          itemBuilder: (context, int index){
            return Dismissible(
                key: Key(toDo[index]),
                child: Card(
                  child: ListTile(
                    title: Text(
                      toDo[index],

                    ),
                  ),
                )
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
              MaterialPageRoute(builder: (context) => bestellungAnlegen())
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add_circle),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}