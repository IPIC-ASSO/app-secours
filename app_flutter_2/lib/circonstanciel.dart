import 'package:app_secours/charge.dart';
import 'package:app_secours/menu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'Officiant.dart';

class Circonstanciel extends StatefulWidget {

  String chemin;

  Circonstanciel({super.key, required this.chemin});

  @override
  State<Circonstanciel> createState() => _CirconstancielState();
}

class _CirconstancielState extends State<Circonstanciel> with TickerProviderStateMixin {

  late AnimationController _controller;
  late final SharedPreferences prefs;
  bool enr = true;
  String future = "";
  bool supr = false;
  bool balise = false;
  bool degage = false;
  bool equ_secu = false;
  bool renforts = false;
  bool SMV = false;
  TextEditingController implique  = TextEditingController();
  TextEditingController UR  = TextEditingController();
  TextEditingController UA  = TextEditingController();
  TextEditingController decede  = TextEditingController();
  bool moyens = false;
  TextEditingController moyens_suffisants  = TextEditingController();
  TextEditingController securite  = TextEditingController();
  TextEditingController scene  = TextEditingController();
  TextEditingController quepasta  = TextEditingController();
  TextEditingController plainte  = TextEditingController();
  TextEditingController heure  = TextEditingController();

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
        title: const Text('Circonstanciel'),
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
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  controller: securite,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Sécurité, danger(s) persistant(s)',
                  ),
                )),
                Row(
                  children: [
                    Flexible(child:
                      CheckboxListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: const Text("Supprimé"),
                        value: supr,
                        onChanged: (vla) {
                          setState(() {
                            enr = false;
                            supr = vla??false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                        ),
                    ),
                    Flexible(child:
                      CheckboxListTile(
                        title: const Text("Balisé"),
                        contentPadding: const EdgeInsets.all(0),
                        value: balise,
                        onChanged: (vla) {
                          setState(() {
                            enr = false;
                            balise = vla??false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                    ),
                    Flexible(child:
                    CheckboxListTile(
                      title: const Text("Dégagement Urg."),
                      contentPadding: const EdgeInsets.all(0),
                      value: degage,
                      onChanged: (vla) {
                        setState(() {
                          enr = false;
                          degage = vla??false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                    ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.orange[200],
                  child:Row(
                    children: [
                      Flexible(child:
                      CheckboxListTile(
                        title: const Text("EQUIPE EN SECURITE"),
                        contentPadding: const EdgeInsets.all(0),
                        value: equ_secu,
                        onChanged: (vla) {
                          setState(() {
                            enr = false;
                            equ_secu = vla??false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      ),
                      Flexible(child:
                      CheckboxListTile(
                        title: const Text("RENFORTS ?"),
                        contentPadding: const EdgeInsets.all(0),
                        value: renforts,
                        onChanged: (vla) {
                          setState(() {
                            enr = false;
                            renforts = vla??false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                      ),
                    ],
                  ),
                ),
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  controller: scene,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Scène, lieu intervention/accès',
                  ),
                )),
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  controller: quepasta,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Que s\'est-il passé?',
                  ),
                )),
                CheckboxListTile(
                  title: const Text("Renforts SMV"),
                  contentPadding: const EdgeInsets.all(0),
                  value: SMV,
                  onChanged: (vla) {
                    setState(() {
                      enr = false;
                      SMV = vla??false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                ),
                Visibility(
                  visible: SMV,
                  child:
                    Column(children: [
                      Row(children: <Widget>[
                        Flexible(flex: 1,child:
                        SizedBox(
                            width: 1000,
                            child:Padding(padding:const EdgeInsets.all(4),child: TextField(
                              onChanged: (text){setState(() {
                                enr = false;
                              }); },
                              controller: implique,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                                labelText: 'IMPLIQUES',
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
                              controller: UR,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
                                labelText: 'UR',
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
                              controller: UA,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                labelText: 'UA',
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
                              controller: decede,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                labelText: 'DECEDES',
                              ),
                            ))
                        ), ),
                      ],),
                    ],)
                ),
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  controller: plainte,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Situation, plainte(s) principale(s)',
                  ),
                )),
                CheckboxListTile(
                  title: const Text("Moyens suffisants OU renforts"),
                  contentPadding: const EdgeInsets.all(0),
                  value: moyens,
                  onChanged: (vla) {
                    setState(() {
                      enr = false;
                      moyens = vla??false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                ),
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  controller: moyens_suffisants,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'moyens/renforts',
                  ),
                )),
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
                    labelText: 'heure de transmission',
                  ),
                ))
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
      securite.text = (doc.form.fields[prefs.getInt("danger")??0] as PdfTextBoxField).text;
      supr = (doc.form.fields[prefs.getInt("supprime")??0] as PdfCheckBoxField).isChecked;
      balise = (doc.form.fields[prefs.getInt("balise")??0] as PdfCheckBoxField).isChecked;
      degage = (doc.form.fields[prefs.getInt("degagement_urg")??0] as PdfCheckBoxField).isChecked;
      equ_secu = (doc.form.fields[prefs.getInt("equipe_secu")??0] as PdfCheckBoxField).isChecked;
      renforts = (doc.form.fields[prefs.getInt("renforts")??0] as PdfCheckBoxField).isChecked;
      scene.text = (doc.form.fields[prefs.getInt("scene")??0] as PdfTextBoxField).text;
      quepasta.text = (doc.form.fields[prefs.getInt("que_pasta")??0] as PdfTextBoxField).text;
      SMV = (doc.form.fields[prefs.getInt("renforts_SMV")??0] as PdfCheckBoxField).isChecked;
      implique.text  = (doc.form.fields[prefs.getInt("implique")??0] as PdfTextBoxField).text;
      UR.text  = (doc.form.fields[prefs.getInt("UR")??0] as PdfTextBoxField).text;
      UA.text  = (doc.form.fields[prefs.getInt("UA")??0] as PdfTextBoxField).text;
      decede.text = (doc.form.fields[prefs.getInt("decede")??0] as PdfTextBoxField).text;
      plainte.text = (doc.form.fields[prefs.getInt("plainte")??0] as PdfTextBoxField).text;
      moyens = (doc.form.fields[prefs.getInt("suffisant")??0] as PdfCheckBoxField).isChecked;
      moyens_suffisants.text = (doc.form.fields[prefs.getInt("moyens_renforts")??0] as PdfTextBoxField).text;
      heure.text = (doc.form.fields[prefs.getInt("heure_transmis")??0] as PdfTextBoxField).text;
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
    PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
    (doc.form.fields[prefs.getInt("danger")??0] as PdfTextBoxField).text = securite.text;
    (doc.form.fields[prefs.getInt("supprime")??0] as PdfCheckBoxField).isChecked = supr;
    (doc.form.fields[prefs.getInt("balise")??0] as PdfCheckBoxField).isChecked = balise;
    (doc.form.fields[prefs.getInt("degagement_urg")??0] as PdfCheckBoxField).isChecked = degage;
    (doc.form.fields[prefs.getInt("equipe_secu")??0] as PdfCheckBoxField).isChecked = equ_secu;
    (doc.form.fields[prefs.getInt("renforts")??0] as PdfCheckBoxField).isChecked = renforts;
    (doc.form.fields[prefs.getInt("scene")??0] as PdfTextBoxField).text = scene.text;
    (doc.form.fields[prefs.getInt("que_pasta")??0] as PdfTextBoxField).text = quepasta.text;
    (doc.form.fields[prefs.getInt("renforts_SMV")??0] as PdfCheckBoxField).isChecked = SMV;
    (doc.form.fields[prefs.getInt("implique")??0] as PdfTextBoxField).text = implique.text;
    (doc.form.fields[prefs.getInt("UR")??0] as PdfTextBoxField).text = UR.text;
    (doc.form.fields[prefs.getInt("UA")??0] as PdfTextBoxField).text = UA.text;
    (doc.form.fields[prefs.getInt("decede")??0] as PdfTextBoxField).text = decede.text;
    (doc.form.fields[prefs.getInt("plainte")??0] as PdfTextBoxField).text = plainte.text;
    (doc.form.fields[prefs.getInt("suffisant")??0] as PdfCheckBoxField).isChecked = moyens;
    (doc.form.fields[prefs.getInt("moyens_renforts")??0] as PdfTextBoxField).text = moyens_suffisants.text;
    (doc.form.fields[prefs.getInt("heure_transmis")??0] as PdfTextBoxField).text = heure.text;

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