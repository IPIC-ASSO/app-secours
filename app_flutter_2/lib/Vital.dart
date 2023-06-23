import 'package:app_secours/charge.dart';
import 'package:app_secours/menu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'Officiant.dart';
import 'dart:math'as m;

class Vital extends StatefulWidget {

  String chemin;

  Vital({super.key, required this.chemin});

  @override
  State<Vital> createState() => _VitalState();
}

class _VitalState extends State<Vital> with TickerProviderStateMixin {
  late AnimationController _controller;
  late final SharedPreferences prefs;
  late PdfDocument doc;
  bool enr = true;
  //VITAL 1
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
  int respiration = 0;
  bool insufl = false;
  bool aspi = false;
  int circulation = 0;
  bool massage = false;
  bool DAE = false;
  TextEditingController heure_choc1  = TextEditingController();
  TextEditingController heure_choc2  = TextEditingController();
  TextEditingController heure_choc3  = TextEditingController();
  TextEditingController heure_choc4  = TextEditingController();
  bool ouvre_y = false;
  bool reponse_v = false;
  bool reponse_m = false;

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
  int type_respiration = 0;
  TextEditingController bat_frequence  = TextEditingController();
  TextEditingController amplitude  = TextEditingController();
  TextEditingController tension  = TextEditingController();
  TextEditingController tension_habituelle  = TextEditingController();
  bool repos = false;
  bool recolore = false;
  TextEditingController oxy  = TextEditingController();
  int pupilles_egales = 0;
  bool areactives_G = false;
  bool areactives_D = false;
  bool dilatees_G = false;
  bool dilatees_D = false;
  bool serrees_G = false;
  bool serrees_D = false;
  bool mains_G = false;
  bool mains_D = false;
  bool bras_G = false;
  bool bras_D = false;
  bool jambe_G = false;
  bool jambe_D = false;
  bool pied_G = false;
  bool pied_D = false;
  int yeux = 0;
  int verbale = 0;
  int motrice = 0;
  List<Color> couleurs = [Colors.green,Colors.orange,Colors.red];
  //autre
  int position = 0;
  TextEditingController position_cplx  = TextEditingController();


  @override
  void initState() {
    litFichier();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this)
      ..addStatusListener((status) {
        if(status == AnimationStatus.completed)_controller.reverse();
        else if(status == AnimationStatus.dismissed)_controller.forward();})
      ..forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    doc.dispose();
    super.dispose();
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
    List<int> codes = [2,1,2,2,0];//0: check; 1:texte; 2:texte nombre; 3
    if (future == "ok"){
      return ListView(
        children: <Widget>[
          ExpansionTile(
            title: const Text('VITAL 1'),
            textColor: Colors.red,
            collapsedTextColor: Colors.black,
            collapsedBackgroundColor: Colors.red,
            iconColor: Colors.black,
            children: <Widget>[
              ExpansionTile(
                title: const Text('X Hémorragie'),
                textColor: Colors.red[200],
                collapsedTextColor: Colors.black,
                collapsedBackgroundColor: Colors.red[200],
                iconColor: Colors.black,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
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
                    padding: const EdgeInsets.only(left: 25),
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
                    padding: const EdgeInsets.only(left: 25),
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
                    padding: const EdgeInsets.only(left: 25),
                    child: CheckboxListTile(
                      title: const Text("Réchauffer", softWrap: true,),
                      contentPadding: const EdgeInsets.all(0),
                      value: rechauffe,
                      onChanged: (vla) {
                        setState(() {
                          enr = false;
                          rechauffe = vla??false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: CheckboxListTile(
                      title: const Text("Allonger", softWrap: true,),
                      contentPadding: const EdgeInsets.all(0),
                      value: allonge,
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
                title: const Text('A Voies aériennes'),
                textColor: Colors.blue[200],
                collapsedTextColor: Colors.black,
                collapsedBackgroundColor: Colors.blue[200],
                iconColor: Colors.black,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
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
                    padding: const EdgeInsets.only(left: 25),
                    child: CheckboxListTile(
                      title: const Text("Compressions abdos/thorac.", softWrap: true,),
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
                    padding: const EdgeInsets.only(left: 25),
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
                    padding: const EdgeInsets.only(left: 25),
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
                    padding: const EdgeInsets.only(left: 25),
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
                    padding: const EdgeInsets.only(left: 25),
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
                    padding: const EdgeInsets.only(left: 25),
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
                    padding: const EdgeInsets.only(left: 25),
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
                  title: const Text('B Respiration'),
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

                        onChanged: (int? value) {
                          setState(() {
                            respiration = value??-1;
                            enr = false;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Anormale'),
                      leading: Radio<int>(
                        value: 1,
                        
                        groupValue: respiration,
                        onChanged: (int? value) {
                          setState(() {
                            respiration = value??-1;
                            enr = false;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('< 1 mvt/10s'),
                      leading: Radio<int>(
                        value: 2,
                        
                        groupValue: respiration,
                        onChanged: (int? value) {
                          setState(() {
                            respiration = value??-1;
                            enr = false;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: CheckboxListTile(
                        title: const Text("Insufflations", softWrap: true,),
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
                      padding: const EdgeInsets.only(left: 25),
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
                  title: const Text('C Circulation'),
                  textColor: Colors.black,
                  collapsedBackgroundColor: Colors.red[200],
                  iconColor: Colors.black,
                  children: <Widget>[
                    ListTile(
                      title: const Text('Pas de prise'),
                      leading: Radio<int>(
                        value: 0,
                        
                        groupValue: circulation,
                        onChanged: (int? value) {
                          setState(() {
                            enr = false;
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
                        onChanged: (int? value) {
                          setState(() {
                            enr = false;
                            circulation = value??-1;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
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
                      padding: const EdgeInsets.only(left: 25),
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
                    ],),
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
                    ],),
                  ]),
              ExpansionTile(
                  title: const Text('D Neurologique'),
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
                              color: ouvre_y ? Colors.green : null,
                            ),
                            Text("Ouvre les yeux", style: TextStyle(color: ouvre_y ? Colors.green : null)),
                          ],
                        ),
                        onTap: () => setState(() {
                            ouvre_y = !ouvre_y;
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
                              color: reponse_v? Colors.green : null,
                            ),
                            Text("Réponse verbale", style: TextStyle(color: reponse_v ? Colors.green : null)),
                          ],
                        ),
                        onTap: () => setState(() {
                          reponse_v = !reponse_v;
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
                              color: reponse_m ? Colors.green : null,
                            ),
                            Text("Réponse motrice", style: TextStyle(color: reponse_m ? Colors.green : null)),
                          ],
                        ),
                        onTap: () => setState(() {
                          reponse_m = !reponse_m;
                        },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: CheckboxListTile(
                        title: const Text("Perte de connaissance -> PLS", softWrap: true,),
                        contentPadding: const EdgeInsets.all(0),
                        value: PLS,
                        onChanged: (vla) {
                          setState(() {
                            enr = false;
                            PLS = vla??false;
                          });
                        },
                      ),
                    ),
                  ]),
            ],
          ),
          ExpansionTile(
            title: const Text('VITAL 2'),
            textColor: Colors.red,
            collapsedTextColor: Colors.black,
            collapsedBackgroundColor: Colors.red,
            iconColor: Colors.black,
            children: <Widget>[
              ExpansionTile(
                title: const Text('A '),
                textColor: Colors.blue[200],
                collapsedTextColor: Colors.black,
                collapsedBackgroundColor: Colors.blue[200],
                iconColor: Colors.black,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
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
                    padding: const EdgeInsets.only(left: 25),
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
                title: const Text('B '),
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
                    maxLines: 3,
                    maxLength: 160,
                    controller: signe_detresse_1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
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
                  title: const Text('C '),
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
                      maxLength: 160,
                      maxLines: 3,
                      controller: signe_detresse_2,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
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
                  title: const Text('D '),
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
                      maxLines: 3,
                      maxLength: 160,
                      controller: signe_detresse_3,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
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
            title: const Text('VITAL 3'),
            textColor: Colors.red,
            collapsedTextColor: Colors.black,
            collapsedBackgroundColor: Colors.red,
            iconColor: Colors.black,
            children: <Widget>[
              ExpansionTile(
                title: const Text('AB'),
                textColor: Colors.blue[200],
                collapsedTextColor: Colors.black,
                collapsedBackgroundColor: Colors.blue[200],
                iconColor: Colors.black,
                children: <Widget>[
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    keyboardType: TextInputType.number,
                    maxLines: null,
                    controller: mvt_frequence,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'mvt/min (fréquence)',
                    ),
                  )),
                   const Align(
                    alignment: Alignment.centerLeft,
                    child:
                    Padding(padding: EdgeInsets.all(4),child:
                      Text("Adulte: 12 20 Enfant 20 30\nBébé 20 40 Nouv.né 40 60", style: TextStyle(fontStyle: FontStyle.italic))
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(4),child:
                  Text("Indiquez les pauses > 6 secondes")
                  ),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    maxLines: null,
                    controller: pauses,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Amplitude + Régularité',
                    ),
                  )),
                  Row(
                      children:[
                        const Padding(padding: EdgeInsets.all(4),child:
                        Text("%SpO²")
                        ),
                        Expanded(flex: 1,child:
                          SizedBox(
                            width: 1000,
                            child:Padding(
                              padding: const EdgeInsets.only(left: 25),
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
                      border: OutlineInputBorder(),
                      labelText: 'Saturation',
                    ),
                  )),
                  Row(
                      children: const <Widget>[
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
                      ListTile(
                        title: const Text('Normale'),
                        subtitle: const Text("silencieuse"),
                        leading: Radio<int>(
                          value: 0,
                          groupValue: type_respiration,
                          
                          onChanged: (int? value) {
                            setState(() {
                              enr = false;
                              type_respiration = value??-1;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Superficielle'),
                        subtitle: const Text("Mvts à peine perceptible (difficile à compter)"),
                        leading: Radio<int>(
                          value: 1,
                          groupValue: type_respiration,
                          
                          onChanged: (int? value) {
                            setState(() {
                              enr = false;
                              type_respiration = value??-1;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Bruyante'),
                        subtitle: const Text("Effort respiratoire, Contraction des muscles du haut du thorax et cou, Pincement des ailes du nez"),
                        leading: Radio<int>(
                          value: 2,
                          groupValue: type_respiration,
                          
                          onChanged: (int? value) {
                            setState(() {
                              enr = false;
                              type_respiration = value??-1;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Difficile'),
                        subtitle: const Text("Sifflements, ronflements, gargouillements, râles"),
                        leading: Radio<int>(
                          value: 3,
                          groupValue: type_respiration,
                          
                          onChanged: (int? value) {
                            setState(() {
                              enr = false;
                              type_respiration = value??-1;
                            });
                          },
                        ),
                      ),
                    ],
                  )
                ]),
              ExpansionTile(
                  title: const Text('C'),
                  textColor: Colors.red[200],
                  collapsedTextColor: Colors.black,
                  collapsedBackgroundColor: Colors.red[200],
                  iconColor: Colors.black,
                  children: <Widget>[
                    Padding(padding:const EdgeInsets.all(4),child: TextField(
                      onChanged: (text){setState(() {
                        enr = false;
                      }); },
                      keyboardType: TextInputType.number,
                      maxLines: null,
                      controller: bat_frequence,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'bat/min (fréquence)',
                      ),
                    )),
                     const Align(
                      alignment: Alignment.centerLeft,
                      child:
                      Padding(padding: EdgeInsets.all(4),child:
                      Text("Adulte: 60 100 Enfant 70 140\nBébé 100 160 Nouv.né 120 160", style: TextStyle(fontStyle: FontStyle.italic))
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(4),child:
                    Text("radial -carotidien - huméral - fémoral")
                    ),
                    Padding(padding:const EdgeInsets.all(4),child: TextField(
                      onChanged: (text){setState(() {
                        enr = false;
                      }); },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: amplitude,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amplitude + Régularité',
                      ),
                    )),
                    Row(
                        children:[
                          const Expanded(flex: 1,child:
                            SizedBox(
                              width: 1000,
                              child:Padding(padding: EdgeInsets.all(4),child:
                                Text("mm de Hg *", style: TextStyle(fontWeight: FontWeight.bold),)
                            ),
                          )),
                          Expanded(flex: 1,child:
                          SizedBox(
                            width: 1000,
                            child:Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: CheckboxListTile(
                                title: const Text("au repos", softWrap: true,),
                                contentPadding: const EdgeInsets.all(0),
                                value: repos,
                                onChanged: (vla) {
                                  setState(() {
                                    enr = false;
                                    repos = vla??false;
                                  });
                                },
                              ),
                            ),))

                        ]
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child:
                      Padding(padding: EdgeInsets.all(4),child:
                      Text("* Grave : pression artérielle systolique (< à 90mm de Hg ou diminution de la PA habituelle de la victime hypertendu > à 30%)", style: TextStyle(fontStyle: FontStyle.italic))
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
                            controller: tension,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'tension:',
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
                            controller: tension_habituelle,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'tension habituelle',
                            ),
                          ))
                      ), ),
                    ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: CheckboxListTile(
                        title: const Text("Temps de Recoloration Cutané < 2 s", softWrap: true,),
                        contentPadding: const EdgeInsets.all(0),
                        value: recolore,
                        onChanged: (vla) {
                          setState(() {
                            enr = false;
                            recolore = vla??false;
                          });
                        },
                      ),
                    ),
                    Padding(padding:const EdgeInsets.all(4),child: TextField(
                      onChanged: (text){setState(() {
                        enr = false;
                      }); },
                      controller: oxy,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        labelText: 'O² (l/min)',
                      ),
                    ))
                  ]),
              ExpansionTile(
                  title: const Text('D'),
                  textColor: Colors.green[200],
                  collapsedTextColor: Colors.black,
                  collapsedBackgroundColor: Colors.green[200],
                  iconColor: Colors.black,
                  children: <Widget>[
                    Row(
                        children: const <Widget>[
                          Expanded(
                              child: Divider()
                          ),
                          Text("Pupilles",style: TextStyle(fontWeight: FontWeight.bold)),
                          Expanded(
                              child: Divider()
                          ),
                        ]
                    ),
                    Column(
                      children: [
                        ListTile(
                          title: const Text('Egales'),
                          leading: Radio<int>(
                            value: 0,
                            
                            groupValue: pupilles_egales,
                            onChanged: (int? value) {
                              setState(() {
                                pupilles_egales = value??-1;
                                enr = false;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Inégales'),
                          leading: Radio<int>(
                            value: 1,
                            
                            groupValue: pupilles_egales,
                            onChanged: (int? value) {
                              setState(() {
                                pupilles_egales = value??-1;
                                enr = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(children: <Widget>[
                      Expanded(flex: 1,child:
                      SizedBox(
                        width: 100,
                        child:Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: CheckboxListTile(
                            title: const Text("G", softWrap: true,),
                            contentPadding: const EdgeInsets.all(0),
                            value: areactives_G,
                            onChanged: (vla) {
                              setState(() {
                                enr = false;
                                areactives_G = vla??false;
                              });
                            },
                          ),
                        ),)),
                      Expanded(flex: 3,child:
                      SizedBox(
                        width: 1000,
                        child:Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: const Text("D  aréactives", softWrap: true,),
                            contentPadding: const EdgeInsets.all(0),
                            value: areactives_D,
                            onChanged: (vla) {
                              setState(() {
                                enr = false;
                                areactives_D = vla??false;
                              });
                            },
                          ),
                        ),))
                    ],
                    ),
                    Row(children: <Widget>[
                      Expanded(flex: 1,child:
                      SizedBox(
                        width: 100,
                        child:Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: CheckboxListTile(
                            title: const Text("G", softWrap: true,),
                            contentPadding: const EdgeInsets.all(0),
                            value: dilatees_G,
                            onChanged: (vla) {
                              setState(() {
                                enr = false;
                                dilatees_G = vla??false;
                              });
                            },
                          ),
                        ),)),
                      Expanded(flex: 3,child:
                      SizedBox(
                        width: 1000,
                        child:Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: const Text("D  dilatées", softWrap: true,),
                            subtitle: const Text("mydriase"),
                            contentPadding: const EdgeInsets.all(0),
                            value: dilatees_D,
                            onChanged: (vla) {
                              setState(() {
                                enr = false;
                                dilatees_D = vla??false;
                              });
                            },
                          ),
                        ),))
                    ],
                    ),
                    Row(children: <Widget>[
                      Expanded(flex: 1,child:
                      SizedBox(
                        width: 100,
                        child:Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: CheckboxListTile(
                            title: const Text("G", softWrap: true,),
                            contentPadding: const EdgeInsets.all(0),
                            value: serrees_G,
                            onChanged: (vla) {
                              setState(() {
                                enr = false;
                                serrees_G = vla??false;
                              });
                            },
                          ),
                        ),)),
                      Expanded(flex: 3,child:
                      SizedBox(
                        width: 1000,
                        child:Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: const Text("D  serrées", softWrap: true,),
                            subtitle: const Text("myosis"),
                            contentPadding: const EdgeInsets.all(0),
                            value: serrees_D,
                            onChanged: (vla) {
                              setState(() {
                                enr = false;
                                serrees_D = vla??false;
                              });
                            },
                          ),
                        ),))
                    ],
                    ),
                    Row(
                        children: const <Widget>[
                          Expanded(
                              child: Divider()
                          ),
                          Text("Sensimotricité",style: TextStyle(fontWeight: FontWeight.bold)),
                          Expanded(
                              child: Divider()
                          ),
                        ]
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child:
                      Padding(padding: EdgeInsets.all(4),child:
                      Text("Cocher les cases lorsque la sensimotrie fonctionne", style: TextStyle(fontStyle: FontStyle.italic))
                      ),
                    ),
                    Row(children: <Widget>[
                      Expanded(flex: 1,child:
                      SizedBox(
                        width: 100,
                        child:Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: CheckboxListTile(
                            title: const Text("G", softWrap: true,),
                            contentPadding: const EdgeInsets.all(0),
                            value: mains_G,
                            onChanged: (vla) {
                              setState(() {
                                enr = false;
                                mains_G = vla??false;
                              });
                            },
                          ),
                        ),)),
                      Expanded(flex: 3,child:
                      SizedBox(
                        width: 1000,
                        child:Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: const Text("D  mains", softWrap: true,),
                            contentPadding: const EdgeInsets.all(0),
                            value: mains_D,
                            onChanged: (vla) {
                              setState(() {
                                enr = false;
                                mains_D = vla??false;
                              });
                            },
                          ),
                        ),))
                    ],
                    ),
                    Row(children: <Widget>[
                      Expanded(flex: 1,child:
                      SizedBox(
                        width: 100,
                        child:Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: CheckboxListTile(
                            title: const Text("G", softWrap: true,),
                            contentPadding: const EdgeInsets.all(0),
                            value: bras_G,
                            onChanged: (vla) {
                              setState(() {
                                enr = false;
                                bras_G = vla??false;
                              });
                            },
                          ),
                        ),)),
                      Expanded(flex: 3,child:
                      SizedBox(
                        width: 1000,
                        child:Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: const Text("D  bras", softWrap: true,),
                            contentPadding: const EdgeInsets.all(0),
                            value: bras_D,
                            onChanged: (vla) {
                              setState(() {
                                enr = false;
                                bras_D = vla??false;
                              });
                            },
                          ),
                        ),))
                    ],
                    ),
                    Row(children: <Widget>[
                      Expanded(flex: 1,child:
                      SizedBox(
                        width: 100,
                        child:Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: CheckboxListTile(
                            title: const Text("G", softWrap: true,),
                            contentPadding: const EdgeInsets.all(0),
                            value: jambe_G,
                            onChanged: (vla) {
                              setState(() {
                                enr = false;
                                jambe_G = vla??false;
                              });
                            },
                          ),
                        ),)),
                      Expanded(flex: 3,child:
                      SizedBox(
                        width: 1000,
                        child:Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: const Text("D  jambe", softWrap: true,),
                            contentPadding: const EdgeInsets.all(0),
                            value: jambe_D,
                            onChanged: (vla) {
                              setState(() {
                                enr = false;
                                jambe_D = vla??false;
                              });
                            },
                          ),
                        ),))
                    ],
                    ),
                    Row(children: <Widget>[
                      Expanded(flex: 1,child:
                      SizedBox(
                        width: 100,
                        child:Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: CheckboxListTile(
                            title: const Text("G", softWrap: true,),
                            contentPadding: const EdgeInsets.all(0),
                            value: pied_G,
                            onChanged: (vla) {
                              setState(() {
                                enr = false;
                                pied_G = vla??false;
                              });
                            },
                          ),
                        ),)),
                      Expanded(flex: 3,child:
                      SizedBox(
                        width: 1000,
                        child:Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: const Text("D  pieds", softWrap: true,),
                            contentPadding: const EdgeInsets.all(0),
                            value: pied_D,
                            onChanged: (vla) {
                              setState(() {
                                enr = false;
                                pied_D = vla??false;
                              });
                            },
                          ),
                        ),))
                    ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(3,5,3,10),
                      child:
                    Row(
                        children: const <Widget>[
                          Expanded(
                              child: Divider()
                          ),
                          Text("Score de Glasgow", style: TextStyle(fontWeight: FontWeight.bold)),
                          Expanded(
                              child: Divider()
                          ),
                        ]
                    )),
                    ExpansionTile(
                    title: Row(
                    children:const [
                    Icon(Icons.remove_red_eye_outlined),
                    Text(" Ouvre les yeux", style: TextStyle(fontWeight: FontWeight.bold))]),
                    textColor: Colors.green[100],
                    collapsedTextColor: Colors.black,
                    collapsedBackgroundColor: Colors.green[100],
                    iconColor: Colors.black,
                    children: <Widget>[
                      Column(
                        children: [
                          ListTile(
                            title: const Text('4. spontané'),
                            leading: Radio<int>(
                              value: 4,
                              groupValue: yeux,
                              
                              onChanged: (int? value) {
                                setState(() {
                                  enr = false;
                                  yeux = value??0;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('3. à la demande'),
                            leading: Radio<int>(
                              value: 3,
                              groupValue: yeux,
                              
                              onChanged: (int? value) {
                                setState(() {
                                  enr = false;
                                  yeux = value??0;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('2. à la douleur'),
                            leading: Radio<int>(
                              value: 2,
                              groupValue: yeux,
                              
                              onChanged: (int? value) {
                                setState(() {
                                  enr = false;
                                  yeux = value??0;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('1. aucune'),
                            leading: Radio<int>(
                              value: 1,
                              groupValue: yeux,
                              
                              onChanged: (int? value) {
                                setState(() {
                                  enr = false;
                                  yeux = value??0;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      ]),
                    ExpansionTile(
                        title: Row(
                            children:const [
                              Icon(Icons.chat_bubble_outline),
                              Text(" Réponse verbale", style: TextStyle(fontWeight: FontWeight.bold))]),
                        textColor: Colors.green[100],
                        collapsedTextColor: Colors.black,
                        collapsedBackgroundColor: Colors.green[100],
                        iconColor: Colors.black,
                        children: <Widget>[
                          Column(
                            children: [
                              ListTile(
                                title: const Text('5. orientée'),
                                leading: Radio<int>(
                                  value: 5,
                                  groupValue: verbale,
                                  
                                  onChanged: (int? value) {
                                    setState(() {
                                      enr = false;
                                      verbale = value??0;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('4. confuse'),
                                leading: Radio<int>(
                                  value: 4,
                                  groupValue: verbale,
                                  
                                  onChanged: (int? value) {
                                    setState(() {
                                      enr = false;
                                      verbale = value??0;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('3. inapropriée'),
                                leading: Radio<int>(
                                  value: 3,
                                  groupValue: verbale,
                                  
                                  onChanged: (int? value) {
                                    setState(() {
                                      enr = false;
                                      verbale = value??0;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('2. incompréhensible'),
                                leading: Radio<int>(
                                  value: 2,
                                  groupValue: verbale,
                                  
                                  onChanged: (int? value) {
                                    setState(() {
                                      enr = false;
                                      verbale = value??0;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('1. aucune'),
                                leading: Radio<int>(
                                  value: 1,
                                  groupValue: verbale,
                                  
                                  onChanged: (int? value) {
                                    setState(() {
                                      enr = false;
                                      verbale = value??0;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ]),
                    ExpansionTile(
                        title: Row(
                            children:const [
                              Icon(Icons.back_hand),
                              Text(" Réponse motrice", style: TextStyle(fontWeight: FontWeight.bold))]),
                        textColor: Colors.green[100],
                        collapsedTextColor: Colors.black,
                        collapsedBackgroundColor: Colors.green[100],
                        iconColor: Colors.black,
                        children: <Widget>[
                          Column(
                            children: [
                              ListTile(
                                title: const Text('6. à la demande'),
                                leading: Radio<int>(
                                  value: 6,
                                  groupValue: motrice,
                                  
                                  onChanged: (int? value) {
                                    setState(() {
                                      enr = false;
                                      motrice = value??0;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('5. orienté à la douleur'),
                                leading: Radio<int>(
                                  value: 5,
                                  groupValue: motrice,
                                  
                                  onChanged: (int? value) {
                                    setState(() {
                                      enr = false;
                                      motrice = value??0;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('4. évitement non adapté'),
                                leading: Radio<int>(
                                  value: 4,
                                  groupValue: motrice,
                                  
                                  onChanged: (int? value) {
                                    setState(() {
                                      enr = false;
                                      motrice = value??0;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('3. décortication'),
                                subtitle: const Text("Bras vers l'intérieur"),
                                leading: Radio<int>(
                                  value: 3,
                                  groupValue: motrice,
                                  
                                  onChanged: (int? value) {
                                    setState(() {
                                      enr = false;
                                      motrice = value??0;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('2. décérébration'),
                                subtitle: const Text("Bras rigide, mains vers l'extérieur"),
                                leading: Radio<int>(
                                  value: 2,
                                  groupValue: motrice,
                                  
                                  onChanged: (int? value) {
                                    setState(() {
                                      enr = false;
                                      motrice = value??0;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('1. décortication'),
                                leading: Radio<int>(
                                  value: 1,
                                  groupValue: motrice,
                                  
                                  onChanged: (int? value) {
                                    setState(() {
                                      enr = false;
                                      motrice = value??0;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ]),
                    Visibility(
                      visible: (yeux*verbale*motrice>0)?true:false,
                        child:Padding(padding: const EdgeInsets.all(4),child:
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              const TextSpan(text:"Score: ", style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text:'${yeux+verbale+motrice}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: couleurs[(yeux+verbale+motrice>12?0:yeux+verbale+motrice>8?1:2)]) ),
                            ],
                          ),
                        )
                        )
                    ),
                  ]),
            ],
          ),
          ExpansionTile(
            title: Row(
                children: const <Widget>[
                  Expanded(
                      child: Divider()
                  ),
                  Text("Position"),
                  Expanded(
                      child: Divider()
                  ),
                ]),
            collapsedTextColor: Colors.black,
            collapsedBackgroundColor: Colors.grey[200],
            iconColor: Colors.black,
            children: <Widget>[
              ListTile(
                title: const Text('allongée'),
                leading: Radio<int>(
                  value: 0,
                  groupValue: position,
                  onChanged: (int? value) {
                    setState(() {
                      enr=false;
                      position = value??-1;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('demi-assis'),
                leading: Radio<int>(
                  value: 1,
                  groupValue: position,
                  onChanged: (int? value) {
                    setState(() {
                      position = value??-1;
                      enr=false;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('assis'),
                leading: Radio<int>(
                  value: 2,
                  groupValue: position,
                  onChanged: (int? value) {
                    setState(() {
                      position = value??-1;
                      enr=false;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('allongée jambes relevées'),
                leading: Radio<int>(
                  value: 3,
                  groupValue: position,
                  onChanged: (int? value) {
                    setState(() {
                      position = value??-1;
                      enr=false;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('autre:'),
                leading: Radio<int>(
                  value: 4,
                  groupValue: position,
                  onChanged: (int? value) {
                    setState(() {
                      position = value??-1;
                      enr=false;
                    });
                  },
                ),
              ),
              Visibility(
                visible: position==4?true:false,
                child:
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: position_cplx,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Position',
                  ),
                )),
              ),
            ],
          )
        ],
      );
    }else{
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Chargement(controller: _controller,),
            const Padding(
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

  litFichier()async{
    doc = await Officiant().litFichier(widget.chemin, context);
    prefs = await SharedPreferences.getInstance();
    setState(() {
      arreter = (doc.form.fields[prefs.getInt("arreter")??0] as PdfCheckBoxField).isChecked;
      pansement_imb = (doc.form.fields[prefs.getInt("pansement")??0] as PdfCheckBoxField).isChecked;
      garrot = (doc.form.fields[prefs.getInt("garrot")??0] as PdfCheckBoxField).isChecked;
      rechauffe = (doc.form.fields[prefs.getInt("rechauffer")??0] as PdfCheckBoxField).isChecked;
      allonge = (doc.form.fields[prefs.getInt("allonger")??0] as PdfCheckBoxField).isChecked;
      heure_Hemo.text  = (doc.form.fields[prefs.getInt("heure_hem")??0] as PdfTextBoxField).text;
      tape_dos = (doc.form.fields[prefs.getInt("tape_dos")??0] as PdfCheckBoxField).isChecked;
      compression = (doc.form.fields[prefs.getInt("compression")??0] as PdfCheckBoxField).isChecked;
      retournement = (doc.form.fields[prefs.getInt("retournement")??0] as PdfCheckBoxField).isChecked;
      casque = (doc.form.fields[prefs.getInt("casque")??0] as PdfCheckBoxField).isChecked;
      bascule = (doc.form.fields[prefs.getInt("bascule")??0] as PdfCheckBoxField).isChecked;
      elevation_menton = (doc.form.fields[prefs.getInt("menton")??0] as PdfCheckBoxField).isChecked;
      LVA = (doc.form.fields[prefs.getInt("LVA")??0] as PdfCheckBoxField).isChecked;
      neutre = (doc.form.fields[prefs.getInt("neutre")??0] as PdfCheckBoxField).isChecked;
      respiration = (doc.form.fields[prefs.getInt("type_aspi")??0] as PdfRadioButtonListField).selectedIndex;
      insufl = (doc.form.fields[prefs.getInt("insufflation")??0] as PdfCheckBoxField).isChecked;
      aspi = (doc.form.fields[prefs.getInt("aspi")??0] as PdfCheckBoxField).isChecked;
      circulation = (doc.form.fields[prefs.getInt("type_poul")??0] as PdfRadioButtonListField).selectedIndex;
      massage = (doc.form.fields[prefs.getInt("massage")??0] as PdfCheckBoxField).isChecked;
      DAE = (doc.form.fields[prefs.getInt("DAE")??0] as PdfCheckBoxField).isChecked;
      heure_choc1.text  = (doc.form.fields[prefs.getInt("choc_1")??0] as PdfTextBoxField).text;
      heure_choc2.text  = (doc.form.fields[prefs.getInt("choc_2")??0] as PdfTextBoxField).text;
      heure_choc3.text  = (doc.form.fields[prefs.getInt("choc_3")??0] as PdfTextBoxField).text;
      heure_choc4.text  = (doc.form.fields[prefs.getInt("choc_4")??0] as PdfTextBoxField).text;
      ouvre_y = (doc.form.fields[prefs.getInt("ouvre_y")??0] as PdfCheckBoxField).isChecked;
      reponse_v = (doc.form.fields[prefs.getInt("reponse_v")??0] as PdfCheckBoxField).isChecked;
      reponse_m = (doc.form.fields[prefs.getInt("reponse_M")??0] as PdfCheckBoxField).isChecked;
      PLS = (doc.form.fields[prefs.getInt("PLS")??0] as PdfCheckBoxField).isChecked;
      //VITAL 2
      liberation = (doc.form.fields[prefs.getInt("liberation")??0] as PdfCheckBoxField).isChecked;
      aspiration = (doc.form.fields[prefs.getInt("aspiration")??0] as PdfCheckBoxField).isChecked;
      signe_detresse_1.text  = (doc.form.fields[prefs.getInt("signes_detresse")??0] as PdfTextBoxField).text;
      signe_detresse_2.text  = (doc.form.fields[prefs.getInt("signes_detresse2")??0] as PdfTextBoxField).text;
      signe_detresse_3.text  = (doc.form.fields[prefs.getInt("signes_detresse3")??0] as PdfTextBoxField).text;
      //VITAL3
      mvt_frequence.text  = (doc.form.fields[prefs.getInt("mvt_frequence")??0] as PdfTextBoxField).text;
      pauses.text  = (doc.form.fields[prefs.getInt("pauses")??0] as PdfTextBoxField).text;
      saturation.text  = (doc.form.fields[prefs.getInt("saturation")??0] as PdfTextBoxField).text;
      ambiant = (doc.form.fields[prefs.getInt("ambiant")??0] as PdfCheckBoxField).isChecked;
      type_respiration = (doc.form.fields[prefs.getInt("type_respiration")??0] as PdfRadioButtonListField).selectedIndex;
      bat_frequence.text  = (doc.form.fields[prefs.getInt("bat_frequence")??0] as PdfTextBoxField).text;
      amplitude.text  = (doc.form.fields[prefs.getInt("amplitude")??0] as PdfTextBoxField).text;
      repos = (doc.form.fields[prefs.getInt("repos")??0] as PdfCheckBoxField).isChecked;
      tension.text  = (doc.form.fields[prefs.getInt("tension")??0] as PdfTextBoxField).text;
      tension_habituelle.text  = (doc.form.fields[prefs.getInt("tension_habituelle")??0] as PdfTextBoxField).text;
      recolore = (doc.form.fields[prefs.getInt("recoloration")??0] as PdfCheckBoxField).isChecked;
      pupilles_egales = (doc.form.fields[prefs.getInt("pupilles")??0] as PdfRadioButtonListField).selectedIndex;
      areactives_G = ("${(doc.form.fields[prefs.getInt("aréactives")??0] as PdfTextBoxField).text}  ")[0]=="X";
      areactives_D = ("${(doc.form.fields[prefs.getInt("aréactives")??0] as PdfTextBoxField).text}  ")[1]=="X";
      dilatees_G = ("${(doc.form.fields[prefs.getInt("dilatées")??0] as PdfTextBoxField).text}  ")[0]=="X";
      dilatees_D = ("${(doc.form.fields[prefs.getInt("dilatées")??0] as PdfTextBoxField).text}  ")[1]=="X";
      serrees_G = ("${(doc.form.fields[prefs.getInt("serres")??0] as PdfTextBoxField).text}  ")[0]=="X";
      serrees_D = ("${(doc.form.fields[prefs.getInt("serres")??0] as PdfTextBoxField).text}  ")[1]=="X";
      mains_G = ("${(doc.form.fields[prefs.getInt("mains")??0] as PdfTextBoxField).text}  ")[0]=="X";
      mains_D = ("${(doc.form.fields[prefs.getInt("mains")??0] as PdfTextBoxField).text}  ")[1]=="X";
      bras_G = ("${(doc.form.fields[prefs.getInt("bras")??0] as PdfTextBoxField).text}  ")[0]=="X";
      bras_D = ("${(doc.form.fields[prefs.getInt("bras")??0] as PdfTextBoxField).text}  ")[1]=="X";
      jambe_G = ("${(doc.form.fields[prefs.getInt("jambes")??0] as PdfTextBoxField).text}  ")[0]=="X";
      jambe_D = ("${(doc.form.fields[prefs.getInt("jambes")??0] as PdfTextBoxField).text}  ")[1]=="X";
      pied_G = ("${(doc.form.fields[prefs.getInt("pieds")??0] as PdfTextBoxField).text}  ")[0]=="X";
      pied_D = ("${(doc.form.fields[prefs.getInt("pieds")??0] as PdfTextBoxField).text}  ")[1]=="X";
      yeux = 4-((doc.form.fields[prefs.getInt("ouvre_yeux")??0] as PdfRadioButtonListField).selectedIndex);
      if (yeux==5) yeux = 0;
      verbale = 5-(doc.form.fields[prefs.getInt("verbale")??0] as PdfRadioButtonListField).selectedIndex+1;
      if (verbale==6) verbale = 0;
      motrice = 6-(doc.form.fields[prefs.getInt("motrice")??0] as PdfRadioButtonListField).selectedIndex+1;
      if (motrice==7) motrice = 0;
      oxy.text  = (doc.form.fields[prefs.getInt("oxy")??0] as PdfTextBoxField).text;
      position = (doc.form.fields[prefs.getInt("position")??0] as PdfRadioButtonListField).selectedIndex;
      position_cplx.text = (doc.form.fields[prefs.getInt("position_complexe")??0] as PdfTextBoxField).text;

      //GLASGOW
    });
    setState(() {
      future = "ok";
    });
  }

  metChampsAJour() async {
    setState(() {
      future="";
    });
    await Future.delayed(Duration(milliseconds: 1));
    doc = await Officiant().litFichier(widget.chemin, context);
    (doc.form.fields[prefs.getInt("arreter")??0] as PdfCheckBoxField).isChecked = arreter;
    (doc.form.fields[prefs.getInt("pansement")??0] as PdfCheckBoxField).isChecked = pansement_imb;
    (doc.form.fields[prefs.getInt("garrot")??0] as PdfCheckBoxField).isChecked = garrot;
    (doc.form.fields[prefs.getInt("rechauffer")??0] as PdfCheckBoxField).isChecked = rechauffe;
    (doc.form.fields[prefs.getInt("allonger")??0] as PdfCheckBoxField).isChecked = allonge;
    (doc.form.fields[prefs.getInt("heure_hem")??0] as PdfTextBoxField).text = heure_Hemo.text;
    (doc.form.fields[prefs.getInt("tape_dos")??0] as PdfCheckBoxField).isChecked = tape_dos;
    (doc.form.fields[prefs.getInt("compression")??0] as PdfCheckBoxField).isChecked = compression;
    (doc.form.fields[prefs.getInt("retournement")??0] as PdfCheckBoxField).isChecked = retournement;
    (doc.form.fields[prefs.getInt("casque")??0] as PdfCheckBoxField).isChecked = casque;
    (doc.form.fields[prefs.getInt("bascule")??0] as PdfCheckBoxField).isChecked = bascule;
    (doc.form.fields[prefs.getInt("menton")??0] as PdfCheckBoxField).isChecked = elevation_menton;
    (doc.form.fields[prefs.getInt("LVA")??0] as PdfCheckBoxField).isChecked = LVA;
    (doc.form.fields[prefs.getInt("neutre")??0] as PdfCheckBoxField).isChecked = neutre;
    (doc.form.fields[prefs.getInt("type_aspi")??0] as PdfRadioButtonListField).selectedIndex = respiration;
    (doc.form.fields[prefs.getInt("insufflation")??0] as PdfCheckBoxField).isChecked = insufl;
    (doc.form.fields[prefs.getInt("aspi")??0] as PdfCheckBoxField).isChecked = aspi;
    (doc.form.fields[prefs.getInt("type_poul")??0] as PdfRadioButtonListField).selectedIndex = circulation;
    (doc.form.fields[prefs.getInt("massage")??0] as PdfCheckBoxField).isChecked = massage;
    (doc.form.fields[prefs.getInt("DAE")??0] as PdfCheckBoxField).isChecked = DAE;
    (doc.form.fields[prefs.getInt("choc_1")??0] as PdfTextBoxField).text = heure_choc1.text;
    (doc.form.fields[prefs.getInt("choc_2")??0] as PdfTextBoxField).text = heure_choc2.text;
    (doc.form.fields[prefs.getInt("choc_3")??0] as PdfTextBoxField).text = heure_choc3.text;
    (doc.form.fields[prefs.getInt("choc_4")??0] as PdfTextBoxField).text = heure_choc4.text;
    (doc.form.fields[prefs.getInt("ouvre_y")??0] as PdfCheckBoxField).isChecked = ouvre_y;
    (doc.form.fields[prefs.getInt("reponse_v")??0] as PdfCheckBoxField).isChecked = reponse_v;
    (doc.form.fields[prefs.getInt("reponse_M")??0] as PdfCheckBoxField).isChecked = reponse_m;
    (doc.form.fields[prefs.getInt("PLS")??0] as PdfCheckBoxField).isChecked = PLS;
    //VITAL 2
    (doc.form.fields[prefs.getInt("liberation")??0] as PdfCheckBoxField).isChecked = liberation;
    (doc.form.fields[prefs.getInt("aspiration")??0] as PdfCheckBoxField).isChecked = aspiration;
    (doc.form.fields[prefs.getInt("signes_detresse")??0] as PdfTextBoxField).text = signe_detresse_1.text;
    (doc.form.fields[prefs.getInt("signes_detresse2")??0] as PdfTextBoxField).text = signe_detresse_2.text;
    (doc.form.fields[prefs.getInt("signes_detresse3")??0] as PdfTextBoxField).text = signe_detresse_3.text;
    //VITAL3
    (doc.form.fields[prefs.getInt("mvt_frequence")??0] as PdfTextBoxField).text = mvt_frequence.text;
    (doc.form.fields[prefs.getInt("pauses")??0] as PdfTextBoxField).text = pauses.text;
    (doc.form.fields[prefs.getInt("saturation")??0] as PdfTextBoxField).text = saturation.text;
    (doc.form.fields[prefs.getInt("ambiant")??0] as PdfCheckBoxField).isChecked = ambiant;
    (doc.form.fields[prefs.getInt("type_respiration")??0] as PdfRadioButtonListField).selectedIndex = m.max(0,type_respiration);
    (doc.form.fields[prefs.getInt("bat_frequence")??0] as PdfTextBoxField).text = bat_frequence.text;
    (doc.form.fields[prefs.getInt("amplitude")??0] as PdfTextBoxField).text = amplitude.text;
    (doc.form.fields[prefs.getInt("repos")??0] as PdfCheckBoxField).isChecked = repos;
    (doc.form.fields[prefs.getInt("tension")??0] as PdfTextBoxField).text = tension.text;
    (doc.form.fields[prefs.getInt("tension_habituelle")??0] as PdfTextBoxField).text = tension_habituelle.text;
    (doc.form.fields[prefs.getInt("recoloration")??0] as PdfCheckBoxField).isChecked = recolore;
    (doc.form.fields[prefs.getInt("pupilles")??0] as PdfRadioButtonListField).selectedIndex = pupilles_egales;
    (doc.form.fields[prefs.getInt("aréactives")??0] as PdfTextBoxField).text = "${areactives_G?"X":" "}${areactives_D?"X":" "} ";
    (doc.form.fields[prefs.getInt("dilatées")??0] as PdfTextBoxField).text = "${dilatees_G?"X":" "}${dilatees_D?"X":" "} ";
    (doc.form.fields[prefs.getInt("serrées")??0] as PdfTextBoxField).text = "${serrees_G?"X":" "}${serrees_D?"X":" "} ";
    (doc.form.fields[prefs.getInt("mains")??0] as PdfTextBoxField).text = "${mains_G?"X":" "}${mains_D?"X":" "} ";
    (doc.form.fields[prefs.getInt("bras")??0] as PdfTextBoxField).text = "${bras_G?"X":" "}${bras_D?"X":" "} ";
    (doc.form.fields[prefs.getInt("jambes")??0] as PdfTextBoxField).text = "${jambe_G?"X":" "}${jambe_D?"X":" "} ";
    (doc.form.fields[prefs.getInt("pieds")??0] as PdfTextBoxField).text = "${pied_G?"X":" "}${pied_D?"X":" "} ";
    if(yeux>0)(doc.form.fields[prefs.getInt("ouvre_yeux")??0] as PdfRadioButtonListField).selectedIndex = 5 - yeux -1;
    if(verbale>0)(doc.form.fields[prefs.getInt("verbale")??0] as PdfRadioButtonListField).selectedIndex = 6 - verbale - 1;
    if(motrice>0)(doc.form.fields[prefs.getInt("motrice")??0] as PdfRadioButtonListField).selectedIndex = 7 - motrice - 1;
    (doc.form.fields[prefs.getInt("glasgow")??0] as PdfTextBoxField).text = yeux*verbale*motrice>0?(yeux+motrice+verbale).toString():"";
    (doc.form.fields[prefs.getInt("oxy")??0] as PdfTextBoxField).text = oxy.text;
    (doc.form.fields[prefs.getInt("position")??0] as PdfRadioButtonListField).selectedIndex = position;
    (doc.form.fields[prefs.getInt("position_complexe")??0] as PdfTextBoxField).text = position==4?position_cplx.text:"";

    Officiant().enregistreFichier(widget.chemin, doc).then((value) => {
      if (value)ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enregistré !"),))
      else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Une erreur est survenue :/"),))
    });
    setState(() {
      enr = true;
      future="ok";
    });
  }
}