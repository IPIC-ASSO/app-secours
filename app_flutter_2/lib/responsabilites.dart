import 'dart:developer';
import 'dart:ui';
import 'package:app_secours/charge.dart';
import 'package:flutter/services.dart';
import 'package:pdf_render/pdf_render.dart' as pdi;
import 'package:app_secours/Officiant.dart';
import 'package:app_secours/menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class Responsabilites extends StatefulWidget {

  String chemin;

  Responsabilites({super.key, required this.chemin});

  @override
  State<Responsabilites> createState() => _ResponsabilitesState();
}

class _ResponsabilitesState extends State<Responsabilites> with TickerProviderStateMixin {

  late AnimationController _controller;
  late final SharedPreferences prefs;
  bool enr = true;
  String future = "";
  DateTime selectedDate = DateTime.now();

  TextEditingController nomResponsable = TextEditingController();
  TextEditingController nomResponsableHop = TextEditingController();
  TextEditingController materiel = TextEditingController();
  TextEditingController heure = TextEditingController();
  //victime
  TextEditingController nomV = TextEditingController();
  TextEditingController prenomV = TextEditingController();
  TextEditingController dateV = TextEditingController();
  //temoins 1
  TextEditingController nomT1 = TextEditingController();
  TextEditingController prenomT1 = TextEditingController();
  TextEditingController dateT1 = TextEditingController();
  //temoins 2
  TextEditingController nomT2 = TextEditingController();
  TextEditingController prenomT2 = TextEditingController();
  TextEditingController dateT2 = TextEditingController();
  int prise_charge = 0;
  //pointage
  TextEditingController heure_poste = TextEditingController();
  TextEditingController heure_renforts = TextEditingController();
  TextEditingController heure_medicalisation = TextEditingController();
  TextEditingController heure_evacuation = TextEditingController();
  TextEditingController heure_hopital = TextEditingController();
  TextEditingController heure_fin = TextEditingController();
  //truc
  bool LSP = false;
  bool DCD = false;
  bool EVAC = false;
  bool dixsept = false;
  bool dixhuit = false;
  bool quinze = false;

  List<String> modification = ["appuyez pour modifier", "modification"];
  int modif = 0;
  int modifhop = 0;
  int modifV = 0;
  int modifT1 = 0;
  int modifT2 = 0;
  late Future<List<Uint8List>> signatures;
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  final GlobalKey<SfSignaturePadState> _signaturePadKeyHop = GlobalKey();
  final GlobalKey<SfSignaturePadState> _signaturePadKeyV = GlobalKey();
  final GlobalKey<SfSignaturePadState> _signaturePadKeyT1 = GlobalKey();
  final GlobalKey<SfSignaturePadState> _signaturePadKeyT2 = GlobalKey();


  @override
  void initState() {
    litFichier();
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
        title: const Text('Responsabilités'),
        actions: [
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: (){
                metChampsAJour();
              }//_save,
          ),
        ],
      ),
      body: corps(),
      drawer:Menu(widget.chemin,enr),
    );
  }

  Widget corps(){
    if (future == "ok"){
      return Padding(
          padding: const EdgeInsets.fromLTRB(3,8,3,3),
          child:ListView(
              children: [
                ExpansionTile(
                title: const Text('Responsables'),
                textColor: Colors.grey[800],
                collapsedTextColor: Colors.black,
                collapsedBackgroundColor: Colors.grey[300],
                iconColor: Colors.black,
                children: <Widget>[
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    controller: nomResponsable,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nom du responsable de l\'intervention',
                    ),
                  )),
                    FutureBuilder<List<Uint8List>>(
                    future: signatures, // a previously-obtained Future<String> or null
                    builder: (BuildContext context, AsyncSnapshot<List<Uint8List>> snapshot) {
                      if (snapshot.hasData && snapshot.data!=null) {
                        return Column(
                            children: [
                              Image.memory(snapshot.data![0].buffer.asUint8List(),),
                              ElevatedButton(
                                  child: const Text("Modifier"),
                                  onPressed: () async {
                                    await SigneToutDeSuite(context, _signaturePadKey).then((value) async {
                                      try{
                                        final x  =  await _signaturePadKey.currentState!.toImage();
                                        final y = await x.toByteData(format: ui.ImageByteFormat.png);
                                        if (y != null)snapshot.data![0] = y.buffer.asUint8List();
                                        setState(() {
                                          signatures = Future(() => snapshot.data!);
                                        });
                                      }catch(e){
                                        log(e.toString());
                                      }
                                    });
                                  }),
                            ],
                        );
                      } else
                        return const CircularProgressIndicator();
                    }),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    controller: nomResponsableHop,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nom de l\'IAO à l\'hôpital',
                    ),
                  )),
                FutureBuilder<List<Uint8List>>(
                    future: signatures, // a previously-obtained Future<String> or null
                    builder: (BuildContext context, AsyncSnapshot<List<Uint8List>> snapshot) {
                      if (snapshot.hasData && snapshot.data!=null)
                        return Column(
                          children: [
                            Image.memory(snapshot.data![1].buffer.asUint8List(),height: 200,
                            ),
                            ElevatedButton(
                                child: const Text("Modifier"),
                                onPressed: () async {
                                  await SigneToutDeSuite(context, _signaturePadKeyHop).then((value) async {
                                    try{
                                      final x  =  await _signaturePadKeyHop.currentState!.toImage();
                                      final y = await x.toByteData(format: ui.ImageByteFormat.png);
                                      if (y != null)snapshot.data![1] = y.buffer.asUint8List();
                                      setState(() {
                                        signatures = Future(() => snapshot.data!);
                                      });
                                    }catch(e){
                                      log(e.toString());
                                    }
                                  });
                                }),
                          ],
                        );
                      else
                        return const CircularProgressIndicator();
                    }),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: materiel,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Matériel à récupérer',
                    ),
                  )),
                ]),
                ExpansionTile(
                    title: const Text('Décharge de responsabilité'),
                    textColor: Colors.green[200],
                    collapsedTextColor: Colors.black,
                    collapsedBackgroundColor: Colors.green[200],
                    iconColor: Colors.black,
                    children: <Widget>[
                      const Text("Étant entièrement et clairement informé(e) de mon état et des risques que j’encours, je déclare à"),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
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
                      )),
                      const Text("Refuser:"),
                      Column(
                        children: [
                          ListTile(
                            title: const Text('la prise en charge'),
                            leading: Radio<int>(
                              value: 0,
                              groupValue: prise_charge,
                              onChanged: (int? value) {
                                setState(() {
                                  enr = false;
                                  prise_charge = value??-1;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('mon transport en milieu hospitalier'),
                            leading: Radio<int>(
                              value: 1,
                              groupValue: prise_charge,
                              onChanged: (int? value) {
                                setState((){
                                  enr = false;
                                  prise_charge= value??-1;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                          title: const Text('Consentement victime'),
                          textColor: Colors.red[200],
                          collapsedTextColor: Colors.black,
                          collapsedBackgroundColor: Colors.red[200],
                          iconColor: Colors.black,
                          children: <Widget>[
                            Padding(padding:const EdgeInsets.all(4),child: TextField(
                              onChanged: (text){setState(() {
                                enr = false;
                              }); },
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: nomV,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Nom',
                              ),
                            )),
                            Padding(padding:const EdgeInsets.all(4),child: TextField(
                              onChanged: (text){setState(() {
                                enr = false;
                              }); },
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: prenomV,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Prenom',
                              ),
                            )),
                            Padding(padding:const EdgeInsets.all(4),child: TextField(
                              onChanged: (text){setState(() {
                                enr = false;
                              }); },
                              controller: dateV,
                              readOnly: true,  // when true user cannot edit text
                              onTap: () async {
                                _selectDate(context, dateV);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'date de naissance',
                              ),
                            )),
                            FutureBuilder<List<Uint8List>>(
                              future: signatures, // a previously-obtained Future<String> or null
                              builder: (BuildContext context, AsyncSnapshot<List<Uint8List>> snapshot) {
                                if (snapshot.hasData && snapshot.data!=null)
                                  return Column(
                                    children: [
                                      Image.memory(snapshot.data![2].buffer.asUint8List(),height: 200,
                                      ),
                                      ElevatedButton(
                                        child: const Text("Modifier"),
                                        onPressed: () async {
                                          await SigneToutDeSuite(context, _signaturePadKeyV).then((value) async {
                                            try{
                                              final x  =  await _signaturePadKeyV.currentState!.toImage();
                                              final y = await x.toByteData(format: ui.ImageByteFormat.png);
                                              if (y != null)snapshot.data![2] = y.buffer.asUint8List();
                                              setState(() {
                                                signatures = Future(() => snapshot.data!);
                                              });
                                            }catch(e){
                                              log(e.toString());
                                            }
                                          });
                                        }),
                                    ],
                                  );
                                else
                                  return const CircularProgressIndicator();
                              }),
                          ]),
                      ExpansionTile(
                          title: const Text('Témoins 1'),
                          textColor: Colors.red[200],
                          collapsedTextColor: Colors.black,
                          collapsedBackgroundColor: Colors.red[200],
                          iconColor: Colors.black,
                          children: <Widget>[
                            Padding(padding:const EdgeInsets.all(4),child: TextField(
                              onChanged: (text){setState(() {
                                enr = false;
                              }); },
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: nomT1,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Nom',
                              ),
                            )),
                            Padding(padding:const EdgeInsets.all(4),child: TextField(
                              onChanged: (text){setState(() {
                                enr = false;
                              }); },
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: prenomT1,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Prenom',
                              ),
                            )),
                            Padding(padding:const EdgeInsets.all(4),child: TextField(
                              onChanged: (text){setState(() {
                                enr = false;
                              }); },
                              controller: dateT1,
                              readOnly: true,  // when true user cannot edit text
                              onTap: () async {
                                _selectDate(context, dateT1);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'date de naissance',
                              ),
                            )),
                            FutureBuilder<List<Uint8List>>(
                              future: signatures, // a previously-obtained Future<String> or null
                              builder: (BuildContext context, AsyncSnapshot<List<Uint8List>> snapshot) {
                                if (snapshot.hasData && snapshot.data!=null)
                                  return Column(
                                    children: [
                                      Image.memory(snapshot.data![3].buffer.asUint8List(),height: 200,
                                      ),
                                      ElevatedButton(
                                          child: const Text("Modifier"),
                                          onPressed: () async {
                                            await SigneToutDeSuite(context, _signaturePadKeyT1).then((value) async {
                                              try{
                                                final x  =  await _signaturePadKeyT1.currentState!.toImage();
                                                final y = await x.toByteData(format: ui.ImageByteFormat.png);
                                                if (y != null)snapshot.data![3] = y.buffer.asUint8List();
                                                setState(() {
                                                  signatures = Future(() => snapshot.data!);
                                                });
                                              }catch(e){
                                                log(e.toString());
                                              }
                                            });
                                          }),
                                    ],
                                  );
                                else
                                  return const CircularProgressIndicator();
                              }),
                          ]),
                      ExpansionTile(
                          title: const Text('Témoins 2'),
                          textColor: Colors.red[200],
                          collapsedTextColor: Colors.black,
                          collapsedBackgroundColor: Colors.red[200],
                          iconColor: Colors.black,
                          children: <Widget>[
                            Padding(padding:const EdgeInsets.all(4),child: TextField(
                              onChanged: (text){setState(() {
                                enr = false;
                              }); },
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: nomT2,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Nom',
                              ),
                            )),
                            Padding(padding:const EdgeInsets.all(4),child: TextField(
                              onChanged: (text){setState(() {
                                enr = false;
                              }); },
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: prenomT2,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Prenom',
                              ),
                            )),
                            Padding(padding:const EdgeInsets.all(4),child: TextField(
                              onChanged: (text){setState(() {
                                enr = false;
                              }); },
                              controller: dateT2,
                              readOnly: true,  // when true user cannot edit text
                              onTap: () async {
                                _selectDate(context, dateT2);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'date de naissance',
                              ),
                            )),
                            FutureBuilder<List<Uint8List>>(
                              future: signatures, // a previously-obtained Future<String> or null
                              builder: (BuildContext context, AsyncSnapshot<List<Uint8List>> snapshot) {
                                if (snapshot.hasData && snapshot.data!=null)
                                  return Column(
                                    children: [
                                      Image.memory(snapshot.data![4].buffer.asUint8List(),height: 200,
                                      ),
                                      ElevatedButton(
                                          child: const Text("Modifier"),
                                          onPressed: () async {
                                            await SigneToutDeSuite(context, _signaturePadKeyT2).then((value) async {
                                              try{
                                                final x  =  await _signaturePadKeyT2.currentState!.toImage();
                                                final y = await x.toByteData(format: ui.ImageByteFormat.png);
                                                if (y != null)snapshot.data![4] = y.buffer.asUint8List();
                                                setState(() {
                                                  signatures = Future(() => snapshot.data!);
                                                });
                                              }catch(e){
                                                log(e.toString());
                                              }
                                            });
                                          }),
                                    ],
                                  );
                                else
                                  return const CircularProgressIndicator();
                              }),
                          ]),
                    ]),
                ExpansionTile(
                    title: const Text('Pointage'),
                    textColor: Colors.grey[300],
                    collapsedTextColor: Colors.black,
                    collapsedBackgroundColor: Colors.grey[300],
                    iconColor: Colors.black,
                    children: <Widget>[
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: heure_poste,
                        readOnly: true,  // when true user cannot edit text
                        onTap: () async {
                          await displayTimePicker(context, heure_poste);
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Déplacé vers poste à',
                        ),
                      )),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: heure_renforts,
                        readOnly: true,  // when true user cannot edit text
                        onTap: () async {
                          await displayTimePicker(context, heure_renforts);
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Arrivée des renforts à',
                        ),
                      )),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: heure_medicalisation,
                        readOnly: true,  // when true user cannot edit text
                        onTap: () async {
                          await displayTimePicker(context, heure_medicalisation);
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Médicalisation à',
                        ),
                      )),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: heure_evacuation,
                        readOnly: true,  // when true user cannot edit text
                        onTap: () async {
                          await displayTimePicker(context, heure_evacuation);
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Evacuation à ',
                        ),
                      )),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: heure_hopital,
                        readOnly: true,  // when true user cannot edit text
                        onTap: () async {
                          await displayTimePicker(context, heure_hopital);
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Arrivée à l\'hôpital',
                        ),
                      )),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: heure_fin,
                        readOnly: true,  // when true user cannot edit text
                        onTap: () async {
                          await displayTimePicker(context, heure_fin);
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Fin d\'intervention à ',
                        ),
                      )),
                    ]),
                ExpansionTile(
                    title: const Text('Issue'),
                    textColor: Colors.green[200],
                    collapsedTextColor: Colors.black,
                    collapsedBackgroundColor: Colors.green[200],
                    children: <Widget>[
                      CheckboxListTile(
                        title: const Text("LSP"),
                        contentPadding: const EdgeInsets.all(0),
                        value: LSP,
                        onChanged: (vla) {
                          setState(() {
                            enr = false;
                            LSP = vla??false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      CheckboxListTile(
                        title: const Text("DCD"),
                        contentPadding: const EdgeInsets.all(0),
                        value: DCD,
                        onChanged: (vla) {
                          setState(() {
                            enr = false;
                            DCD = vla??false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      CheckboxListTile(
                        title: const Text("EVAC"),
                        contentPadding: const EdgeInsets.all(0),
                        value: EVAC,
                        onChanged: (vla) {
                          setState(() {
                            enr = false;
                            EVAC = vla??false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      CheckboxListTile(
                        title: const Text("17"),
                        contentPadding: const EdgeInsets.all(0),
                        value: dixsept,
                        onChanged: (vla) {
                          setState(() {
                            enr = false;
                            dixsept = vla??false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      CheckboxListTile(
                        title: const Text("15"),
                        contentPadding: const EdgeInsets.all(0),
                        value: quinze,
                        onChanged: (vla) {
                          setState(() {
                            enr = false;
                            quinze = vla??false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      CheckboxListTile(
                        title: const Text("18"),
                        contentPadding: const EdgeInsets.all(0),
                        value: dixhuit,
                        onChanged: (vla) {
                          setState(() {
                            enr = false;
                            dixhuit = vla??false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                    ]),
              ]
          ));
    }else{
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Chargement...'),
            ),
            Chargement(controller: _controller)
          ],
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context, TextEditingController date) async {
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
        lastDate: DateTime(2101));
    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        selectedDate = picked;
        date.text = formattedDate.toString();
      });
    }
  }

  Future displayTimePicker(BuildContext context, TextEditingController heureC) async {
    TimeOfDay heure;
    if (heureC.text!=""){
      print(heureC.text);
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

  Future SigneToutDeSuite(context, GlobalKey<SfSignaturePadState> sig) async {
    return await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Signature'),
            content: SizedBox(
              height: 70.5,
              width: 200,
              child: SfSignaturePad(
                key: sig,
                backgroundColor: Colors.grey[200],
              ),
            ),
            actions: <Widget>[
              TextButton(onPressed: ()=>sig.currentState!.clear(), child: const Text('Effacer')),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Valider'),
                onPressed: (){
                    Navigator.pop(context);
                  }
              ),
            ],
          );
        }
    );
  }

  litFichier() async{
    PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
    final docIm = await pdi.PdfDocument.openFile(widget.chemin);
    prefs = await SharedPreferences.getInstance();
    setState(() {
      nomResponsable.text  = (doc.form.fields[prefs.getInt("nom_responsable")??0] as PdfTextBoxField).text;
      nomResponsableHop.text  = (doc.form.fields[prefs.getInt("nom_IAO")??0] as PdfTextBoxField).text;
      materiel.text  = (doc.form.fields[prefs.getInt("materiel")??0] as PdfTextBoxField).text;
      heure.text = (doc.form.fields[prefs.getInt("heure_resp")??0] as PdfTextBoxField).text;
      prise_charge = (doc.form.fields[prefs.getInt("prise_charge")??0] as PdfRadioButtonListField).selectedIndex;
      nomV.text = (doc.form.fields[prefs.getInt("nom_v")??0] as PdfTextBoxField).text;
      prenomV.text = (doc.form.fields[prefs.getInt("prenom_v")??0] as PdfTextBoxField).text;
      dateV.text = (doc.form.fields[prefs.getInt("date_v")??0] as PdfTextBoxField).text;
      nomT1.text = (doc.form.fields[prefs.getInt("nom_t1")??0] as PdfTextBoxField).text;
      prenomT1.text = (doc.form.fields[prefs.getInt("prenom_t1")??0] as PdfTextBoxField).text;
      dateT1.text = (doc.form.fields[prefs.getInt("date_t1")??0] as PdfTextBoxField).text;
      nomT2.text = (doc.form.fields[prefs.getInt("nom_t2")??0] as PdfTextBoxField).text;
      prenomT2.text = (doc.form.fields[prefs.getInt("prenom_t2")??0] as PdfTextBoxField).text;
      dateT2.text = (doc.form.fields[prefs.getInt("date_t2")??0] as PdfTextBoxField).text;
      heure_poste.text = (doc.form.fields[prefs.getInt("heure_poste")??0] as PdfTextBoxField).text;
      heure_renforts.text = (doc.form.fields[prefs.getInt("heure_renforts")??0] as PdfTextBoxField).text;
      heure_medicalisation.text = (doc.form.fields[prefs.getInt("heure_medicalisation")??0] as PdfTextBoxField).text;
      heure_evacuation.text = (doc.form.fields[prefs.getInt("heure_evacuation")??0] as PdfTextBoxField).text;
      heure_hopital.text = (doc.form.fields[prefs.getInt("heure_hopital")??0] as PdfTextBoxField).text;
      heure_fin.text = (doc.form.fields[prefs.getInt("heure_fin")??0] as PdfTextBoxField).text;
      LSP = (doc.form.fields[prefs.getInt("LSP")??0] as PdfCheckBoxField).isChecked;
      DCD = (doc.form.fields[prefs.getInt("DCD")??0] as PdfCheckBoxField).isChecked;
      EVAC = (doc.form.fields[prefs.getInt("EVAC")??0] as PdfCheckBoxField).isChecked;
      dixsept = (doc.form.fields[prefs.getInt("17")??0] as PdfCheckBoxField).isChecked;
      quinze = (doc.form.fields[prefs.getInt("15")??0] as PdfCheckBoxField).isChecked;
      dixhuit = (doc.form.fields[prefs.getInt("18")??0] as PdfCheckBoxField).isChecked;
    });
    final List<Uint8List> truc = [];
    for(int i =0; i<5;i++){
      PdfSignatureField field = (doc.form.fields[prefs.getInt("Signature_${i+1}")??0] as PdfSignatureField);
      final coef = doc.pages[0].size.width~/field.bounds.width;
      await docIm.getPage(1).then(
              (value) => value.render(x:field.bounds.left.toInt()*coef, y:field.bounds.top.toInt()*coef,fullHeight: doc.pages[0].size.height*coef, fullWidth: doc.pages[0].size.width*coef, width:field.bounds.width.toInt()*coef,height:field.bounds.height.toInt()*coef)
              .then((imgPDF) => imgPDF.createImageDetached()
              .then((img) => img.toByteData(format: ImageByteFormat.png))
              .then((imgButes) => truc.add(imgButes!.buffer.asUint8List()))
          )
      );
    }
    signatures = Future(() =>  truc);
    setState(() {
      future = "ok";
    });
  }

  metChampsAJour() async {
    PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
    (doc.form.fields[prefs.getInt("nom_responsable")??0] as PdfTextBoxField).text = nomResponsable.text;
    (doc.form.fields[prefs.getInt("nom_IAO")??0] as PdfTextBoxField).text = nomResponsableHop.text;
    (doc.form.fields[prefs.getInt("materiel")??0] as PdfTextBoxField).text = materiel.text;
    (doc.form.fields[prefs.getInt("heure_resp")??0] as PdfTextBoxField).text = heure.text;
    (doc.form.fields[prefs.getInt("prise_charge")??0] as PdfRadioButtonListField).selectedIndex = prise_charge;
    (doc.form.fields[prefs.getInt("nom_v")??0] as PdfTextBoxField).text = nomV.text;
    (doc.form.fields[prefs.getInt("prenom_v")??0] as PdfTextBoxField).text = prenomV.text;
    (doc.form.fields[prefs.getInt("date_v")??0] as PdfTextBoxField).text = dateV.text;
    (doc.form.fields[prefs.getInt("nom_t1")??0] as PdfTextBoxField).text = nomT1.text;
    (doc.form.fields[prefs.getInt("prenom_t1")??0] as PdfTextBoxField).text = prenomT1.text;
    (doc.form.fields[prefs.getInt("date_t1")??0] as PdfTextBoxField).text = dateT1.text;
    (doc.form.fields[prefs.getInt("nom_t2")??0] as PdfTextBoxField).text = nomT2.text;
    (doc.form.fields[prefs.getInt("prenom_t2")??0] as PdfTextBoxField).text = prenomT2.text;
    (doc.form.fields[prefs.getInt("date_t2")??0] as PdfTextBoxField).text = dateT2.text;
    (doc.form.fields[prefs.getInt("heure_poste")??0] as PdfTextBoxField).text = heure_poste.text;
    (doc.form.fields[prefs.getInt("heure_renforts")??0] as PdfTextBoxField).text = heure_renforts.text;
    (doc.form.fields[prefs.getInt("heure_medicalisation")??0] as PdfTextBoxField).text = heure_medicalisation.text;
    (doc.form.fields[prefs.getInt("heure_evacuation")??0] as PdfTextBoxField).text = heure_evacuation.text;
    (doc.form.fields[prefs.getInt("heure_hopital")??0] as PdfTextBoxField).text = heure_hopital.text;
    (doc.form.fields[prefs.getInt("heure_fin")??0] as PdfTextBoxField).text = heure_fin.text;
    (doc.form.fields[prefs.getInt("LSP")??0] as PdfCheckBoxField).isChecked = LSP;
    (doc.form.fields[prefs.getInt("DCD")??0] as PdfCheckBoxField).isChecked = DCD;
    (doc.form.fields[prefs.getInt("EVAC")??0] as PdfCheckBoxField).isChecked = EVAC;
    (doc.form.fields[prefs.getInt("17")??0] as PdfCheckBoxField).isChecked = dixsept;
    (doc.form.fields[prefs.getInt("15")??0] as PdfCheckBoxField).isChecked = quinze;
    (doc.form.fields[prefs.getInt("18")??0] as PdfCheckBoxField).isChecked = dixhuit;
    final sig = await signatures;
    for(int i =0; i<sig.length;i++){
      try {
        PdfSignatureField field = (doc.form.fields[prefs.getInt("Signature_${i + 1}") ?? 0] as PdfSignatureField);
        doc.pages[0].graphics.drawImage(
            PdfBitmap(sig[i]), Rect.fromLTWH(
            field.bounds.left, field.bounds.top, field.bounds.width,
            field.bounds.height));
      }catch(e){
        log(e.toString());
      }
    }
    Officiant().enregistreFichier(widget.chemin, doc).then((value) => {
      if (value)ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enregistré !"),))
      else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Une erreur est survenue :/"),))
    });
    setState(() {
      enr = true;
    });
  }
}