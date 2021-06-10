import 'package:contact_app/detail.dart';
import 'package:flutter/material.dart';

import 'group_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Contacts'),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  String title;

  MyHomePage({@required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final itemHeight = 50.0;

  final items = [
    'Marco Franco',
    'Raul Alday',
    'Jessica Alba',
    'Roger Waters',
    'Darth Vader',
    'Homer Simpson',
    'Bill Gates',
    'Elon Musk',
    'Enrique Peña',
    'Angeles Rodriguez',
    'Monica Alvarado',
    'Estrella Fugaz',
    'Juana Lopez',
  ];

  List<String> names;

  Widget itemWidget(BuildContext context, int index) {
    return GestureDetector(
      child: Text('${names[index]}', style: TextStyle(fontSize: 20, ),),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Details(name: names[index],)),
        );
      },
    );
  }

  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Contacts");
  final TextEditingController _searchQuery = new TextEditingController();
  bool _isSearching = false;
  String searchText = "";

  _MyHomePageState(){
    _searchQuery.addListener(() {
      setState(() {
        searchText = _searchQuery.text;
      });
    });
  }

  List<String> _buildSearchList() {
    if (searchText.isEmpty) {
      names = items;
      return items;
    }
    else {
      List<String> _searchList = List();
      for (int i = 0; i < items.length; i++) {
        String  name = items.elementAt(i);
        if (name.toLowerCase().contains(searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }
      names = _searchList;
      return _searchList;
    }
  }

  @override
  Widget build(BuildContext context) {

    items.sort((a, b) => a.toString().compareTo(b.toString()));
    names = items;
    //appBarTitle = new Text(widget.title);
    return Scaffold(
      appBar: AppBar(
          title: appBarTitle,
          actions: <Widget>[
            new IconButton(icon: actionIcon,onPressed:(){changeMode();}),]
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GroupView(
            itemHeight: itemHeight,
            items: _isSearching?_buildSearchList():items,
            itemBuilder: itemWidget,
          ),
        ),
      ),
    );
  }
  changeMode(){
    setState(() {
      _isSearching = !_isSearching;
      if (_isSearching){
        actionIcon = new Icon(Icons.close);
        appBarTitle = new TextField(
          controller: _searchQuery,
          style: new TextStyle(
            color: Colors.white,
          ),
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search,color: Colors.white),
              hintText: "Search...",
              hintStyle: new TextStyle(color: Colors.white)
          ),
        );}
      else {
        _searchQuery.clear();
        actionIcon = new Icon(Icons.search);
        appBarTitle = new Text(widget.title);
      }
    });
  }
}

