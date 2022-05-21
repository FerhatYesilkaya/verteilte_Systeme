import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper/screens/add_Bestellliste.dart';

import '../authentication_class.dart';

class Bestellliste extends StatefulWidget {
  const Bestellliste({Key? key}) : super(key: key);

  @override
  State<Bestellliste> createState() => _BestelllisteState();
}

class _BestelllisteState extends State<Bestellliste> {
  late Query _ref;

  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.ref().child("Bestellungen");
  }
  Widget buildBestelllisteItem({required Map bestellung}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      height: 100,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              SizedBox(width: 6,),
              Text(bestellung.values.elementAt(1).toString(), style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColor,
                fontWeight:  FontWeight.w600,
              ),
              ),
              SizedBox(width: 6,),
              Text(bestellung.values.elementAt(0).toString().replaceAll("}", " ").replaceAll("{", " ").replaceAll(",", "\n"), style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColor,
                fontWeight:  FontWeight.w600,
              ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Bestellungen"),
        actions: <Widget>[
          new IconButton(onPressed: (){
            context.read<AuthenticationService>().signOut(context);
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double>animation, int index){
            Map bestellung = snapshot.value as Map<Object?, dynamic>;
            print(bestellung);
            return buildBestelllisteItem(bestellung: bestellung);
          },
        ),
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

    );
  }
}

