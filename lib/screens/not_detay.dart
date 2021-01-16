import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterNotSepeti/models/kategori.dart';
import 'package:flutterNotSepeti/utils/database_helper.dart';

class NotDetay extends StatefulWidget {
  String baslik;

  NotDetay({this.baslik});

  @override
  _NotDetayState createState() => _NotDetayState();
}

class _NotDetayState extends State<NotDetay> {
  var formKey = GlobalKey<FormState>();

  List<Kategori> tumKategoriler;
  DatabaseHelper databaseHelper;
  int kategoriIDD = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumKategoriler = List<Kategori>();
    databaseHelper = DatabaseHelper();
    databaseHelper.kategoriGetir().then((value) {
      for (Map okunanMap in value) {
        tumKategoriler.add(Kategori.fomMap(okunanMap));
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.baslik),
      ),
      body: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.green.shade200,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Kategori seçin",
                      style: TextStyle(fontSize: 22),
                    ),
                    Center(
                      child: DropdownButtonHideUnderline(
                        child: tumKategoriler.length <= 0
                            ? CircularProgressIndicator()
                            : DropdownButton<int>(
                                value: kategoriIDD,
                                items: kategoriSecenekleri(),
                                onChanged: (value) {
                                  setState(() {
                                    kategoriIDD = value;
                                  });
                                },
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  List<DropdownMenuItem<int>> kategoriSecenekleri() {
    return tumKategoriler
        .map((kategori) => DropdownMenuItem<int>(
              child: Text(kategori.kategoriAdi, style: TextStyle(fontSize:
              17),),
              value: kategori.kategoriID,
            ))
        .toList();
  }
}
