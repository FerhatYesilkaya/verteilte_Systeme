import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Homepage.dart';
import 'authentication_class.dart';
import 'main.dart';

class  bestellungAnlegen extends StatelessWidget {

  const bestellungAnlegen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('BestellCount'),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
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
                      Text(
                        'Bestelldetails',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 50),
                      buildField('Vorname',0xf04b6, TextEditingController()),
                      buildField('Artikel',0xf04b6, TextEditingController()),
                      buildField('Preis',0xe0b2, TextEditingController()),
                      RaisedButton(
                        onPressed: () {
                          context.read<AuthenticationService>().signOut(context);
                        },
                        child: Text("Sign out"),
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
}