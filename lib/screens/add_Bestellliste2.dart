import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../authentication_class.dart';
import '../main.dart';

class add_Bestellliste2 extends StatefulWidget {
  const add_Bestellliste2({Key? key}) : super(key: key);

  @override
  State<add_Bestellliste2> createState() => _bestellungenstlState();
}


class _bestellungenstlState extends State<add_Bestellliste2> {

  final TextEditingController produktController = TextEditingController();

  final items = ["Lidl","Aldi","E-Center"];
  String? value;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Bestellen"),
        actions: <Widget>[
          IconButton(onPressed: (){
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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
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
                height: double.infinity,
                width: double.infinity,

                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 120
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Produkte hinzufügen',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 50),
                      buildField(context, 'Deine Produkte eintragen',1, produktController, 150),
                      SizedBox(height: 50),
                      DropdownButton<String>(
                        value: value,
                        hint: Text("Laden"),
                        items: items.map(buildMenuItem).toList(),
                        onChanged: (value) => setState(() => this.value = value),
                      ),
                      SizedBox(height: 50),
                      RaisedButton(
                        elevation: 5,
                        onPressed: () {
                          context.read<AuthenticationService>().addProdukt(
                              produktController.text, value
                          );
                          Navigator.of(context)
                              .push(
                              MaterialPageRoute(builder: (context) => AuthenticationWrapper())
                          );
                        },
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        color: Colors.white,
                        child: Text(
                          'Bestellung abgeben',
                          style: TextStyle(
                              color: Color(0xff5ac18e),
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  DropdownMenuItem<String> buildMenuItem(String item)  =>
      DropdownMenuItem(value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}