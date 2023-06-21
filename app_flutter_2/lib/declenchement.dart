import 'package:app_secours/Officiant.dart';
import 'package:app_secours/charge.dart';
import 'package:app_secours/menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class Declenchement extends StatefulWidget {

  String chemin;

  Declenchement({super.key, required this.chemin});

  @override
  State<Declenchement> createState() => _DeclenchementState();
}

class _DeclenchementState extends State<Declenchement> with TickerProviderStateMixin {

  late AnimationController _controller;
  late final SharedPreferences prefs;
  bool enr = true;
  bool charge = false;
  String future = "";
  DateTime selectedDate = DateTime.now();
  TextEditingController dispositif  = TextEditingController();
  TextEditingController numeros  = TextEditingController();
  TextEditingController equipe  = TextEditingController();
  TextEditingController date  = TextEditingController();
  TextEditingController heure  = TextEditingController();
  TextEditingController num_dispositif  = TextEditingController();
  TextEditingController motif  = TextEditingController();
  TextEditingController adresse  = TextEditingController();
  TextEditingController depart_equipe  = TextEditingController();
  TextEditingController heure_depart  = TextEditingController();
  TextEditingController sur_lieux  = TextEditingController();

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
        title: const Text('Déclenchement'),
        actions: [
            IconButton(
                icon: const Icon(Icons.save),
                onPressed: () async {
                  setState(() {
                    future = "";
                  });
                  await metChampsAJour();
                  setState(() {
                    future = "ok";
                  });
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
                Row(
                  children: <Widget>[
                    Flexible(flex: 5,child:
                    SizedBox(
                        width: 1000,
                        child:Padding(padding:const EdgeInsets.all(4),child: TextField(
                          onChanged: (text){setState(() {
                            enr = false;
                          }); },
                          controller: dispositif,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Dispositif',
                          ),
                        ))
                    ),),
                    Flexible(flex: 1,child:
                    SizedBox(
                        width: 1000,
                        child:Padding(padding:const EdgeInsets.all(4),child: TextField(
                          onChanged: (text)=>{enr=false},
                          controller: numeros,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'N°',
                          ),
                        ))
                    ), ),
                  ],
                ),
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  controller: equipe,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Equipe',
                  ),
                )),
                Row(children: <Widget>[
                  Flexible(flex: 1,child:
                  SizedBox(
                      width: 1000,
                      child:Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: date,
                        readOnly: true,  // when true user cannot edit text
                        onTap: () async {
                          _selectDate(context);
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'date',
                        ),
                      ))
                  ),),
                  Flexible( flex: 1, child:
                  SizedBox(
                      width: 1000,
                      child:Padding(padding:const EdgeInsets.all(4),child: TextField(
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
                      ))
                  ),),
                ],
                ),
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  controller: num_dispositif,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Numéros fiche',
                  ),
                )),
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: motif,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Motif de départ',
                  ),
                )),
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: adresse,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Adresse',
                  ),
                ))
                ,
                Row(children: <Widget>[
                  Flexible(flex: 1,child:
                  SizedBox(
                      width: 1000,
                      child:Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: depart_equipe,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'départ équipe',
                        ),
                      ))
                  ),),
                  Flexible(flex: 1,child:
                  SizedBox(
                      width: 1000,
                      child:Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: heure_depart,
                        readOnly: true,  // when true user cannot edit text
                        onTap: () async {
                          await displayTimePicker(context, heure_depart);
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'heure de départ',
                        ),
                      ))
                  ),),
                ],
                ),
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  controller: sur_lieux,
                  readOnly: true,  // when true user cannot edit text
                  onTap: () async {
                    await displayTimePicker(context, sur_lieux);
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Sur les lieux à:',
                  ),
                )),
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
        lastDate: DateTime(2101));
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


  litFichier()async{
    PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
    prefs = await SharedPreferences.getInstance();
    setState(() {
      dispositif.text = (doc.form.fields[prefs.getInt("dispositif")??0] as PdfTextBoxField).text;
      numeros.text = (doc.form.fields[prefs.getInt("num")??0] as PdfTextBoxField).text;
      equipe.text = (doc.form.fields[prefs.getInt("equipe")??0] as PdfTextBoxField).text;
      date.text = (doc.form.fields[prefs.getInt("date")??0] as PdfTextBoxField).text;
      heure.text = (doc.form.fields[prefs.getInt("heure")??0] as PdfTextBoxField).text;
      num_dispositif.text = (doc.form.fields[prefs.getInt("num_fiche")??0] as PdfTextBoxField).text;
      motif.text = (doc.form.fields[prefs.getInt("motif")??0] as PdfTextBoxField).text;
      adresse.text = (doc.form.fields[prefs.getInt("adresse")??0] as PdfTextBoxField).text;
      depart_equipe.text = (doc.form.fields[prefs.getInt("dep_equipe")??0] as PdfTextBoxField).text;
      heure_depart.text = (doc.form.fields[prefs.getInt("heure_dep")??0] as PdfTextBoxField).text;
      sur_lieux.text = (doc.form.fields[prefs.getInt("heure_lieu")??0] as PdfTextBoxField).text;
    });
    if (dispositif.text.isEmpty){
      List<String> x = widget.chemin.split("/");
      setState(() {
        dispositif.text = x[x.length-2];
      });
    }
    setState(() {
      future = "ok";
    });
  }

  metChampsAJour() async {
    PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
    (doc.form.fields[prefs.getInt("dispositif")??0] as PdfTextBoxField).text = dispositif.text;
    (doc.form.fields[prefs.getInt("num")??0] as PdfTextBoxField).text = numeros.text;
    (doc.form.fields[prefs.getInt("equipe")??0] as PdfTextBoxField).text = equipe.text;
    (doc.form.fields[prefs.getInt("date")??0] as PdfTextBoxField).text = date.text;
    (doc.form.fields[prefs.getInt("heure")??0] as PdfTextBoxField).text = heure.text;
    (doc.form.fields[prefs.getInt("num_fiche")??0] as PdfTextBoxField).text = num_dispositif.text;
    (doc.form.fields[prefs.getInt("motif")??0] as PdfTextBoxField).text = motif.text;
    (doc.form.fields[prefs.getInt("adresse")??0] as PdfTextBoxField).text = adresse.text;
    (doc.form.fields[prefs.getInt("dep_equipe")??0] as PdfTextBoxField).text = depart_equipe.text;
    (doc.form.fields[prefs.getInt("heure_dep")??0] as PdfTextBoxField).text = heure_depart.text;
    (doc.form.fields[prefs.getInt("heure_lieu")??0] as PdfTextBoxField).text = sur_lieux.text;
    Officiant().enregistreFichier(widget.chemin, doc).then((value) => {
      if (value)ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enregistré !"),))
      else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Une erreur est survenue :/"),))
    });
    setState(() {
      enr = true;
    });
  }
}