import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_project/data/tanaman.dart';

class MyHome extends StatefulWidget {
  const MyHome({ Key? key}) : super(key: key);
  
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                      onTap: () {Navigator.of(context).pushNamed('/detail', arguments: jsonEncode(items[index]));},
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
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
                                            FutureBuilder(
                                              builder: (context, snapshot) {
                                                if(snapshot.hasData) {
                                                  return IconButton(
                                                    onPressed: () {}, 
                                                    icon: Icon(Icons.favorite, color: Colors.red.shade100,)
                                                  );
                                                } else {
                                                  return IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons.favorite_border,)
                                                  );
                                                }
                                              }
                                            ),
                                          ],
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
          );
  }
  Future<List<Tanaman>> readJsonDatabase() async {
    final rawData = await rootBundle.rootBundle.loadString('assets/data/tanaman.json');
    final list = json.decode(rawData) as List<dynamic>;
    return list.map((e) => Tanaman.fromJson(e)).toList();
  }

}

class MyHome1 extends StatefulWidget {
  const MyHome1({ Key? key }) : super(key: key);

  @override
  _MyHome1State createState() => _MyHome1State();
}

class _MyHome1State extends State<MyHome1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 30,
            width: 100,
            color: Colors.green[700],
              child: Text(
                'Login',
                 style: TextStyle(color: Colors.white),
                        
              ),
          ),
          SizedBox(height: 50,),
          MyHome()
        ],
      )
    );
  }
}
