import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart' as p;

import 'declenchement.dart';
import 'menu.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  late PdfDocument _document;
  bool _isLoading = true;
  Map<String,String> fichiersDispositifs = {}; //clé: dispositif | valeur: chemin fichier
  
  @override
  void initState() {
    super.initState();
    //loadDocument();
  }

  Future<void> loadDocument() async {
    final ByteData data = await rootBundle.load('assets/example.pdf');
    final Uint8List bytes = data.buffer.asUint8List();
    _document = PdfDocument(inputBytes: bytes);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Listes des dispositifs'),
      ),
      body:FutureBuilder<Map<String,String>>(
        future: litFichiers(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<Map<String,String>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            if (snapshot.data?.isEmpty??true){
              children = <Widget>[
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
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
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Chargement des données...'),
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
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Declenchement(chemin: "",))),
        child: const Icon(Icons.add),
      ),
    );

  }

  verif_dossier()async{
    final telechargements = await getDownloadsDirectory();
    if (telechargements!= null && telechargements.path!=null){
      final checkPathExistence = await Directory(telechargements.path+"\app_pro_civile").exists();
      if (checkPathExistence){
        return true;
      }else{

      }
    }
  }

  Future<Map<String,String>> litFichiers() async {
    Directory? telechargements;
    if (Platform.isIOS) {
      telechargements = await getDownloadsDirectory();
    } else {
      telechargements = Directory('/storage/emulated/0/Download');
    }
    Map<String,String> dispositifs = {};
    if (telechargements != null && telechargements.path != null) {
      final dossier = await Directory(telechargements.path + "/app_pro_civile");
      if (!await dossier.exists()){
        dossier.create(recursive: true);
      }
      final listeFichiers = dossier.listSync();

      for (FileSystemEntity fichier in listeFichiers) {
        final doc = PdfDocument(inputBytes: File(fichier.path).readAsBytesSync());
        dispositifs[fichier.path]=((doc.form.fields[120] as PdfTextBoxField).text);
      }
    }
    return dispositifs;
  }

  Widget construit_disp(String disp, String chemin){
    return Padding(
    padding: EdgeInsets.all(8),
    child:GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => Declenchement(chemin: chemin)));
      },
      child:
      Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[400]??Colors.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),

        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            const Icon(
              Icons.file_open,
              color: Colors.blue,
              size: 60,
            ),
            Text(disp, textAlign: TextAlign.center,)
          ],
        ),
      )
    ));
  }

  @override
  void dispose() {
    _document.dispose();
    super.dispose();
  }
}