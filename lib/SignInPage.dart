import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shopper/Bestellung_anlegen.dart';
import 'package:shopper/Homepage.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'authentication_class.dart';

class  SignInPage extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
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
                        'Anmelden',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 50),
                      buildField("E-Mail", 0xf705, emailController),
                      buildField("Passwort", 0xf04b6, passwordController),
                      buildForgotPassBtn(context),
                      SizedBox(height: 5),
                      ButtonTheme(
                        minWidth: 400,
                        child: RaisedButton(
                          elevation: 5,
                          onPressed: () {
                            context.read<AuthenticationService>().signIn(
                              email: emailController.text,
                              password: passwordController.text,
                              context: context,
                            );
                          },
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          color: Colors.white,
                          child: Text(
                            'ANMELDEN',
                            style: TextStyle(
                                color: Color(0xff5ac18e),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      buildSignUpBtn(context),
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