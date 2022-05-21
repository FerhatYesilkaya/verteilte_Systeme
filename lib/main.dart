import 'package:shopper/Bestellung_anlegen.dart';
import 'package:shopper/SignUpPage.dart';
import 'package:shopper/forgotPasswordPage.dart';
import 'package:shopper/screens/Bestellliste.dart';
import 'authentication_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopper/Homepage.dart';
import 'package:shopper/SignInPage.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
              create: (_) => AuthenticationService(FirebaseAuth.instance)
          ),
          
          StreamProvider(
              create: (context) => context.read<AuthenticationService>().authStateChanges, initialData: null,
          )
         ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',

            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: AuthenticationWrapper(),
          )
        );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if(firebaseUser != null){
      return Bestellliste();
    }
      return SignInPage();
  }
}


Widget buildField(var Text, int x, TextEditingController mailcontroller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 18),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0,2)
              )
            ]
        ),
        height: 60,
        child: TextField(
          controller : mailcontroller,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.black87,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
               prefixIcon: Icon(IconData(x, fontFamily: 'MaterialIcons')),
                hintText: Text,
                hintStyle: TextStyle(
                color: Colors.black38
              )
          ),
        ),
      )
    ],
  );
}

Widget buildForgotPassBtn(BuildContext context) {
  return Container(
    alignment: Alignment.centerRight,
    child: FlatButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => forgotPassword()));
      },
      padding: EdgeInsets.only(right: 0),
      child: Text(
        'Passwort vergessen?',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
    ),
  );
}
Widget buildSignUpBtn(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPage()));
    },
    child: RichText(
        text: TextSpan(
            children: [
              TextSpan(
                  text: 'Don\'t have an Account? ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  )
              ),
              TextSpan(
                  text: 'Sign Up',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  )
              )
            ]
        )
    ),
  );
}

Widget buildResetBtn(BuildContext context, String emailText) {

  return Container(
    padding: EdgeInsets.symmetric(vertical: 25),
    width: double.infinity,
    child: RaisedButton(
      elevation: 5,
      onPressed: () {
        print(emailText);
        context.read<AuthenticationService>().resetPassword(
          email: emailText,
        );
      },
      padding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      color: Colors.white,
      child: Text(
        "Zurücksetzen",
        style: TextStyle(
            color: Color(0xff5ac18e),
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
      ),
    ),
  );
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}