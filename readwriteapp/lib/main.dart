import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
void main() async{

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
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Read/Write"),
        backgroundColor: Colors.greenAccent,
      ),
      body: new Container(
          padding: const EdgeInsets.all(13.4),
          alignment: Alignment.center,
          child: new Column(
              children: <Widget>[

                new ListTile(
                  title: new TextField(
                    controller: _enterDataField,
                    decoration: new InputDecoration(
                        labelText: "Write Something"
                    ),
                  ),
                ),
                new FlatButton(onPressed: () {
                  writeData(_enterDataField.text);
                }, child: new Column(
                  children: <Widget>[
                    new Text("save data"),
                    new Padding(padding: new EdgeInsets.all(14.5)),
                    new FutureBuilder(builder:(BuildContext context,AsyncSnapshot<String> data){
                      if(data.hasData!=null){
                        return new Text(data.data.toString(),style: new TextStyle(
                          color: Colors.blueAccent
                        ),);
                      }
                      else{
                        return new Text("No data send");
                      }
                    },future: readData(),),
                  ],
                )),
              ]
          )

      ),
    );
  }

}
  Future <String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future <File> get _localFile async{
    final path = await _localPath;
    return new File('$path/data.txt');
  }
  Future <File> writeData(String message) async{
    final file = await _localFile;
    return file.writeAsString('$message');
  }

  Future<String> readData() async{
    try{
      final file = await _localFile;
      // Read
      String data = await file.readAsString();
      return data;
    }catch(e){
      return "Nothing saved yet";
    }
  }



