import 'dart:ui';
import 'package:app_secours/Officiant.dart';
import 'package:app_secours/menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';

class Complementaire extends StatefulWidget {

  String chemin;

  Complementaire({super.key, required this.chemin});

  @override
  State<Complementaire> createState() => _ComplementaireState();
}

class _ComplementaireState extends State<Complementaire> {

  bool enr = true;
  String future = "";

  List<Offset> _pointOffset = List.generate(8, (index) => Offset(0, 0));
  late PointMarkerPainter peinture;

  //etat physique
  List<TextEditingController> plainte = List.generate(8, (index) => TextEditingController());
  List<TextEditingController> circonstances = List.generate(8, (index) => TextEditingController());
  List<TextEditingController> caracteristiques = List.generate(8, (index) => TextEditingController());
  List<TextEditingController> intensite = List.generate(8, (index) => TextEditingController());
  List<TextEditingController> duree = List.generate(8, (index) => TextEditingController());
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
  bool diabetique = false;
  bool insulo = false;
  TextEditingController temperature  = TextEditingController();
  int lieu_temp = -1;
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
    litFichier();
    super.initState();
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
    if (future !=null && future == "ok"){
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
                          items: <String>["mg/dl","g/l","mmol/ml"].map<DropdownMenuItem<String>>((String value) {
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
                        toggleable: true,
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
                        toggleable: true,
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
                        toggleable: true,
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
                  controller: temperature,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre de mocreaux',
                  ),
                )),),
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  keyboardType: TextInputType.number,
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
                    Flexible(flex: 2,child:
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
              title: const Text('autre truc'),
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
                  keyboardType: TextInputType.number,
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

  Future<String> litFichier2()async{
    //Isolate.spawn(litFichier,"ok");
    return ("ok");
  }

  litFichier()async{
    PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
    /*setState(() {
      dispositif.text = (doc.form.fields[120] as PdfTextBoxField).text;
      numeros.text = (doc.form.fields[121] as PdfTextBoxField).text;
      equipe.text = (doc.form.fields[122] as PdfTextBoxField).text;
      date.text = (doc.form.fields[123] as PdfTextBoxField).text;
      heure.text = (doc.form.fields[124] as PdfTextBoxField).text;
      num_dispositif.text =(doc.form.fields[125] as PdfTextBoxField).text;
      motif.text = (doc.form.fields[126] as PdfTextBoxField).text;
      adresse.text = (doc.form.fields[127] as PdfTextBoxField).text;
      depart_equipe.text = (doc.form.fields[128] as PdfTextBoxField).text;
      heure_depart.text = (doc.form.fields[129] as PdfTextBoxField).text;
      sur_lieux.text = (doc.form.fields[130] as PdfTextBoxField).text;
    });*/
    setState(() {
      future = "ok";
    });
  }

  metChampsAJour() async {
    PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
    /*for (var x = 0; x<doc.form.fields.count; x++)print(doc.form.fields[x].name);
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
    (doc.form.fields[130] as PdfTextBoxField).text = sur_lieux.text;*/
    if(await enregistre()){
      Officiant().enregistreFichier(widget.chemin, doc).then((value) => {
        if (value)ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enregistré !"),))
        else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Une erreur est survenue :/"),))
      });
    }
    setState(() {
      enr = true;
    });
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
                  _pointOffset[index] = details.localPosition;
                  print(_pointOffset);
                  peinture.modif(_pointOffset[index]);
                });
              },
              child:Stack(
                children:[
                  Image.asset('assets/physique.png'),
                  Positioned.fill(child:CustomPaint(
                    painter: peinture,
                    child: Container(),
                  ),),
                ]
              ), /*Container(
                width: 300,
                height: 300,
                child: CustomPaint(
                  painter: peinture,
                  child: Image.asset(
                    'assets/physique.png', // Chemin de l'image dans les assets
                    fit: BoxFit.contain,
                  ),
                ),
              ),*/
            ),
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
      );
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
    //canvas.drawImage(Image.asset("assets/physique.png").image, Offset.zero, Paint());
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