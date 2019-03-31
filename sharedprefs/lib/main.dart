import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(new MaterialApp(
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataField = new TextEditingController();
  String _savedData = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadSavedData();
  }
  _loadSavedData() async{
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    setState(() {
        if(preferences.getString("data")!=null&&preferences.getString("data").isNotEmpty)
      _savedData = preferences.get("data");
        else{
          _savedData = "Empty Sp";
        }
    });

  }
  _saveData(String message) async{
    SharedPreferences preferences = await  SharedPreferences.getInstance();
          preferences.setString("data", message);

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("SharedPrefs"),
        backgroundColor: Colors.greenAccent,
      ),
      body: new Container(
          padding: const EdgeInsets.all(13.4),
          alignment: Alignment.center,
          child: new Column(children: <Widget>[
            new ListTile(
              title: new TextField(
                controller: _enterDataField,
                decoration: new InputDecoration(labelText: "Write Something"),
              ),
            ),
            new FlatButton(
                onPressed: () {
                  _saveData(_enterDataField.text.toString());
                },
                child: new Column(
                  children: <Widget>[
                    new Text("save data"),
                    new Padding(padding: new EdgeInsets.all(14.5)),
                    new Text(_savedData),
                  ],
                )),
          ])),
    );
  }
}
