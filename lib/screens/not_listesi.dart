// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterNotSepeti/models/kategori.dart';
import 'package:flutterNotSepeti/screens/not_detay.dart';
import 'package:flutterNotSepeti/utils/database_helper.dart';

class NotListesi extends StatelessWidget {
  DatabaseHelper databaseHelper = DatabaseHelper();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          actions: [
            Container(
              padding: EdgeInsets.all(4),
              height: 30,
              width: 120,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      heroTag: "kategoriekle",
                      tooltip: "Kategori Ekle",
                      onPressed: () {
                        kategoriEkleDialog(context);
                      },
                      child: Icon(
                        Icons.add_to_photos_outlined,
                        size: 36,
                      ),
                      backgroundColor: Colors.purple,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton(
                      heroTag: "notekle",
                      tooltip: "Not Ekle",
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context) => NotDetay(baslik: "Yeni Not Ekle")));
                      },
                      child: Icon(
                        Icons.add,
                        size: 36,
                      ),
                      backgroundColor: Colors.green,
                    ),
                  ]),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Not Sepeti",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 31))),
    );
  }

  void kategoriEkleDialog(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var eklenenKategori;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Kategori Ekle"),
            backgroundColor: Colors.green.shade50,
            children: [
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                      onSaved: (input) {
                        eklenenKategori = input;
                      },
                      decoration: InputDecoration(
                        labelText: "Kategori ADI",
                        border: OutlineInputBorder(),
                      ),
                      // ignore: missing_return
                      validator: (input) {
                        if (input.length < 3) {
                          return "Bu kadar kısa olamaz";
                        }
                      }),
                ),
              ),
              ButtonBar(
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.red,
                    child: Text("Vazgeç"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        databaseHelper
                            .kategoriEkle(Kategori(eklenenKategori))
                            .then((kategoriID) {
                          if (kategoriID > 0) {
                            print(" * * * * * * * * * $kategoriID : "
                                "$eklenenKategori eklendi * * * * "
                                "* * * ");
                            Navigator.pop(context);
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("$eklenenKategori  eklendi"),
                              duration: Duration(seconds: 1),
                            ));
                          }
                        });
                      }
                    },
                    color: Colors.yellow,
                    child: Text("Ekle"),
                  ),
                ],
              )
            ],
          );
        });
  }
}
