import 'package:flutter/material.dart';
import 'package:flutter_project/pages/detail_portrait.dart';
import 'package:flutter_project/pages/home_landscape.dart';
import 'package:flutter_project/pages/home_portrait.dart';
import 'package:flutter_project/pages/login_page.dart';
import 'package:flutter_project/pages/regi_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        '/home': (BuildContext ctx) => MainWidget(),
        '/detail': (BuildContext ctx) => MyDetail(),
        '/login': (BuildContext ctx) => LoginPage(),
        '/register': (BuildContext ctx) => RegPage(),
      }
    );
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({ Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aneka Macam Tanaman'),
        ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return _wideContainer();
          } else {
            return _normalContainer();
          }
        }
      )
    );
  }
  Widget _normalContainer() {
    return MyHome();
  }
  Widget _wideContainer() {
    return MyHomeLandscape();
  
  }
}
