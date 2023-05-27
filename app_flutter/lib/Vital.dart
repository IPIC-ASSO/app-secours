import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:app_secours/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'Officiant.dart';

class Vital extends StatefulWidget {

  String chemin;

  Vital({super.key, required this.chemin});

  @override
  State<Vital> createState() => _VitalState();
}

class _VitalState extends State<Vital> {

  //VITAL 1
  bool montre_1 = false;
  bool montre_2 = false;
  bool montre_3 = false;
  bool enr = true;
  String future = "";
  bool arreter = false;
  bool pansement_imb = false;
  bool garrot = false;
  bool rechauffe = false;
  bool allonge = false;
  TextEditingController heure_Hemo  = TextEditingController();
  bool tape_dos = false;
  bool compression = false;
  bool retournement = false;
  bool casque = false;
  bool bascule = false;
  bool elevation_menton = false;
  bool LVA = false;
  bool neutre = false;
  int respiration = -1;
  bool insufl = false;
  bool aspi = false;
  int circulation = -1;
  bool massage = false;
  bool DAE = false;
  TextEditingController heure_choc1  = TextEditingController();
  TextEditingController heure_choc2  = TextEditingController();
  TextEditingController heure_choc3  = TextEditingController();
  TextEditingController heure_choc4  = TextEditingController();
  int neurologique = -1;
  bool PLS = false;
  //VITAL 2
  bool liberation = false;
  bool aspiration = false;
  TextEditingController signe_detresse_1  = TextEditingController();
  TextEditingController signe_detresse_2  = TextEditingController();
  TextEditingController signe_detresse_3  = TextEditingController();
  //VITAL 3
  TextEditingController mvt_frequence  = TextEditingController();
  TextEditingController pauses  = TextEditingController();
  TextEditingController saturation  = TextEditingController();
  bool ambiant = false;
  int type_respiration = -1;
  TextEditingController bat_frequence  = TextEditingController();
  TextEditingController amplitude  = TextEditingController();
  TextEditingController tension  = TextEditingController();
  TextEditingController tension_habituelle  = TextEditingController();
  bool repos = false;
  bool recolore = false;



  @override
  void initState() {
    litFichier();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vital'),
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
      return ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text('VITAL 1'),
            textColor: Colors.red,
            collapsedTextColor: Colors.black,
            collapsedBackgroundColor: Colors.red,
            iconColor: Colors.black,
            children: <Widget>[
              ExpansionTile(
                title: Text('X Hémorragie'),
                textColor: Colors.red[200],
                collapsedTextColor: Colors.black,
                collapsedBackgroundColor: Colors.red[200],
                iconColor: Colors.black,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: CheckboxListTile(
                      title: const Text("Arrêter", softWrap: true,),
                      contentPadding: const EdgeInsets.all(0),
                      value: arreter,
                      onChanged: (vla) {
                        setState(() {
                            enr = false;
                            arreter = vla??false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: CheckboxListTile(
                      title: const Text("Pansement imbibé", softWrap: true,),
                      contentPadding: const EdgeInsets.all(0),
                      value: pansement_imb,
                      onChanged: (vla) {
                        setState(() {
                          enr = false;
                          pansement_imb = vla??false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: CheckboxListTile(
                      title: const Text("Garrot", softWrap: true,),
                      contentPadding: const EdgeInsets.all(0),
                      value: garrot,
                      onChanged: (vla) {
                        setState(() {
                          enr = false;
                          garrot = vla??false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: CheckboxListTile(
                      title: const Text("Réchauffer", softWrap: true,),
                      contentPadding: const EdgeInsets.all(0),
                      value: rechauffe,
                      onChanged: (vla) {
                        setState(() {
                          enr = false;
                          allonge = vla??false;
                        });
                      },
                    ),
                  ),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                          onChanged: (text){setState(() {
                            enr = false;
                          }); },
                          controller: heure_Hemo,
                          readOnly: true,  // when true user cannot edit text
                          onTap: () async {
                            await displayTimePicker(context, heure_Hemo);
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'heure',
                          ),
                        )
                  )
              ],
              ),
              ExpansionTile(
                title: Text('A Voies aériennes'),
                textColor: Colors.blue[200],
                collapsedTextColor: Colors.black,
                collapsedBackgroundColor: Colors.blue[200],
                iconColor: Colors.black,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: CheckboxListTile(
                      title: const Text("Tapes dos", softWrap: true,),
                      contentPadding: const EdgeInsets.all(0),
                      value: tape_dos,
                      onChanged: (vla) {
                        setState(() {
                          enr = false;
                          tape_dos = vla??false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: CheckboxListTile(
                      title: const Text("Compressions abdos/thorax", softWrap: true,),
                      contentPadding: const EdgeInsets.all(0),
                      value: compression,
                      onChanged: (vla) {
                        setState(() {
                          enr = false;
                          compression = vla??false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: CheckboxListTile(
                      title: const Text("Retournement", softWrap: true,),
                      contentPadding: const EdgeInsets.all(0),
                      value: retournement,
                      onChanged: (vla) {
                        setState(() {
                          enr = false;
                          retournement = vla??false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: CheckboxListTile(
                      title: const Text("Retrait de casque", softWrap: true,),
                      contentPadding: const EdgeInsets.all(0),
                      value: casque,
                      onChanged: (vla) {
                        setState(() {
                          enr = false;
                          casque = vla??false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: CheckboxListTile(
                      title: const Text("Bascule arrière", softWrap: true,),
                      contentPadding: const EdgeInsets.all(0),
                      value: bascule,
                      onChanged: (vla) {
                        setState(() {
                          enr = false;
                          bascule = vla??false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: CheckboxListTile(
                      title: const Text("Elevation menton", softWrap: true,),
                      contentPadding: const EdgeInsets.all(0),
                      value: elevation_menton,
                      onChanged: (vla) {
                        setState(() {
                          enr = false;
                          elevation_menton = vla??false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: CheckboxListTile(
                      title: const Text("LVA assis", softWrap: true,),
                      contentPadding: const EdgeInsets.all(0),
                      value: LVA,
                      onChanged: (vla) {
                        setState(() {
                          enr = false;
                          LVA = vla??false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: CheckboxListTile(
                      title: const Text("Neutre", softWrap: true,),
                      contentPadding: const EdgeInsets.all(0),
                      value: neutre,
                      onChanged: (vla) {
                        setState(() {
                          enr = false;
                          neutre = vla??false;
                        });
                      },
                    ),
                  ),

                ],
              ),
              ExpansionTile(
                  title: Text('B Respiration'),
                  textColor: Colors.blue[200],
                  collapsedTextColor: Colors.black,
                  collapsedBackgroundColor: Colors.blue[200],
                  iconColor: Colors.black,
                  children: <Widget>[
                    ListTile(
                      title: const Text('Absente'),
                      leading: Radio<int>(
                        value: 0,
                        groupValue: respiration,
                        toggleable: true,
                        onChanged: (int? value) {
                          setState(() {
                            respiration = value??-1;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Anormale'),
                      leading: Radio<int>(
                        value: 1,
                        groupValue: respiration,
                        toggleable: true,
                        onChanged: (int? value) {
                          setState(() {
                            respiration = value??-1;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('< 1 mvt/10s'),
                      leading: Radio<int>(
                        value: 2,
                        groupValue: respiration,
                        toggleable: true,
                        onChanged: (int? value) {
                          setState(() {
                            respiration = value??-1;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: CheckboxListTile(
                        title: const Text("Insuflations", softWrap: true,),
                        contentPadding: const EdgeInsets.all(0),
                        value: insufl,
                        onChanged: (vla) {
                          setState(() {
                            enr = false;
                            insufl = vla??false;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: CheckboxListTile(
                        title: const Text("Aspi. mucosité", softWrap: true,),
                        contentPadding: const EdgeInsets.all(0),
                        value: aspi,
                        onChanged: (vla) {
                          setState(() {
                            enr = false;
                            aspi = vla??false;
                          });
                        },
                      ),
                    ),
                  ]),
              ExpansionTile(
                  title: Text('C Circulation'),
                  textColor: Colors.black,
                  collapsedBackgroundColor: Colors.red[200],
                  iconColor: Colors.black,
                  children: <Widget>[
                    ListTile(
                      title: const Text('Pas de prise'),
                      leading: Radio<int>(
                        value: 0,
                        groupValue: circulation,
                        toggleable: true,
                        onChanged: (int? value) {
                          setState(() {
                            circulation = value??-1;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Poul absent'),
                      leading: Radio<int>(
                        value: 1,
                        groupValue: circulation,
                        toggleable: true,
                        onChanged: (int? value) {
                          setState(() {
                            circulation = value??-1;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Doute'),
                      leading: Radio<int>(
                        value: 2,
                        groupValue: circulation,
                        toggleable: true,
                        onChanged: (int? value) {
                          setState(() {
                            circulation = value??-1;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: CheckboxListTile(
                        title: const Text("Massage cardiaque", softWrap: true,),
                        contentPadding: const EdgeInsets.all(0),
                        value: massage,
                        onChanged: (vla) {
                          setState(() {
                            enr = false;
                            massage = vla??false;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: CheckboxListTile(
                        title: const Text("DAE", softWrap: true,),
                        contentPadding: const EdgeInsets.all(0),
                        value: DAE,
                        onChanged: (vla) {
                          setState(() {
                            enr = false;
                            DAE = vla??false;
                          });
                        },
                      ),
                    ),
                    Row(children: <Widget>[
                      Flexible(flex: 1,child:
                      SizedBox(
                          width: 1000,
                          child:Padding(padding:const EdgeInsets.all(4),child: TextField(
                            onChanged: (text){setState(() {
                              enr = false;
                            }); },
                            controller: heure_choc1,
                            readOnly: true,  // when true user cannot edit text
                            onTap: () async {
                              await displayTimePicker(context, heure_choc1);
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'choc/analyse à:',
                            ),
                          ))
                      ), ),
                      Flexible(flex: 1,child:
                      SizedBox(
                          width: 1000,
                          child:Padding(padding:const EdgeInsets.all(4),child: TextField(
                            onChanged: (text){setState(() {
                              enr = false;
                            }); },
                            controller: heure_choc2,
                            readOnly: true,  // when true user cannot edit text
                            onTap: () async {
                              await displayTimePicker(context, heure_choc2);
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'choc/analyse à:',
                            ),
                          ))
                      ), ),
                    ],
                    ),
                    Row(children: <Widget>[
                      Flexible(flex: 1,child:
                      SizedBox(
                          width: 1000,
                          child:Padding(padding:const EdgeInsets.all(4),child: TextField(
                            onChanged: (text){setState(() {
                              enr = false;
                            }); },
                            controller: heure_choc3,
                            readOnly: true,  // when true user cannot edit text
                            onTap: () async {
                              await displayTimePicker(context, heure_choc3);
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'choc/analyse à:',
                            ),
                          ))
                      ), ),
                      Flexible(flex: 1,child:
                      SizedBox(
                          width: 1000,
                          child:Padding(padding:const EdgeInsets.all(4),child: TextField(
                            onChanged: (text){setState(() {
                              enr = false;
                            }); },
                            controller: heure_choc4,
                            readOnly: true,  // when true user cannot edit text
                            onTap: () async {
                              await displayTimePicker(context, heure_choc4);
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'choc/analyse à:',
                            ),
                          ))
                      ), ),
                    ],
                    ),
                  ]),
              ExpansionTile(
                  title: Text('D Neurologique'),
                  textColor: Colors.green[200],
                  collapsedTextColor: Colors.black,
                  collapsedBackgroundColor: Colors.green[200],
                  iconColor: Colors.black,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkResponse(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.remove_red_eye_outlined,
                              color: neurologique == 0 ? Colors.green : null,
                            ),
                            Text("Ouvre les yeux", style: TextStyle(color: neurologique == 0 ? Colors.green : null)),
                          ],
                        ),
                        onTap: () => setState(() {
                            neurologique !=0?neurologique=0:neurologique=-1;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkResponse(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.chat,
                              color: neurologique == 1 ? Colors.green : null,
                            ),
                            Text("Réponse verbale", style: TextStyle(color: neurologique == 1 ? Colors.green : null)),
                          ],
                        ),
                        onTap: () => setState(() {
                          neurologique !=1?neurologique=1:neurologique=-1;
                        },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkResponse(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.waving_hand,
                              color: neurologique == 2 ? Colors.green : null,
                            ),
                            Text("Réponse motrice", style: TextStyle(color: neurologique == 2 ? Colors.green : null)),
                          ],
                        ),
                        onTap: () => setState(() {
                          neurologique !=2?neurologique=2:neurologique=-1;
                        },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: CheckboxListTile(
                        title: const Text("Massage cardiaque", softWrap: true,),
                        contentPadding: const EdgeInsets.all(0),
                        value: massage,
                        onChanged: (vla) {
                          setState(() {
                            enr = false;
                            massage = vla??false;
                          });
                        },
                      ),
                    ),
                  ]),
            ],
          ),
          ExpansionTile(
            title: Text('VITAL 2'),
            textColor: Colors.red,
            collapsedTextColor: Colors.black,
            collapsedBackgroundColor: Colors.red,
            iconColor: Colors.black,
            children: <Widget>[
              ExpansionTile(
                title: Text('A '),
                textColor: Colors.blue[200],
                collapsedTextColor: Colors.black,
                collapsedBackgroundColor: Colors.blue[200],
                iconColor: Colors.black,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: CheckboxListTile(
                      title: const Text("Libération Voies Aériennes", softWrap: true,),
                      contentPadding: const EdgeInsets.all(0),
                      value: liberation,
                      onChanged: (vla) {
                        setState(() {
                          enr = false;
                          liberation = vla??false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: CheckboxListTile(
                      title: const Text("Aspiration si encombrement", softWrap: true,),
                      contentPadding: const EdgeInsets.all(0),
                      value: aspiration,
                      onChanged: (vla) {
                        setState(() {
                          enr = false;
                          aspiration = vla??false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('B '),
                textColor: Colors.blue[200],
                collapsedTextColor: Colors.black,
                collapsedBackgroundColor: Colors.blue[200],
                iconColor: Colors.black,
                children: <Widget>[
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: signe_detresse_1,
                    decoration: const InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Signes de détresse observés',
                    ),
                  )),
                  Padding(padding: const EdgeInsets.all(4),child:
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(text:"Visuel: ", style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text:'Oedeme (face ou cou), Se tient la poitrine, Cherche à s’asseoir / Refus allongé, Cyanose (doigts / lobe / lèvres), Efforts pour respirer, Sueurs anormales, Contraction (haut du thorax /cou)' ),
                          TextSpan(text:"\nBruits: ", style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text:' Gargouillements (sang, liquide ou vomis), Bruit à l’inspiration, Sifflement expiration' ),
                          TextSpan(text:"\nParole/Attitude: ", style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text:' Confusion, somnolence, anxiété, agitée, Du mal à terminer ses phrases + essouflée' ),
                          TextSpan(text:"\nEnfant: ", style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text:'  Battement des ailes du nez, Creusement du sternum' ),
                        ],
                      ),
                    )
                  )
                ]),
              ExpansionTile(
                  title: Text('C '),
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
                      controller: signe_detresse_1,
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Signes de détresse observés',
                      ),
                    )),
                    Padding(padding: const EdgeInsets.all(4),child:
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(text:"Visuel: ", style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text:' Décoloration de la peau, Pâleur (extrémités / interne paupières / lèvres) Transpiration + Refroidissement , Marbrures blanc violet > genoux ?' ),
                          TextSpan(text:"\nPalpation: ", style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text:'  Radial absent + Carotidien Présent' ),
                          TextSpan(text:"\nParole/Attitude: ", style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text:'  Sensation de soif, Agitation et angoisse de mort, Impossibilité assis ou debout, Apparition de vertiges' ),
                        ],
                      ),
                    )
                    )
                  ]),
              ExpansionTile(
                  title: Text('D '),
                  textColor: Colors.green[200],
                  collapsedTextColor: Colors.black,
                  collapsedBackgroundColor: Colors.green[200],
                  iconColor: Colors.black,
                  children: <Widget>[
                    Padding(padding:const EdgeInsets.all(4),child: TextField(
                      onChanged: (text){setState(() {
                        enr = false;
                      }); },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: signe_detresse_1,
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Signes de détresse observés',
                      ),
                    )),
                    Padding(padding: const EdgeInsets.all(4),child:
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(text:"Visuel: ", style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text:' Visage asymétrique, Paralysie, Somnolence, Convulsions' ),
                          TextSpan(text:"\nParole/Attitude: ", style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text:'  Anomalie de la parole, Désorientée (temps ou espace), Perte de connaissance initiale, Amnésie de l’événement' ),
                        ],
                      ),
                    )
                    )
                  ]),
            ],
          ),
          ExpansionTile(
            title: Text('VITAL 3'),
            children: <Widget>[
              ExpansionTile(
                title: Text('AB'),
                textColor: Colors.blue[200],
                collapsedTextColor: Colors.black,
                collapsedBackgroundColor: Colors.blue[200],
                iconColor: Colors.black,
                children: <Widget>[
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: mvt_frequence,
                    decoration: const InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'mvt/min (fréquence)',
                    ),
                  )),
                  Positioned(child: Align(
                    alignment: Alignment.centerLeft,
                    child:
                  Padding(padding: const EdgeInsets.all(4),child:
                  Text("Adulte: 12 20 Enfant 20 30\nBébé 20 40 Nouv.né 40 60", style: TextStyle(fontStyle: FontStyle.italic))
                    ),
                  )),

                  Padding(padding: const EdgeInsets.all(4),child:
                  Text("Indiquez les pauses > 6 secondes")
                  ),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: pauses,
                    decoration: const InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Amplitude + Régularité',
                    ),
                  )),
                  Row(
                      children:[
                        Padding(padding: const EdgeInsets.all(4),child:
                        Text("%SpO²")
                        ),
                        Expanded(flex: 1,child:
                          SizedBox(
                            width: 1000,
                            child:Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: CheckboxListTile(
                                title: const Text("air ambiant", softWrap: true,),
                                contentPadding: const EdgeInsets.all(0),
                                value: ambiant,
                                onChanged: (vla) {
                                setState(() {
                                  enr = false;
                                  ambiant = vla??false;
                                });
                              },
                            ),
                        ),))

                      ]
                  ),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: saturation,
                    decoration: const InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Saturation',
                    ),
                  )),
                  Row(
                      children: <Widget>[
                        Expanded(
                            child: Divider()
                        ),
                        Text("Respiration"),
                        Expanded(
                            child: Divider()
                        ),
                      ]
                  ),
                  Column(
                    children: [

                    ],
                  )
                ]),
              ExpansionTile(
                  title: Text('C'),
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
                      controller: mvt_frequence,
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'mvt/min (fréquence)',
                      ),
                    )),
                    Positioned(child: Align(
                      alignment: Alignment.centerLeft,
                      child:
                      Padding(padding: const EdgeInsets.all(4),child:
                      Text("Adulte: 12 20 Enfant 20 30\nBébé 20 40 Nouv.né 40 60", style: TextStyle(fontStyle: FontStyle.italic))
                      ),
                    )),

                    Padding(padding: const EdgeInsets.all(4),child:
                    Text("Indiquez les pauses > 6 secondes")
                    ),
                    Padding(padding:const EdgeInsets.all(4),child: TextField(
                      onChanged: (text){setState(() {
                        enr = false;
                      }); },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: pauses,
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Amplitude + Régularité',
                      ),
                    )),
                    Row(
                        children:[
                          Padding(padding: const EdgeInsets.all(4),child:
                          Text("%SpO²")
                          ),
                          Expanded(flex: 1,child:
                          SizedBox(
                            width: 1000,
                            child:Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: CheckboxListTile(
                                title: const Text("air ambiant", softWrap: true,),
                                contentPadding: const EdgeInsets.all(0),
                                value: ambiant,
                                onChanged: (vla) {
                                  setState(() {
                                    enr = false;
                                    ambiant = vla??false;
                                  });
                                },
                              ),
                            ),))

                        ]
                    ),
                    Padding(padding:const EdgeInsets.all(4),child: TextField(
                      onChanged: (text){setState(() {
                        enr = false;
                      }); },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: saturation,
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Saturation',
                      ),
                    )),
                  ]),
            ],
          ),
        ],
      );
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
      /*nomPrenom.text = (doc.form.fields[0] as PdfTextBoxField).text;
      nomFille.text = (doc.form.fields[1] as PdfTextBoxField).text;
      date.text = (doc.form.fields[2] as PdfTextBoxField).text;
      lieuNez.text = (doc.form.fields[3] as PdfTextBoxField).text;
      adresse.text = (doc.form.fields[4] as PdfTextBoxField).text;
      CP.text = (doc.form.fields[5] as PdfTextBoxField).text;
      ville.text = (doc.form.fields[6] as PdfTextBoxField).text;
      tel.text = (doc.form.fields[7] as PdfTextBoxField).text;
      qui.text = (doc.form.fields[8] as PdfTextBoxField).text;
      telQui.text = (doc.form.fields[9] as PdfTextBoxField).text;*/
    });
    setState(() {
      future = "ok";
    });
  }

  metChampsAJour() async {
    /*PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
    (doc.form.fields[0] as PdfTextBoxField).text = nomPrenom.text;
    (doc.form.fields[1] as PdfTextBoxField).text = nomFille.text;
    (doc.form.fields[2] as PdfTextBoxField).text = date.text;
    (doc.form.fields[3] as PdfTextBoxField).text = lieuNez.text;
    (doc.form.fields[4] as PdfTextBoxField).text = adresse.text;
    (doc.form.fields[5] as PdfTextBoxField).text = CP.text;
    (doc.form.fields[6] as PdfTextBoxField).text = ville.text;
    (doc.form.fields[7] as PdfTextBoxField).text = tel.text;
    (doc.form.fields[8] as PdfTextBoxField).text = qui.text;
    (doc.form.fields[9] as PdfTextBoxField).text = telQui.text;
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