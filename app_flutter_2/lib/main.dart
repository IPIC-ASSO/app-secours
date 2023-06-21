import 'dart:io';
import 'package:app_secours/charge.dart';
import 'package:app_secours/listeDispositifs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'Officiant.dart';

void main() {
  runApp(const MyApp());
}

//TODO: 2 dispositifs de même nom

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App protection civile',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        secondaryHeaderColor: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  late AnimationController _controller;
  Map<String,String> fichiersDispositifs = {}; //clé: dispositif | valeur: chemin fichier
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this)
      ..addStatusListener((status) {
        if(status == AnimationStatus.completed)_controller.reverse();
        else if(status == AnimationStatus.dismissed)_controller.forward();})
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Liste des dispositifs'),
      ),
      body:FutureBuilder<Map<String,String>>(
        future: litFichiers(),
        builder: (BuildContext context, AsyncSnapshot<Map<String,String>> snapshot) {
          _controller.forward();
          List<Widget> children;
          if (snapshot.hasData) {
            _controller.stop();
            if (snapshot.data?.isEmpty??true){
              children = <Widget>[
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 60,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Prêt à l\'emploi. \nVous avez pour le moment 0 documents\nCréez en un nouveau dès maintenant', textAlign: TextAlign.center,),
                ),
              ];
            }else{
              children = [];
              for (String chemin in snapshot.data!.keys){
                children.add(construit_disp(snapshot.data?[chemin]??"Document indisponible", chemin));
              }
            }
          } else if (snapshot.hasError) {
            //_controller.stop();
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Erreur: ${snapshot.error}'),
              ),
            ];
          } else {
            children =  <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Chargement des données...',textAlign: TextAlign.center,),
              ),
              SizedBox(
                  width: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child:Chargement(controller: _controller),
                  )
              ),
            ];
          }
          return ListView(
              shrinkWrap: true,
              children: children,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ListeDispositifs(groupe: "",))),
        child: const Icon(Icons.add),
      ),
    );

  }

  Future<Map<String,String>> litFichiers() async {
    await prefs();
    if(!await verif_perm()) throw Exception('Oups, l\'application ne va pas pouvoir lire et écrire de PDF, il lui faut un accès au stockage.');
    Directory directoire = await getExternalStorageDirectory()??await getApplicationDocumentsDirectory();
    Map<String,String> dispositifs = {};
    final dossier = Directory("${directoire.path}/pdf");
    if (!(await dossier.exists())){
      await dossier.create(recursive: true);
    }
    final listeDossiers = dossier.listSync();
    for (FileSystemEntity dossier in listeDossiers) {
      if(dossier is Directory) dispositifs[dossier.path] = dossier.path.split("/").last;
    }
    return dispositifs;
  }

  Widget construit_disp(String disp, String chemin){
    return Padding(
    padding: const EdgeInsets.all(8),
    child:GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => ListeDispositifs(groupe: disp)));
      },
      child:
      Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[400]??Colors.grey,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))
        ),

        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Icon(
              Icons.folder_open,
              color: Colors.blue,
              size: 60,
            ),
            Text(disp, textAlign: TextAlign.center,)
          ],
        ),
      )
    ));
  }

  Future<bool> verif_perm() async {
    var status = Permission.storage;
    if (await status.isDenied) {
      var stat2 = await Permission.storage.request();
      if (stat2.isGranted)return true;
      else return false;
    }
    else return true;
  }

  Future<void> prefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getKeys().isEmpty){
      PdfDocument doc = await Officiant().litFichier("", context);
      for (int x = 0; x<doc.form.fields.count; x++){
        prefs.setInt(doc.form.fields[x].name??"erreur", x);
      }
    }
  }
}