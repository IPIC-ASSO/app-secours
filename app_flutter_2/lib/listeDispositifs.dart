import 'dart:async';
import 'dart:io';
import 'package:app_secours/charge.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'Officiant.dart';
import 'declenchement.dart';

class ListeDispositifs extends StatefulWidget {

  String groupe;

  ListeDispositifs({super.key, required this.groupe});
  @override
  State<ListeDispositifs> createState() => _ListeDispositifsState();
}

class _ListeDispositifsState extends State<ListeDispositifs> with TickerProviderStateMixin, WidgetsBindingObserver  {
  bool charge = true;
  late AnimationController _controller;
  late SharedPreferences prefs;
  late Future <Map<String,String>> fichiersDispositifs; //clé: dispositif | valeur: chemin fichier
  TextEditingController dispositif  = TextEditingController();
  TextEditingController date  = TextEditingController();
  TextEditingController heure  = TextEditingController();
  TextEditingController num  = TextEditingController();
  DateTime selectedDate = DateTime.now();



  @override
  void initState() {
    super.initState();
    fichiersDispositifs = initPrefs();
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        charge = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Liste des victimes'),
      ),
      body:FutureBuilder<Map<String,String>>(
        future: fichiersDispositifs, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<Map<String,String>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData && !charge) {
            if (snapshot.data?.isEmpty??true){
              children = <Widget>[
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 60,
                ),
                const Center(child:
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Prêt à l\'emploi. \nVous avez pour le moment 0 victimes enregistrées', textAlign: TextAlign.center,),
                  ),
                )
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
          }else{
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
        onPressed: () => nouv_victime(context),
        child: const Icon(Icons.person_add_alt_1),
      ),
    );

  }

  Future<Map<String,String>> litFichiers() async {
    if(!await verif_perm()) throw Exception('Oups, l\'application ne va pas pouvoir lire et écrire de PDF, il lui faut un accès au stockage.');
    Directory directoire;
    if (!Platform.isIOS) {
      directoire = await getExternalStorageDirectory()??await getApplicationDocumentsDirectory();
    } else {
      directoire = await getApplicationDocumentsDirectory();
    }
    Map<String,String> victime = {};
    final dossier = Directory("${directoire.path}/pdf/${widget.groupe}");
    if (!await dossier.exists()){
      await dossier.create(recursive: true);
    }
    final listeFichiers = dossier.listSync();
    for (FileSystemEntity fichier in listeFichiers) {
      if (fichier is File){
        final doc = PdfDocument(inputBytes: File(fichier.path).readAsBytesSync());
        victime[fichier.path]=((doc.form.fields[prefs.getInt("num")??0] as PdfTextBoxField).text);
        //maj val
        if (fichier == listeFichiers.first){
          date.text = (doc.form.fields[prefs.getInt("date")??0] as PdfTextBoxField).text;
          heure.text = (doc.form.fields[prefs.getInt("heure")??0] as PdfTextBoxField).text;
        }
      }
    }
    if(victime.isEmpty || widget.groupe.isEmpty){
      victime.clear();
      await nouv_disp(context);
    }
    setState(() {
      charge = false;
    });
    return victime;
  }

  Widget construit_disp(String disp, String chemin){
    return Padding(
        padding: const EdgeInsets.all(8),
        child:GestureDetector(
            onTap: (){
              setState(() {
                charge = true;
              });
              Timer(const Duration(milliseconds: 500),(){
                Navigator.push(context, MaterialPageRoute(builder: (_) => Declenchement(chemin: chemin))).then((value){
                          setState(() {charge = false;});
                          });});
            },
            child:
            AnimatedContainer(
              duration: const Duration(microseconds: 500),
              decoration: BoxDecoration(
                color: Colors.white,
                  border: Border.all(
                    color: Colors.grey[400]??Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20))
              ),

              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(
                    Icons.person_2_outlined,
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

  Future<void> nouv_disp(BuildContext context) {
    dispositif.text = widget.groupe;
    return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Nouveau dispositif'),
            content: SizedBox(width: double.maxFinite, child: ListView(
              shrinkWrap: true,
              children: [
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  controller: dispositif,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Dispositif',
                  ),
                )),
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                        controller: date,
                        readOnly: true,  // when true user cannot edit text
                        onTap: () async {
                          _selectDate(context);
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'date',
                        ),
                      )),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                        controller: heure,
                        readOnly: true,  // when true user cannot edit text
                        onTap: () async {
                          await displayTimePicker(context, heure);
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'heure',
                        ),
                  ),
                ),
              ],
            ),),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Valider'),
                onPressed: () {
                  if (dispositif.text.isNotEmpty){
                    widget.groupe = dispositif.text;
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        }
    );
  }

  Future<void> nouv_victime(BuildContext context) {
    String txt = "";

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Nouvelle feuille'),
            content:StatefulBuilder(
              builder: (BuildContext context, StateSetter dropDownState){
                return SizedBox(width: double.maxFinite, child: ListView(
                  shrinkWrap: true,
                  children:[
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextField(
                        onChanged: (val){
                          dropDownState(() {
                            txt = "Nom du fichier: ${widget.groupe}_${num.text}.pdf";
                          });
                        },
                        controller: num,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Numéro de la victime: ',
                        ),
                      ),),
                    Text(txt),
                  ]));
                }),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Créer'),
                onPressed: () async{
                  setState(() {
                    charge = !charge;
                  });
                  Navigator.pop(context);
                  await Future.delayed(const Duration(milliseconds: 1000));
                  await creer_victime("${dispositif.text}_${num.text}");
                  setState(() {
                    charge = !charge;
                  });
                },
              ),
            ],
          );
        });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime maDate;
    if (date.text!=""){
      maDate = DateTime.parse(date.text);
    }else{
      maDate = selectedDate;
    }

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: maDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));//.whenComplete(() => Navigator.of(context).pop());
    if (picked != null) {
      String formattedDate = DateFormat('dd/MM/yy').format(picked);
      setState(() {
        selectedDate = picked;
        date.text = formattedDate.toString();
      });
    }
  }

  Future displayTimePicker(BuildContext context, TextEditingController heureC) async {
    TimeOfDay heure;
    if (heureC.text!=""){
      heure = TimeOfDay(hour:int.parse(heureC.text.split(":")[0]),minute: int.parse(heureC.text.split(":")[1]));
    }else{
      heure = TimeOfDay.now();
    }
    var time = await showTimePicker(
        context: context,
        initialTime: heure
    );

    if (time != null) {
      setState(() {
        heureC.text = time.format(context);
      });
    }
  }

  creer_victime(String nomF) async {
    String x = await Officiant().nouveauChemin2(widget.groupe, nomF);

    if (x =="0"){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Un fichier du même nom existe déjà"),));return;}
    else if( x == "1")ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enregistrement impossible"),));
    else{
      PdfDocument doc = await Officiant().litFichier("", context);
      (doc.form.fields[prefs.getInt("dispositif")??0] as PdfTextBoxField).text = dispositif.text;
      (doc.form.fields[prefs.getInt("num")??0] as PdfTextBoxField).text = num.text;
      (doc.form.fields[prefs.getInt("date")??0] as PdfTextBoxField).text = date.text;
      (doc.form.fields[prefs.getInt("heure")??0] as PdfTextBoxField).text = heure.text;
      Officiant().enregistreFichier(x, doc).then((value) {
        if (value){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enregistré !"),));
        setState(() {
          fichiersDispositifs = litFichiers();
        });}
        else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Une erreur est survenue :/"),));
      });
    }

  }

  Future<Map<String,String>> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 1));
    return litFichiers();
  }
}