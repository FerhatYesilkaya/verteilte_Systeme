import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'authentication_class.dart';
import 'main.dart';
import 'Bestellung_anlegen.dart';


class HomePage extends StatelessWidget{

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Bestellung anlegen"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Fügen Sie eine Bestellung hinzu:',
            ),
            //Text(
            //  ),
          ],
        ),
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