import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/data/tanaman.dart';

class MyDetail extends StatefulWidget {
  const MyDetail({ Key? key }) : super(key: key);

  @override
  _MyDetailState createState() => _MyDetailState();
}

class _MyDetailState extends State<MyDetail> {
  var namaTanaman = "";
  var namaLatin = "";
  var kategori = "";
  var deskripsi = "";
  var iklim = "";
  var image = "";
  Tanaman? tanaman;

  @override
  void initState(){
    super.initState();
  }

  @override
  void didChangeDependencies(){

    var tanamanString = ModalRoute.of(context)?.settings.arguments as String;

    var tanamanJson = jsonDecode(tanamanString);

    setState(() {
      tanaman = Tanaman.fromJson(tanamanJson);
      namaTanaman = tanaman!.nama!;
      namaLatin = tanaman!.namaIlmiah!;
      kategori = tanaman!.kategori!;
      deskripsi = tanaman!.deskripsi!;
      iklim = tanaman!.iklim!;
      image = tanaman!.imageUrl!;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(namaTanaman)
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.green,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    image, 
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.40,
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  children: <Widget>[
                    Text(
                      namaTanaman,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      namaLatin,
                      style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic,),
                      
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Kategori tanaman : $kategori',
                      style: TextStyle(fontSize: 18,),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      deskripsi,
                      style: TextStyle(fontSize: 18,),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Iklim hidup : $iklim',
                      style: TextStyle(fontSize: 18,),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      
      ),
    );
  }
}