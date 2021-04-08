import 'package:flutter/material.dart';

class PageHome extends StatefulWidget {

  final String nama;
  final String password;

  //constructor


  PageHome({Key key, @required this.nama, @required this.password}) : super(key:  key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Home'),
        backgroundColor: Colors.red,
      ),

      body: ListView(
        children: <Widget>[
          Text('Welcome : ${widget.nama}'),
          Text('Your Password is : ' + widget.password)
        ],
      ),
    );
  }
}