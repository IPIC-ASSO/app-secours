import 'dart:math';
import 'package:app_secours/Officiant.dart';
import 'package:app_secours/charge.dart';
import 'package:app_secours/menu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';

class Complementaire extends StatefulWidget {

  String chemin;

  Complementaire({super.key, required this.chemin});

  @override
  State<Complementaire> createState() => _ComplementaireState();
}

class _ComplementaireState extends State<Complementaire> with TickerProviderStateMixin {

  late AnimationController _controller;
  late final SharedPreferences prefs;
  bool enr = true;
  String future = "";
  double largeur = 400;
  final List<Offset> _pointOffset = List.generate(7, (index) => const Offset(0, 0));
  List<String> type_blessure = List.generate(7, (index) => "--:--");
  List<String> types_b = ["--:--","FO: Fracture Ouverte","FF: Fracture Fermée","DL: Douleur","DE: Déformation","B: Brûlure","H: Hémorragie","P: Plaie", "G: Gonflement"];
  List<String> types_b_c = ["+","+ FO","+ FF","+ DL","+ DE","+ B","+ H","+ P","+ G"];
  late PointMarkerPainter peinture;

  //etat physique
  List<TextEditingController> plainte = List.generate(7, (index) => TextEditingController());
  List<TextEditingController> circonstances = List.generate(7, (index) => TextEditingController());
  List<TextEditingController> caracteristiques = List.generate(7, (index) => TextEditingController());
  List<TextEditingController> intensite = List.generate(7, (index) => TextEditingController());
  List<TextEditingController> duree = List.generate(7, (index) => TextEditingController());
  //infos medical
  TextEditingController allergies  = TextEditingController();
  TextEditingController medicaments  = TextEditingController();
  bool ordonnance = false;
  TextEditingController passe_med  = TextEditingController();
  TextEditingController le_dernier  = TextEditingController();
  TextEditingController evenement  = TextEditingController();
  //etat medical
  bool faiblesse = false;
  bool anomalie = false;
  bool asymetrie = false;
  TextEditingController glycemie  = TextEditingController();
  String unite_glycemie = "mg/dl";
  List<String> unite = ["mg/dl","g/l","mmol/ml"];
  bool diabetique = false;
  bool insulo = false;
  TextEditingController temperature  = TextEditingController();
  int lieu_temp = 0;
  bool aide_medoc = false;
  bool aide_sucre = false;
  TextEditingController morceau_sucre  = TextEditingController();
  TextEditingController precisions  = TextEditingController();
  TextEditingController trauma  = TextEditingController();
  bool realignement = false;
  bool echarpe = false;
  bool attelle = false;
  TextEditingController type_attelle  = TextEditingController();
  bool matelas = false;
  bool ACT = false;
  bool collier = false;
  bool plan = false;
  //autre truc
  bool ingestion = false;
  bool inhalation = false;
  bool injection = false;
  bool projection = false;
  TextEditingController produit = TextEditingController();
  bool intox_op = false;
  bool refroidissement = false;
  bool rincage = false;
  bool couverte = false;
  bool desinfection = false;



  @override
  void initState() {
    super.initState();
    litFichier();
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
        title: const Text('Complémentaire'),
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
                title: const Text('Etat physique'),
                textColor: Colors.red[400],
                collapsedTextColor: Colors.black,
                collapsedBackgroundColor: Colors.red[400],
                iconColor: Colors.black,
                children: List<Widget>.generate(plainte.length, (index) {
                  return ExpansionTile(
                    title: Text(("${index+1}")),
                    collapsedTextColor: Colors.black,
                    collapsedBackgroundColor: Colors.grey[400],
                    iconColor: Colors.black,
                    children: <Widget>[
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: plainte[index],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Plainte/Trauma',
                        ),
                      )),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: circonstances[index],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Circonstances',
                        ),
                      )),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: caracteristiques[index],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Caractéristiques',
                        ),
                      )),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: intensite[index],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Intensité',
                        ),
                      )),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: duree[index],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Durée',
                        ),
                      )),
                      ElevatedButton.icon(icon:const Icon(Icons.man), onPressed: ()=> _ouvrePC(context, index), label: const Text("Localisation"))
                    ]);
                })),
                ExpansionTile(
                title: const Text('Infos médicales'),
                textColor: Colors.red[200],
                collapsedTextColor: Colors.black,
                collapsedBackgroundColor: Colors.red[200],
                iconColor: Colors.black,
                children: <Widget>[
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    controller: allergies,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Allergies',
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: CheckboxListTile(
                      title: const Text("Ordonnance médicale", softWrap: true,),
                      contentPadding: const EdgeInsets.all(0),
                      value: ordonnance,
                      onChanged: (vla) {
                        setState(() {
                          enr = false;
                          ordonnance = vla??false;
                        });
                      },
                    ),
                  ),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    controller: medicaments,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Medicaments',
                    ),
                  )),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    controller: passe_med,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Passé médicale',
                      helperText: "antécédents, hospitalisations récentes",
                    ),
                  )),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    controller: le_dernier,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Le dernier repas',
                    ),
                  )),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    controller: evenement,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Evènements ayant conduit à la situation',
                    ),
                  )),
              ]),
              ExpansionTile(
              title: const Text('Etat médical'),
              textColor: Colors.red[400],
              collapsedTextColor: Colors.black,
              collapsedBackgroundColor: Colors.red[400],
              iconColor: Colors.black,
              children: <Widget>[
                Row(
                    children: const <Widget>[
                      Expanded(child: Divider()),
                      Text("Malaise/Aggravation de maladie"),
                      Expanded(child: Divider()),
                    ]),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("Faiblesse musculaire d'un membre supérieur", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: faiblesse,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        faiblesse = vla??false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("Anomalie parole", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: anomalie,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        anomalie = vla??false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("Asymétrie de l'expression faciale", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: asymetrie,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        asymetrie = vla??false;
                      });
                    },
                  ),
                ),
                Row(
                  children: <Widget>[
                    Flexible(flex: 2,child:
                    SizedBox(
                        width: 1000,
                        child:Padding(padding:const EdgeInsets.all(4),child: TextField(
                          onChanged: (text){setState(() {
                            enr = false;
                          }); },
                          keyboardType: TextInputType.number,
                          controller: glycemie,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Glycémie',
                          ),
                        ))
                    ),),
                    Flexible(flex: 1,child:
                    SizedBox(
                        width: 1000,
                        child:Padding(padding:const EdgeInsets.all(4),child: DropdownButton<String>(
                          value: unite_glycemie,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              enr = false;
                              unite_glycemie = value!;
                            });
                          },
                          items: unite.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ))
                    ), ),
                  ],
                ),
                const Text("hypoglycémie (réf : 60mg/dl - 0,6g/l - 3,3 mmol/ml)\nhyperglycémie : ne pas intérpréter de valeur, demander un avis médical", style: TextStyle(fontStyle: FontStyle.italic)),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("Personne diabétique", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: diabetique,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        diabetique = vla??false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("Personne insulino dépendante", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: insulo,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        insulo = vla??false;
                      });
                    },
                  ),
                ),
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  keyboardType: TextInputType.number,
                  controller: temperature,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Temperature (°C)',
                  ),
                )),
                Column(
                  children: [
                    ListTile(
                      title: const Text('tympanique'),
                      leading: Radio<int>(
                        value: 0,
                        groupValue: lieu_temp,
                        
                        onChanged: (int? value) {
                          setState(() {
                            enr = false;
                            lieu_temp = value??-1;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('axiliaire'),
                      leading: Radio<int>(
                        value: 1,
                        groupValue: lieu_temp,
                        
                        onChanged: (int? value) {
                          setState((){
                            enr = false;
                            lieu_temp= value??-1;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('buccale'),
                      leading: Radio<int>(
                        value: 2,
                        groupValue: lieu_temp,
                        
                        onChanged: (int? value) {
                          setState((){
                            enr = false;
                            lieu_temp= value??-1;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const Text("Aide à la prise:"),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("médicament", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: aide_medoc,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        aide_medoc = vla??false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("sucre", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: aide_sucre,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        aide_sucre = vla??false;
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: aide_sucre,
                  child: Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  keyboardType: TextInputType.number,
                  controller: morceau_sucre,
                  maxLength: 2,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre de mocreaux',
                  ),
                )),),
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  controller: precisions,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'précisions',
                  ),
                )),
                Row(
                  children: const <Widget>[
                    Expanded(child: Divider()),
                    Text("Traumatismes"),
                    Expanded(child: Divider()),
                  ]),
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  controller: trauma,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'précisions et/ou mécanismes',
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("réalignement", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: realignement,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        realignement = vla??false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("écharpe", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: echarpe,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        echarpe = vla??false;
                      });
                    },
                  ),
                ),
                Row(
                  children: <Widget>[
                    Flexible(flex: 1,child:
                    SizedBox(
                        width: 1000,
                        child:Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: CheckboxListTile(
                            title: const Text("attelle", softWrap: true,),
                            contentPadding: const EdgeInsets.all(0),
                            value: attelle,
                            onChanged: (vla) {
                              setState(() {
                                enr = false;
                                attelle = vla??false;
                              });
                            },
                          ),
                        ),
                    ),),
                    Flexible(flex: 1,child:
                    SizedBox(
                        width: 1000,
                        child:Padding(padding:const EdgeInsets.all(4),child: TextField(
                          onChanged: (text){setState(() {
                            enr = false;
                          }); },
                          controller: type_attelle,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'type',
                          ),
                        ))
                    ), ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("matelas dépression", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: matelas,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        matelas = vla??false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("ACT", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: ACT,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        ACT = vla??false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("collier", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: collier,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        collier = vla??false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("plan dur", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: plan,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        plan = vla??false;
                      });
                    },
                  ),
                ),
              ]),
              ExpansionTile(
              title: const Text('Précisions'),
              textColor: Colors.red[200],
              collapsedTextColor: Colors.black,
              collapsedBackgroundColor: Colors.red[200],
              iconColor: Colors.black,
              children: <Widget>[
                Row(
                    children: const <Widget>[
                      Expanded(child: Divider()),
                      Text("Intoxication"),
                      Expanded(child: Divider()),
                    ]),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("ingestion", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: ingestion,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        ingestion = vla??false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("inhalation", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: inhalation,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        inhalation = vla??false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("injection", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: injection,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        injection = vla??false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("projection", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: projection,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        projection = vla??false;
                      });
                    },
                  ),
                ),
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  controller: produit,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'produit/substance',
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("intox aux opiacés", softWrap: true,),
                    subtitle: const Text("euro + myosis + FR < 12"),
                    contentPadding: const EdgeInsets.all(0),
                    value: intox_op,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        intox_op = vla??false;
                      });
                    },
                  ),
                ),
                Row(
                    children: const <Widget>[
                      Expanded(child: Divider()),
                      Text("Brûlures"),
                      Expanded(child: Divider()),
                    ]),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("refroidissement", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: refroidissement,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        refroidissement = vla??false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("rinçage", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: rincage,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        rincage = vla??false;
                      });
                    },
                  ),
                ),
                Row(
                    children: const <Widget>[
                      Expanded(child: Divider()),
                      Text("Plaies"),
                      Expanded(child: Divider()),
                    ]),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("couverte", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: couverte,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        couverte = vla??false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CheckboxListTile(
                    title: const Text("désinfection", softWrap: true,),
                    contentPadding: const EdgeInsets.all(0),
                    value: desinfection,
                    onChanged: (vla) {
                      setState(() {
                        enr = false;
                        desinfection = vla??false;
                      });
                    },
                  ),
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

  Future<String> litFichier2()async{
    //Isolate.spawn(litFichier,"ok");
    return ("ok");
  }

  litFichier()async{
    PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
    prefs = await SharedPreferences.getInstance();
    Rect ref = (doc.form.fields[prefs.getInt("blessure_0")??0] as PdfTextBoxField).bounds;
    for (int i =0; i<plainte.length;i++){
      plainte[i].text  = (doc.form.fields[prefs.getInt("plainte_${i+1}")??0] as PdfTextBoxField).text;
      circonstances[i].text  = (doc.form.fields[prefs.getInt("circonstances_${i+1}")??0] as PdfTextBoxField).text;
      caracteristiques[i].text  = (doc.form.fields[prefs.getInt("caracteristiques_${i+1}")??0] as PdfTextBoxField).text;
      intensite[i].text  = (doc.form.fields[prefs.getInt("intensite_${i+1}")??0] as PdfTextBoxField).text;
      duree[i].text  = (doc.form.fields[prefs.getInt("duree_${i+1}")??0] as PdfTextBoxField).text;
      final blessure = (doc.form.fields[prefs.getInt("blessure_${i+1}")??0] as PdfTextBoxField);
      print(blessure.bounds.centerLeft);
      print(ref.left);
      print(blessure.name);
      type_blessure[i] =  types_b[types_b_c.indexOf(blessure.text.isEmpty?"+":blessure.text)];
      _pointOffset[i] = Offset(((blessure.bounds.centerLeft.dx-ref.left)/ref.width),((blessure.bounds.centerLeft.dy-ref.top)/ref.width));
    }
    allergies.text  = (doc.form.fields[prefs.getInt("allergies")??0] as PdfTextBoxField).text;
    medicaments.text  = (doc.form.fields[prefs.getInt("medicaments")??0] as PdfTextBoxField).text;
    ordonnance = (doc.form.fields[prefs.getInt("ordonnance")??0] as PdfCheckBoxField).isChecked;
    passe_med.text  = (doc.form.fields[prefs.getInt("passe_medical")??0] as PdfTextBoxField).text;
    le_dernier.text  = (doc.form.fields[prefs.getInt("dernier_repas")??0] as PdfTextBoxField).text;
    evenement.text  = (doc.form.fields[prefs.getInt("evenements")??0] as PdfTextBoxField).text;
    //etat medical
    faiblesse = (doc.form.fields[prefs.getInt("faiblesse")??0] as PdfCheckBoxField).isChecked;
    anomalie = (doc.form.fields[prefs.getInt("anomalie")??0] as PdfCheckBoxField).isChecked;
    asymetrie = (doc.form.fields[prefs.getInt("asymetrie")??0] as PdfCheckBoxField).isChecked;
    glycemie.text  = (doc.form.fields[prefs.getInt("glyc")??0] as PdfTextBoxField).text;
    unite_glycemie = unite[max((doc.form.fields[prefs.getInt("glycemie")??0] as PdfRadioButtonListField).selectedIndex,0)];
    diabetique = (doc.form.fields[prefs.getInt("diabetique")??0] as PdfCheckBoxField).isChecked;
    insulo = (doc.form.fields[prefs.getInt("insulino")??0] as PdfCheckBoxField).isChecked;
    temperature.text  = (doc.form.fields[prefs.getInt("temperature")??0] as PdfTextBoxField).text;
    lieu_temp = (doc.form.fields[prefs.getInt("temp")??0] as PdfRadioButtonListField).selectedIndex;
    aide_medoc = (doc.form.fields[prefs.getInt("aide_medoc")??0] as PdfCheckBoxField).isChecked;
    aide_sucre = (doc.form.fields[prefs.getInt("aide_sucre")??0] as PdfCheckBoxField).isChecked;
    morceau_sucre.text  = (doc.form.fields[prefs.getInt("nb_morceaux")??0] as PdfTextBoxField).text;
    precisions.text  = (doc.form.fields[prefs.getInt("precisions")??0] as PdfTextBoxField).text;
    trauma.text  = (doc.form.fields[prefs.getInt("mecanismes")??0] as PdfTextBoxField).text;
    realignement = (doc.form.fields[prefs.getInt("aide_medoc")??0] as PdfCheckBoxField).isChecked;
    echarpe = (doc.form.fields[prefs.getInt("echarpe")??0] as PdfCheckBoxField).isChecked;
    attelle = (doc.form.fields[prefs.getInt("attelle")??0] as PdfCheckBoxField).isChecked;
    type_attelle.text  = (doc.form.fields[prefs.getInt("type_attele")??0] as PdfTextBoxField).text;
    matelas = (doc.form.fields[prefs.getInt("matelas")??0] as PdfCheckBoxField).isChecked;
    ACT = (doc.form.fields[prefs.getInt("ACT")??0] as PdfCheckBoxField).isChecked;
    collier = (doc.form.fields[prefs.getInt("collier")??0] as PdfCheckBoxField).isChecked;
    plan = (doc.form.fields[prefs.getInt("plan")??0] as PdfCheckBoxField).isChecked;
    //truc
    ingestion = (doc.form.fields[prefs.getInt("ingestion")??0] as PdfCheckBoxField).isChecked;
    inhalation = (doc.form.fields[prefs.getInt("inhalation")??0] as PdfCheckBoxField).isChecked;
    injection = (doc.form.fields[prefs.getInt("injection")??0] as PdfCheckBoxField).isChecked;
    projection = (doc.form.fields[prefs.getInt("projection")??0] as PdfCheckBoxField).isChecked;
    produit.text  = (doc.form.fields[prefs.getInt("produit")??0] as PdfTextBoxField).text;
    refroidissement = (doc.form.fields[prefs.getInt("refroidissement")??0] as PdfCheckBoxField).isChecked;
    rincage = (doc.form.fields[prefs.getInt("rincage")??0] as PdfCheckBoxField).isChecked;
    couverte = (doc.form.fields[prefs.getInt("couverte")??0] as PdfCheckBoxField).isChecked;
    desinfection = (doc.form.fields[prefs.getInt("desinfection")??0] as PdfCheckBoxField).isChecked;
    intox_op = (doc.form.fields[prefs.getInt("intox")??0] as PdfCheckBoxField).isChecked;

    setState(() {
      future = "ok";
    });
  }

  metChampsAJour() async {
    PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
    Rect ref = (doc.form.fields[prefs.getInt("blessure_1")??0] as PdfTextBoxField).bounds;
    for (int i =0; i<plainte.length;i++){
      (doc.form.fields[prefs.getInt("plainte_${i+1}")??0] as PdfTextBoxField).text = plainte[i].text;
      (doc.form.fields[prefs.getInt("circonstances_${i+1}")??0] as PdfTextBoxField).text = circonstances[i].text;
      (doc.form.fields[prefs.getInt("caracteristiques_${i+1}")??0] as PdfTextBoxField).text = caracteristiques[i].text;
      (doc.form.fields[prefs.getInt("intensite_${i+1}")??0] as PdfTextBoxField).text = intensite[i].text;
      (doc.form.fields[prefs.getInt("duree_${i+1}")??0] as PdfTextBoxField).text = duree[i].text;
      (doc.form.fields[prefs.getInt("blessure_${i+1}")??0] as PdfTextBoxField).text = types_b_c[types_b.indexOf(type_blessure[i])];
      (doc.form.fields[prefs.getInt("blessure_${i+1}")??0] as PdfTextBoxField).bounds = Rect.fromLTWH(ref.left+(_pointOffset[i].dx)*ref.width,ref.top+(_pointOffset[i].dy)*ref.width , ref.width, ref.height);
      print(Rect.fromLTWH(ref.left+(_pointOffset[i].dx)*ref.width,ref.top+(_pointOffset[i].dy)*ref.width , ref.width, ref.height));

    }
    (doc.form.fields[prefs.getInt("allergies")??0] as PdfTextBoxField).text = allergies.text;
    (doc.form.fields[prefs.getInt("medicaments")??0] as PdfTextBoxField).text = medicaments.text;
    (doc.form.fields[prefs.getInt("ordonnance")??0] as PdfCheckBoxField).isChecked = ordonnance;
    (doc.form.fields[prefs.getInt("passe_medical")??0] as PdfTextBoxField).text = passe_med.text;
    (doc.form.fields[prefs.getInt("dernier_repas")??0] as PdfTextBoxField).text = le_dernier.text;
    (doc.form.fields[prefs.getInt("evenements")??0] as PdfTextBoxField).text = evenement.text;
    (doc.form.fields[prefs.getInt("faiblesse")??0] as PdfCheckBoxField).isChecked = faiblesse;
    (doc.form.fields[prefs.getInt("anomalie")??0] as PdfCheckBoxField).isChecked = anomalie;
    (doc.form.fields[prefs.getInt("asymetrie")??0] as PdfCheckBoxField).isChecked = asymetrie;
    (doc.form.fields[prefs.getInt("glyc")??0] as PdfTextBoxField).text = glycemie.text;
    (doc.form.fields[prefs.getInt("glycemie")??0] as PdfRadioButtonListField).selectedIndex = unite.indexOf(unite_glycemie);
    (doc.form.fields[prefs.getInt("diabetique")??0] as PdfCheckBoxField).isChecked = diabetique;
    (doc.form.fields[prefs.getInt("insulino")??0] as PdfCheckBoxField).isChecked = insulo;
    (doc.form.fields[prefs.getInt("temperature")??0] as PdfTextBoxField).text = temperature.text;
    (doc.form.fields[prefs.getInt("temp")??0] as PdfRadioButtonListField).selectedIndex = lieu_temp;
    (doc.form.fields[prefs.getInt("aide_medoc")??0] as PdfCheckBoxField).isChecked = aide_medoc;
    (doc.form.fields[prefs.getInt("aide_sucre")??0] as PdfCheckBoxField).isChecked = aide_sucre;
    (doc.form.fields[prefs.getInt("nb_morceaux")??0] as PdfTextBoxField).text = aide_sucre?morceau_sucre.text:"";
    (doc.form.fields[prefs.getInt("precisions")??0] as PdfTextBoxField).text = precisions.text;
    (doc.form.fields[prefs.getInt("mecanismes")??0] as PdfTextBoxField).text = trauma.text;
    (doc.form.fields[prefs.getInt("realignement")??0] as PdfCheckBoxField).isChecked = realignement;
    (doc.form.fields[prefs.getInt("echarpe")??0] as PdfCheckBoxField).isChecked = echarpe;
    (doc.form.fields[prefs.getInt("attelle")??0] as PdfCheckBoxField).isChecked = attelle;
    (doc.form.fields[prefs.getInt("type_attele")??0] as PdfTextBoxField).text = type_attelle.text;
    (doc.form.fields[prefs.getInt("matelas")??0] as PdfCheckBoxField).isChecked = matelas;
    (doc.form.fields[prefs.getInt("ACT")??0] as PdfCheckBoxField).isChecked = ACT;
    (doc.form.fields[prefs.getInt("collier")??0] as PdfCheckBoxField).isChecked = collier;
    (doc.form.fields[prefs.getInt("plan")??0] as PdfCheckBoxField).isChecked = plan;
    (doc.form.fields[prefs.getInt("ingestion")??0] as PdfCheckBoxField).isChecked = ingestion;
    (doc.form.fields[prefs.getInt("inhalation")??0] as PdfCheckBoxField).isChecked = inhalation;
    (doc.form.fields[prefs.getInt("injection")??0] as PdfCheckBoxField).isChecked = injection;
    (doc.form.fields[prefs.getInt("projection")??0] as PdfCheckBoxField).isChecked = projection;
    (doc.form.fields[prefs.getInt("produit")??0] as PdfTextBoxField).text = produit.text;
    (doc.form.fields[prefs.getInt("refroidissement")??0] as PdfCheckBoxField).isChecked = refroidissement;
    (doc.form.fields[prefs.getInt("rincage")??0] as PdfCheckBoxField).isChecked = rincage;
    (doc.form.fields[prefs.getInt("couverte")??0] as PdfCheckBoxField).isChecked = couverte;
    (doc.form.fields[prefs.getInt("desinfection")??0] as PdfCheckBoxField).isChecked = desinfection;
    (doc.form.fields[prefs.getInt("intox")??0] as PdfCheckBoxField).isChecked = intox_op;

    Officiant().enregistreFichier(widget.chemin, doc).then((value) => {
      if (value)ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enregistré !"),))
      else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Une erreur est survenue :/"),))
    });

    setState(() {
      enr = true;
    });
  }

    Future<void> _ouvrePC(BuildContext context, int index) {
      peinture = PointMarkerPainter(_pointOffset[index]);
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Localisation de la blessure'),
            content: GestureDetector(
              onTapDown: (TapDownDetails details) {
                // Mettre à jour les coordonnées du point lors du tap sur l'image
                setState(() {
                  _pointOffset[index] = Offset(details.localPosition.dx/largeur,details.localPosition.dy/largeur);
                  peinture.modif(details.localPosition);
                });
              },
              child:SizedBox(width: double.maxFinite, child: ListView(
              shrinkWrap: true,
              children:[
                Stack(
                children:[
                  Image.asset('assets/physique.png'),
                  Positioned.fill(child:CustomPaint(
                    painter: peinture,
                    child: Container(),
                  ),),
                ]
              ),
                Padding(padding:const EdgeInsets.all(4),child:
                  StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState){
                  return DropdownButton<String>(
                      value: type_blessure[index],
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        dropDownState(() {
                          enr = false;
                          type_blessure[index] = value!;
                        });
                      },
                      items: types_b.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    );
                    })),
            ]),
            )),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Termine'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ).whenComplete((){
        largeur = (context.size?.width??400);
        peinture.modif(Offset(_pointOffset[index].dx*largeur,_pointOffset[index].dy*largeur));
      });
  }
}

class PointMarkerPainter extends ChangeNotifier implements CustomPainter {
  Offset pointOffset;

  PointMarkerPainter(this.pointOffset);

  @override
  void paint(Canvas canvas, Size size) {
    // Dessiner le point sur l'image à l'emplacement spécifié
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(pointOffset, 5, paint);
  }

  @override
  bool shouldRepaint(PointMarkerPainter oldDelegate) {
    return oldDelegate.pointOffset != pointOffset;
  }

  void modif(Offset nouvOff){
    pointOffset = nouvOff;
    notifyListeners();
  }

  @override
  bool? hitTest(Offset position) {
    return true;
  }

  @override
  SemanticsBuilderCallback? get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) {
    return true;
  }
}