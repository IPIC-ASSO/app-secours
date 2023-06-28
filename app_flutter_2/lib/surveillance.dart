import 'package:app_secours/charge.dart';
import 'package:app_secours/menu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'Officiant.dart';

class Surveillance extends StatefulWidget {

  String chemin;

  Surveillance({super.key, required this.chemin});

  @override
  State<Surveillance> createState() => _SurveillanceState();
}

class _SurveillanceState extends State<Surveillance> with TickerProviderStateMixin {

  late AnimationController _controller;
  late final SharedPreferences prefs;
  bool enr = true;
  String future = "";
  DateTime selectedDate = DateTime.now();

  TextEditingController evolution  = TextEditingController();
  TextEditingController evolution2  = TextEditingController();
  TextEditingController heure1  = TextEditingController();
  TextEditingController heure2  = TextEditingController();
  TextEditingController frequence1  = TextEditingController();
  TextEditingController frequence2  = TextEditingController();
  TextEditingController amplitude1  = TextEditingController();
  TextEditingController amplitude2  = TextEditingController();
  TextEditingController saturation1  = TextEditingController();
  TextEditingController saturation2  = TextEditingController();
  TextEditingController frequence_bat1  = TextEditingController();
  TextEditingController frequence_bat2  = TextEditingController();
  TextEditingController amplitude_bat1  = TextEditingController();
  TextEditingController amplitude_bat2  = TextEditingController();
  TextEditingController tension1  = TextEditingController();
  TextEditingController tension2  = TextEditingController();
  TextEditingController TRC1  = TextEditingController();
  TextEditingController TRC2  = TextEditingController();
  TextEditingController glasgow1  = TextEditingController();
  TextEditingController glasgow2  = TextEditingController();
  TextEditingController temp1  = TextEditingController();
  TextEditingController temp2  = TextEditingController();
  TextEditingController glycemie1  = TextEditingController();
  TextEditingController glycemie2  = TextEditingController();
  String unite_glycemie1 = "mg/dl";
  String unite_glycemie2 = "mg/dl";
  List<String> unite = ["mg/dl","g/l","mmol/ml"];


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
        title: const Text('Surveillance'),
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
                title: const Text('Surveillance 1'),
                textColor: Colors.orange[300],
                collapsedTextColor: Colors.black,
                collapsedBackgroundColor: Colors.orange[300],
                iconColor: Colors.black,
                children: <Widget>[
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    keyboardType: TextInputType.multiline,
                    controller: evolution,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Evolution des signes vitaux et du complémentaire',
                    ),
                  )),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    controller: heure1,
                    readOnly: true,  // when true user cannot edit text
                    onTap: () async {
                      await displayTimePicker(context, heure1);
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                      border: OutlineInputBorder(),
                      labelText: 'heure',
                    ),
                  )),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    cursorColor:Colors.black,
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    keyboardType: TextInputType.number,
                    controller: frequence1,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[200]??Colors.blue)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[200]??Colors.blue)),
                      labelText: 'Fréquence (mvt/min)',
                    ),
                  )),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child:
                    Padding(padding: EdgeInsets.all(4),child:
                    Text("Indiquez les pauses >6s", style:TextStyle(fontStyle: FontStyle.italic)),
                    ),
                  ),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    controller: amplitude1,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Amplitude + régularité',
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[600]??Colors.blue)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[600]??Colors.blue)),
                    ),
                  )),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    keyboardType: TextInputType.number,
                    controller: saturation1,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[200]??Colors.blue)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[200]??Colors.blue)),
                      labelText: 'Saturation (%SpO²)',
                    ),
                  )),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    keyboardType: TextInputType.number,
                    controller: frequence_bat1,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red[200]??Colors.red)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red[200]??Colors.red)),
                      border: const OutlineInputBorder(),
                      labelText: 'fréquence (bat/min)',
                    ),
                  )),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    keyboardType: TextInputType.number,
                    controller: amplitude_bat1,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red[600]??Colors.red)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red[600]??Colors.red)),
                      border: const OutlineInputBorder(),
                      labelText: 'Amplitude + régularité',
                    ),
                  )),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    keyboardType: TextInputType.number,
                    controller: tension1,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red[200]??Colors.red)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red[200]??Colors.red)),
                      border: const OutlineInputBorder(),
                      labelText: 'Tension (mm de Hg)',
                    ),
                  )),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    keyboardType: TextInputType.number,
                    controller: TRC1,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red[200]??Colors.red)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red[200]??Colors.red)),
                      border: const OutlineInputBorder(),
                      labelText: 'TRC (s)',
                    ),
                  )),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    keyboardType: TextInputType.number,
                    controller: glasgow1,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green[200]??Colors.green)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green[200]??Colors.green)),
                      labelText: 'Glasgow (se reporter au vital)',
                    ),
                  )),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    keyboardType: TextInputType.number,
                    controller: temp1,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'température (°C)',
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green[600]??Colors.green)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green[600]??Colors.green)),
                    ),
                  )),
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
                            controller: glycemie1,
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
                            value: unite_glycemie1,
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
                                unite_glycemie1 = value!;
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
                ]),
                ExpansionTile(
                    title: const Text('Surveillance 2'),
                    textColor: Colors.orange[500],
                    collapsedTextColor: Colors.black,
                    collapsedBackgroundColor: Colors.orange[500],
                    iconColor: Colors.black,
                    children: <Widget>[
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        keyboardType: TextInputType.multiline,
                        controller: evolution2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Evolution des signes vitaux et du complémentaire',
                        ),
                      )),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: heure2,
                        readOnly: true,  // when true user cannot edit text
                        onTap: () async {
                          await displayTimePicker(context, heure2);
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'heure',
                        ),
                      )),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        keyboardType: TextInputType.number,
                        controller: frequence2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Fréquence (mvt/min)',
                        ),
                      )),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child:
                        Padding(padding: EdgeInsets.all(4),child:
                        Text("Indiquez les pauses >6s", style:TextStyle(fontStyle: FontStyle.italic)),
                        ),
                      ),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: amplitude2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Amplitude + régularité',
                        ),
                      )),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        keyboardType: TextInputType.number,
                        controller: saturation2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Saturation (%SpO²)',
                        ),
                      )),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        keyboardType: TextInputType.number,
                        controller: frequence_bat2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'fréquence (bat/min)',
                        ),
                      )),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        keyboardType: TextInputType.number,
                        controller: amplitude_bat2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Amplitude + régularité',
                        ),
                      )),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        keyboardType: TextInputType.number,
                        controller: tension2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Tension (mm de Hg)',
                        ),
                      )),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        keyboardType: TextInputType.number,
                        controller: TRC2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'TRC (s)',
                        ),
                      )),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        keyboardType: TextInputType.number,
                        controller: glasgow2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Glasgow (se reporter au vital)',
                        ),
                      )),
                      Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        keyboardType: TextInputType.number,
                        controller: temp2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'température (°C)',
                        ),
                      )),
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
                                controller: glycemie2,
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
                                value: unite_glycemie2,
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
                                    unite_glycemie2 = value!;
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
    PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
    prefs = await SharedPreferences.getInstance();
    setState(() {
      evolution.text  = (doc.form.fields[prefs.getInt("surveillance_1")??0] as PdfTextBoxField).text;
      evolution2.text  = (doc.form.fields[prefs.getInt("surveillance_2")??0] as PdfTextBoxField).text;
      heure1.text  = (doc.form.fields[prefs.getInt("heure_surveillance1")??0] as PdfTextBoxField).text;
      heure2.text  = (doc.form.fields[prefs.getInt("heure_surveillance2")??0] as PdfTextBoxField).text;
      frequence1.text  = (doc.form.fields[prefs.getInt("frequence_surveillance1")??0] as PdfTextBoxField).text;
      frequence2.text  = (doc.form.fields[prefs.getInt("frequence_surveillance2")??0] as PdfTextBoxField).text;
      amplitude1.text  = (doc.form.fields[prefs.getInt("pauses_surveillance1")??0] as PdfTextBoxField).text;
      amplitude2.text  = (doc.form.fields[prefs.getInt("pauses_surveillance2")??0] as PdfTextBoxField).text;
      saturation1.text  = (doc.form.fields[prefs.getInt("saturation_surveillance1")??0] as PdfTextBoxField).text;
      saturation2.text  = (doc.form.fields[prefs.getInt("saturation_surveillance2")??0] as PdfTextBoxField).text;
      frequence_bat1.text  = (doc.form.fields[prefs.getInt("bat_surveillance1")??0] as PdfTextBoxField).text;
      frequence_bat2.text  = (doc.form.fields[prefs.getInt("bat_surveillance2")??0] as PdfTextBoxField).text;
      amplitude_bat1.text  = (doc.form.fields[prefs.getInt("amplitude_surveillance1")??0] as PdfTextBoxField).text;
      amplitude_bat2.text  = (doc.form.fields[prefs.getInt("amplitude_surveillance2")??0] as PdfTextBoxField).text;
      tension1.text  = (doc.form.fields[prefs.getInt("hg_surveillance1")??0] as PdfTextBoxField).text;
      tension2.text  = (doc.form.fields[prefs.getInt("hg_surveillance2")??0] as PdfTextBoxField).text;
      TRC1.text  = (doc.form.fields[prefs.getInt("sec_surveillance1")??0] as PdfTextBoxField).text;
      TRC2.text  = (doc.form.fields[prefs.getInt("sec_surveillance2")??0] as PdfTextBoxField).text;
      glasgow1.text  = (doc.form.fields[prefs.getInt("glasgow_surveillance1")??0] as PdfTextBoxField).text;
      glasgow2.text  = (doc.form.fields[prefs.getInt("glasgow_surveillance2")??0] as PdfTextBoxField).text;
      temp1.text  = (doc.form.fields[prefs.getInt("temperature_surveillance1")??0] as PdfTextBoxField).text;
      temp2.text  = (doc.form.fields[prefs.getInt("temperature_surveillance2")??0] as PdfTextBoxField).text;
      glycemie1.text  = (doc.form.fields[prefs.getInt("glycemie_surveillance1")??0] as PdfTextBoxField).text;
      glycemie2.text  = (doc.form.fields[prefs.getInt("glycemie_surveillance2")??0] as PdfTextBoxField).text;
      unite_glycemie1 = unite[(doc.form.fields[prefs.getInt("unite_surveillance1")??0] as PdfRadioButtonListField).selectedIndex];
      unite_glycemie2 = unite[(doc.form.fields[prefs.getInt("unite_surveillance2")??0] as PdfRadioButtonListField).selectedIndex];
    });
    setState(() {
      future = "ok";
    });
  }

  metChampsAJour() async {
    setState(() {
      future="";
    });
    await Future.delayed(const Duration(milliseconds: 1));
    PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
    (doc.form.fields[prefs.getInt("surveillance_1")??0] as PdfTextBoxField).text = evolution.text;
    (doc.form.fields[prefs.getInt("surveillance_2")??0] as PdfTextBoxField).text = evolution2.text;
    (doc.form.fields[prefs.getInt("heure_surveillance1")??0] as PdfTextBoxField).text = heure1.text;
    (doc.form.fields[prefs.getInt("heure_surveillance2")??0] as PdfTextBoxField).text = heure2.text;
    (doc.form.fields[prefs.getInt("frequence_surveillance1")??0] as PdfTextBoxField).text = frequence1.text;
    (doc.form.fields[prefs.getInt("frequence_surveillance2")??0] as PdfTextBoxField).text = frequence2.text;
    (doc.form.fields[prefs.getInt("pauses_surveillance1")??0] as PdfTextBoxField).text = amplitude1.text;
    (doc.form.fields[prefs.getInt("pauses_surveillance2")??0] as PdfTextBoxField).text = amplitude2.text;
    (doc.form.fields[prefs.getInt("saturation_surveillance1")??0] as PdfTextBoxField).text = saturation1.text;
    (doc.form.fields[prefs.getInt("saturation_surveillance2")??0] as PdfTextBoxField).text = saturation2.text;
    (doc.form.fields[prefs.getInt("bat_surveillance1")??0] as PdfTextBoxField).text = frequence_bat1.text;
    (doc.form.fields[prefs.getInt("bat_surveillance2")??0] as PdfTextBoxField).text = frequence_bat2.text;
    (doc.form.fields[prefs.getInt("amplitude_surveillance1")??0] as PdfTextBoxField).text = amplitude_bat1.text;
    (doc.form.fields[prefs.getInt("amplitude_surveillance2")??0] as PdfTextBoxField).text = amplitude_bat2.text;
    (doc.form.fields[prefs.getInt("hg_surveillance1")??0] as PdfTextBoxField).text = tension1.text;
    (doc.form.fields[prefs.getInt("hg_surveillance2")??0] as PdfTextBoxField).text = tension2.text;
    (doc.form.fields[prefs.getInt("sec_surveillance1")??0] as PdfTextBoxField).text = TRC1.text;
    (doc.form.fields[prefs.getInt("sec_surveillance2")??0] as PdfTextBoxField).text = TRC2.text;
    (doc.form.fields[prefs.getInt("glasgow_surveillance1")??0] as PdfTextBoxField).text = glasgow1.text;
    (doc.form.fields[prefs.getInt("glasgow_surveillance2")??0] as PdfTextBoxField).text = glasgow2.text;
    (doc.form.fields[prefs.getInt("temperature_surveillance1")??0] as PdfTextBoxField).text = temp1.text;
    (doc.form.fields[prefs.getInt("temperature_surveillance2")??0] as PdfTextBoxField).text = temp2.text;
    (doc.form.fields[prefs.getInt("glycemie_surveillance1")??0] as PdfTextBoxField).text = glycemie1.text;
    (doc.form.fields[prefs.getInt("glycemie_surveillance2")??0] as PdfTextBoxField).text = glycemie2.text;
    (doc.form.fields[prefs.getInt("unite_surveillance1")??0] as PdfRadioButtonListField).selectedIndex = unite.indexOf(unite_glycemie1);
    (doc.form.fields[prefs.getInt("unite_surveillance2")??0] as PdfRadioButtonListField).selectedIndex = unite.indexOf(unite_glycemie2);
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