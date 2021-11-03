import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_project/data/tanaman.dart';

class MyHomeLandscape extends StatefulWidget {
  const MyHomeLandscape({ Key? key }) : super(key: key);

  @override
  _MyHomeLandscapeState createState() => _MyHomeLandscapeState();
}

class _MyHomeLandscapeState extends State<MyHomeLandscape> { 
  var klik = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: FutureBuilder(
            future: readJsonDatabase(),
            builder: (context,snapshot){
              if(snapshot.hasError){
                return Center(child: Text('${snapshot.error}'),);
              } else if(snapshot.hasData) {
                var items = snapshot.data as List<Tanaman>;
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: () {
                        setState(() {
                          klik = index; 
                        });
                      },
                      child: Card(
                        elevation: 0,
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  child: Image(
                                    image: NetworkImage(items[index].imageUrl ?? ''),
                                    width: 90,
                                    height: 130,
                                    fit: BoxFit.cover,),
                                  borderRadius: BorderRadius.zero,
                                )
                              ),
                              Expanded(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          items[index].nama ?? '', 
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          items[index].namaIlmiah ?? '', 
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            fontStyle: FontStyle.italic
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ), 
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else return Center(
                child: CircularProgressIndicator(),
              );
            }
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          color: Colors.green,
          child: FutureBuilder(
            future: readJsonDatabase(),
            builder: (context,snapshot) {
              if(snapshot.hasError){
                return Center(child: Text('${snapshot.error}'),);
              } else if (snapshot.hasData){
                var isidata = snapshot.data as List<Tanaman>;
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context,index) {
                    return SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  isidata[klik].imageUrl ?? '', 
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
                                    isidata[klik].nama ?? '',
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    isidata[klik].namaIlmiah ?? '',
                                    style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic,),
                                    
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    "Kategori tanaman : ${isidata[klik].kategori ?? ''}",
                                    style: TextStyle(fontSize: 18,),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    isidata[klik].deskripsi ?? '',
                                    style: TextStyle(fontSize: 18,),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    'Iklim hidup : ${isidata[klik].iklim ?? ''}',
                                    style: TextStyle(fontSize: 18,),
                                  ),
                                ],
                              )
                            ),
                          ],
                        ),
                      ),
                    
                    );
                  }
                );
              } else return Center(
                child: CircularProgressIndicator(),

              );
            },
          ),
        ),
      ],
    );
  }
  Future<List<Tanaman>> readJsonDatabase() async {
    final rawData = await rootBundle.rootBundle.loadString('assets/data/tanaman.json');
    final list = json.decode(rawData) as List<dynamic>;
    return list.map((e) => Tanaman.fromJson(e)).toList();
  }
}