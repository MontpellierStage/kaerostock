import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kaerostock/yannick.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Utilisateur> mesUtilisateurs = [];
  bool getUtilisateurState = false;
  bool insertUtilisateurState = false;
  int getUtilisateurError = -1;
  TextEditingController moncontroleurnom = TextEditingController();
  TextEditingController moncontroleurprenom = TextEditingController();
  String nomuti = "";
  String prenomuti = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      getUtilisateur();
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Card(
            margin : EdgeInsets.symmetric(vertical: 10.0,
                horizontal: 25.0),
            child: TextField(
              controller: moncontroleurnom,
              decoration: InputDecoration(
                labelText: "Entrer le nom du nouvel utilisateur",
              ),
              onChanged: (text){
                setState((){
                  nomuti=text;
                });
              },
            ),
          ),
          Card(
            margin : EdgeInsets.symmetric(vertical: 10.0,
                horizontal: 25.0),
            child: TextField(
              controller: moncontroleurprenom,
              decoration: InputDecoration(
                labelText: "Entrer le prenom du nouvel utilisateur",
              ),
              onChanged: (text){
                setState((){
                  prenomuti=text;
                });
              },
            ),
          ),
          Text('$nomuti'),
          Text('$prenomuti'),
          ElevatedButton(
            onPressed: (){
              insertUtilisateur(nom: nomuti, prenom: prenomuti);},
            child: Text('Ajouter utilisateur'),
          ),
          ElevatedButton(
            onPressed: (){
              getUtilisateur();},
            child: Text('Voir utilisateurs'),),
          visuser(),





        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Center visuser(){
    if(getUtilisateurState == false){
      return Center(
          child: Text('A la con'));
    }
    return
      (Center(
        child: ListView.builder(
          itemCount: mesUtilisateurs.length,
          itemBuilder: (context, index) {
            return Visibility(
              visible: getUtilisateurState,
              child: ListTile(
                title: Text(mesUtilisateurs[index].unom + ' ' + mesUtilisateurs[index].uprenom),
              ),
            );
          },
        ),
    ));
  }

  Future getUtilisateur() async {
    Uri url = Uri.parse(
        "http://kaerostock.com/php/utilisateur/monpapi_utilisateur.php");
    getUtilisateurState = false;
    getUtilisateurError = -1;

    http.Response response = await http.post(url);

    if (response.body.toString() == 'ERR_1001') {
      getUtilisateurError = 1001;
    }
    if (response.statusCode == 200) {
      var datamysql = jsonDecode(response.body) as List;
      print('object');

      setState(() {
        getUtilisateurError = 0;
        getUtilisateurState = true;
        mesUtilisateurs = datamysql.map((xJson) => Utilisateur.fromJson(xJson)).toList();
      });
    }
  }

  Future insertUtilisateur({required String nom, required String prenom}) async {
    Uri url = Uri.parse(
        "http://kaerostock.com/php/utilisateur/utilisateur_ajout.php");
    var data = {
      "UNOM": nom,
      "UPRENOM": prenom,
    };

    var res = await http.post(url, body: data);

  }
}
