import 'package:flutter/material.dart';
// ignore: must_be_immutable
class Details extends StatefulWidget {
  String name;
  Details({this.name});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Container(
        child: Center(
          child: Text(widget.name, style: TextStyle(fontSize: 30,),),
        ),
      ),
    );
  }
}
