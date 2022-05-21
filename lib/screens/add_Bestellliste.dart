import 'package:flutter/material.dart';

class add_Bestellliste extends StatefulWidget {
  const add_Bestellliste({Key? key}) : super(key: key);

  @override
  State<add_Bestellliste> createState() => _add_BestelllisteState();
}

class _add_BestelllisteState extends State<add_Bestellliste> {
  late TextEditingController nameController,numberController;

  initState() {
    super.initState();
    nameController = TextEditingController();
    numberController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bestellung hinzufügen"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: ("Enter Name"),
                prefixIcon: Icon(Icons.account_circle,size: 30,),
                fillColor: Colors.white,
                filled: true
              ),
            ),
            SizedBox(height: 15),

            TextFormField(
              controller: numberController,
              decoration: InputDecoration(
                  hintText: ("Enter Number"),
                  prefixIcon: Icon(Icons.phone_iphone,size: 30,),
                  fillColor: Colors.white,
                  filled: true
              ),
            ),
          ],
        ),
      ),
    );
  }
}
