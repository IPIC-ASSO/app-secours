import 'package:app_secours/Officiant.dart';
import 'package:app_secours/menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class Responsabilites extends StatefulWidget {

  String chemin;

  Responsabilites({super.key, required this.chemin});

  @override
  State<Responsabilites> createState() => _ResponsabilitesState();
}

class _ResponsabilitesState extends State<Responsabilites> {

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
  int prise_charge = -1;
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
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  GlobalKey<SfSignaturePadState> _signaturePadKeyHop = GlobalKey();
  GlobalKey<SfSignaturePadState> _signaturePadKeyV = GlobalKey();
  GlobalKey<SfSignaturePadState> _signaturePadKeyT1 = GlobalKey();
  GlobalKey<SfSignaturePadState> _signaturePadKeyT2 = GlobalKey();
  ScrollPhysics controlesKrol = AlwaysScrollableScrollPhysics();


  @override
  void initState() {
    litFichier();
    super.initState();
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
    if (future !=null && future == "ok"){
      return Padding(
          padding: const EdgeInsets.fromLTRB(3,8,3,3),
          child:ListView(
            physics: controlesKrol,
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
                  Column(
                    children: [
                      Text(modification[modif]),
                      InkWell(
                      onLongPress: ()=>setState(() {
                        modif = 1;
                        controlesKrol = NeverScrollableScrollPhysics();
                      }),
                      child:Container(
                        child: SfSignaturePad(
                          onDrawEnd:(){setState(() {
                            modif = 0;
                            controlesKrol = AlwaysScrollableScrollPhysics();
                          });},
                          key: _signaturePadKey,
                          backgroundColor: Colors.grey[200],
                        ),
                        height: 200,
                        width: 300,
                      ),
                    ),
                    ElevatedButton(
                        child: Text("Effacer la signature"),
                        onPressed: () async {
                          _signaturePadKey.currentState!.clear();
                        }),
                    ],
                  ),
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
                  Column(
                    children: [
                      Text(modification[modifhop]),
                      GestureDetector(
                        onLongPress: ()=>setState(() {
                          modifhop = 1;
                          controlesKrol = NeverScrollableScrollPhysics();
                        }),
                        child:Container(
                          child: SfSignaturePad(
                            onDrawEnd:(){setState(() {
                              modifhop = 0;
                              controlesKrol = AlwaysScrollableScrollPhysics();
                            });},
                            key: _signaturePadKeyHop,
                            backgroundColor: Colors.grey[200],
                          ),
                          height: 200,
                          width: 300,
                        ),
                      ),
                      ElevatedButton(
                          child: Text("Effacer la signature"),
                          onPressed: () async {
                            _signaturePadKeyHop.currentState!.clear();
                          }),
                    ],
                  ),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: materiel,
                    decoration: const InputDecoration(
                      border: const OutlineInputBorder(),
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
                      Text("Étant entièrement et clairement informé(e) de mon état et des risques que j’encours, je déclare à"),
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
                      Text("Refuser:"),
                      Column(
                        children: [
                          ListTile(
                            title: const Text('la prise en charge'),
                            leading: Radio<int>(
                              value: 0,
                              groupValue: prise_charge,
                              toggleable: true,
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
                              toggleable: true,
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
                                border: const OutlineInputBorder(),
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
                                border: const OutlineInputBorder(),
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
                            Column(
                              children: [
                                Text(modification[modifV]),
                                GestureDetector(
                                  onLongPress: ()=>setState(() {
                                    modifV = 1;
                                    controlesKrol = NeverScrollableScrollPhysics();
                                  }),
                                  child:Container(
                                    child: SfSignaturePad(
                                      onDrawEnd:(){setState(() {
                                        modifV = 0;
                                        controlesKrol = AlwaysScrollableScrollPhysics();
                                      });},
                                      key: _signaturePadKeyV,
                                      backgroundColor: Colors.grey[200],
                                    ),
                                    height: 200,
                                    width: 300,
                                  ),
                                ),
                                ElevatedButton(
                                    child: Text("Effacer la signature"),
                                    onPressed: () async {
                                      _signaturePadKeyV.currentState!.clear();
                                    }),
                              ],
                            ),
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
                                border: const OutlineInputBorder(),
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
                                border: const OutlineInputBorder(),
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
                            Column(
                              children: [
                                Text(modification[modifT1]),
                                GestureDetector(
                                  onLongPress: ()=>setState(() {
                                    modifT1 = 1;
                                    controlesKrol = NeverScrollableScrollPhysics();
                                  }),
                                  child:Container(
                                    child: SfSignaturePad(
                                      onDrawEnd:(){setState(() {
                                        modifT1 = 0;
                                        controlesKrol = AlwaysScrollableScrollPhysics();
                                      });},
                                      key: _signaturePadKeyT1,
                                      backgroundColor: Colors.grey[200],
                                    ),
                                    height: 200,
                                    width: 300,
                                  ),
                                ),
                                ElevatedButton(
                                    child: Text("Effacer la signature"),
                                    onPressed: () async {
                                      _signaturePadKeyT1.currentState!.clear();
                                    }),
                              ],
                            ),
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
                                border: const OutlineInputBorder(),
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
                                border: const OutlineInputBorder(),
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
                            Column(
                              children: [
                                Text(modification[modifT2]),
                                GestureDetector(
                                  onLongPress: ()=>setState(() {
                                    modifT2 = 1;
                                    controlesKrol = NeverScrollableScrollPhysics();
                                  }),
                                  child:Container(
                                    child: SfSignaturePad(
                                      onDrawEnd:(){setState(() {
                                        modifT2 = 0;
                                        controlesKrol = AlwaysScrollableScrollPhysics();
                                      });},
                                      key: _signaturePadKeyT2,
                                      backgroundColor: Colors.grey[200],
                                    ),
                                    height: 200,
                                    width: 300,
                                  ),
                                ),
                                ElevatedButton(
                                    child: Text("Effacer la signature"),
                                    onPressed: () async {
                                      _signaturePadKeyT2.currentState!.clear();
                                    }),
                              ],
                            ),
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
                          await displayTimePicker(context, heure);
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
                          await displayTimePicker(context, heure);
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
                          await displayTimePicker(context, heure);
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
                          await displayTimePicker(context, heure);
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
                          await displayTimePicker(context, heure);
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
                          await displayTimePicker(context, heure);
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Fin d\'intervention à ',
                        ),
                      )),
                    ]),
                ExpansionTile(
                    title: const Text('truc'),
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
          children: const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Chargement...'),
            ),
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
        heureC.text = "${time.hour}:${time.minute}";
      });
    }
  }

  Future<String> litFichier2()async{
    //Isolate.spawn(litFichier,"ok");
    return ("ok");
  }

  litFichier()async{
    PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
    setState(() {
      /*dispositif.text = (doc.form.fields[120] as PdfTextBoxField).text;
      numeros.text = (doc.form.fields[121] as PdfTextBoxField).text;
      equipe.text = (doc.form.fields[122] as PdfTextBoxField).text;
      date.text = (doc.form.fields[123] as PdfTextBoxField).text;
      heure.text = (doc.form.fields[124] as PdfTextBoxField).text;
      num_dispositif.text =(doc.form.fields[125] as PdfTextBoxField).text;
      motif.text = (doc.form.fields[126] as PdfTextBoxField).text;
      adresse.text = (doc.form.fields[127] as PdfTextBoxField).text;
      depart_equipe.text = (doc.form.fields[128] as PdfTextBoxField).text;
      heure_depart.text = (doc.form.fields[129] as PdfTextBoxField).text;
      sur_lieux.text = (doc.form.fields[130] as PdfTextBoxField).text;*/
    });
    setState(() {
      future = "ok";
    });
  }

  metChampsAJour() async {/*
    PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
    for (var x = 0; x<doc.form.fields.count; x++)print(doc.form.fields[x].name);
    (doc.form.fields[120] as PdfTextBoxField).text = dispositif.text;
    (doc.form.fields[121] as PdfTextBoxField).text = numeros.text;
    (doc.form.fields[122] as PdfTextBoxField).text = equipe.text;
    (doc.form.fields[123] as PdfTextBoxField).text = date.text;
    (doc.form.fields[124] as PdfTextBoxField).text = heure.text;
    (doc.form.fields[125] as PdfTextBoxField).text = num_dispositif.text;
    (doc.form.fields[126] as PdfTextBoxField).text = motif.text;
    (doc.form.fields[127] as PdfTextBoxField).text = adresse.text;
    (doc.form.fields[128] as PdfTextBoxField).text = depart_equipe.text;
    (doc.form.fields[129] as PdfTextBoxField).text = heure_depart.text;
    (doc.form.fields[130] as PdfTextBoxField).text = sur_lieux.text;
    if(await enregistre()){
      Officiant().enregistreFichier(widget.chemin, doc).then((value) => {
        if (value)ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enregistré !"),))
        else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Une erreur est survenue :/"),))
      });
    }
    setState(() {
      enr = true;
    });*/
  }

  Future<bool>enregistre()async{
    if (widget.chemin == ""){
      TextEditingController nomPdf = TextEditingController();
      await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Enregistrer'),
            content: ListView(shrinkWrap:true,children: [
              const Padding(padding: EdgeInsets.all(5),
                  child:Text('Comment souhaitez vous appeler le pdf?')),
              TextField(
                controller: nomPdf,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'nom',
                ),
              )
            ]),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () async {
                    String x = await Officiant().nouveauChemin(nomPdf.text);
                    if (x =="0"){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Un fichier du même nom existe déjà"),));return;};
                    if( x == "1")ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enregistrement impossible"),));
                    if (x!="1"&& x!="0")widget.chemin = x;
                    Navigator.pop(_);
                  },
                  child: const Text('Enregistrer')),
            ],
            elevation: 24,
          ),
          barrierDismissible: false);
    }
    return true;
  }
}