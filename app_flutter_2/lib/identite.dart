import 'package:app_secours/charge.dart';
import 'package:app_secours/menu.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:intl/intl.dart';

import 'Officiant.dart';

class Identite extends StatefulWidget {

  String chemin;

  Identite({super.key, required this.chemin});

  @override
  State<Identite> createState() => _IdentiteState();
}

class _IdentiteState extends State<Identite> with TickerProviderStateMixin {

  late AnimationController _controller;
  late final SharedPreferences prefs;
  bool enr = true;
  String future = "";
  DateTime selectedDate = DateTime.now();
  TextEditingController nomPrenom  = TextEditingController();
  TextEditingController nomFille  = TextEditingController();
  TextEditingController date  = TextEditingController();
  TextEditingController lieuNez  = TextEditingController();
  TextEditingController dossard  = TextEditingController();
  TextEditingController adresse  = TextEditingController();
  TextEditingController CP  = TextEditingController();
  TextEditingController ville  = TextEditingController();
  TextEditingController tel  = TextEditingController();
  TextEditingController qui  = TextEditingController();
  TextEditingController telQui  = TextEditingController();

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
        title: const Text('Identité'),
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
                  controller: nomPrenom,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nom, Prénom',
                  ),
                )),
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  controller: nomFille,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nom (jeune fille)',
                  ),
                )),
                Row(children: <Widget>[
                  Flexible(
                    flex: 1,
                    child:
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
                          labelText: 'Né(e) le:',
                        ),
                      ))
                  ),),
                  Flexible(
                    flex: 1,
                    child:
                  SizedBox(
                      width: 1000,
                      child:Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: lieuNez,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Lieu de naissance',
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
                  controller: dossard,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Dossard',
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
                  Flexible(
                    flex: 1,
                    child:
                  SizedBox(
                      width: 1000,
                      child:Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: CP,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CP',
                        ),
                      ))
                  ),),
                  Flexible(
                    flex: 1,
                    child:
                  SizedBox(
                      width: 1000,
                      child:Padding(padding:const EdgeInsets.all(4),child: TextField(
                        onChanged: (text){setState(() {
                          enr = false;
                        }); },
                        controller: ville,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'ville',
                        ),
                      ))
                  ),),
                ],
                ),
                Padding(padding:const EdgeInsets.all(4),child: IntlPhoneField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  controller: tel,
                  initialCountryCode: 'FR',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Téléphone:',
                  ),
                )),
                Padding(padding:const EdgeInsets.all(4),child: TextField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  controller: qui,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                      labelText: 'Qui prévenir ? ',
                  ),
                )),
                Padding(padding:const EdgeInsets.all(4),child: IntlPhoneField(
                  onChanged: (text){setState(() {
                    enr = false;
                  }); },
                  controller: telQui,
                  initialCountryCode: 'FR',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tél. à prévenir:',
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

  litFichier()async{
    PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
    prefs = await SharedPreferences.getInstance();
    setState(() {
      nomPrenom.text = (doc.form.fields[prefs.getInt("nom_prenom")??0] as PdfTextBoxField).text;
      nomFille.text = (doc.form.fields[prefs.getInt("nom_fille")??0] as PdfTextBoxField).text;
      date.text = (doc.form.fields[prefs.getInt("date_naissance")??0] as PdfTextBoxField).text;
      lieuNez.text = (doc.form.fields[prefs.getInt("lieu_naissance")??0] as PdfTextBoxField).text;
      dossard.text = (doc.form.fields[prefs.getInt("dossard")??0] as PdfTextBoxField).text;
      adresse.text = (doc.form.fields[prefs.getInt("adresse_v")??0] as PdfTextBoxField).text;
      CP.text = (doc.form.fields[prefs.getInt("CP")??0] as PdfTextBoxField).text;
      ville.text = (doc.form.fields[prefs.getInt("ville")??0] as PdfTextBoxField).text;
      tel.text = (doc.form.fields[prefs.getInt("tel")??0] as PdfTextBoxField).text;
      qui.text = (doc.form.fields[prefs.getInt("qui_prevenir")??0] as PdfTextBoxField).text;
      telQui.text = (doc.form.fields[prefs.getInt("tel_prevenir")??0] as PdfTextBoxField).text;
    });
    setState(() {
      future = "ok";
    });
  }

  metChampsAJour() async {
    PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
    (doc.form.fields[prefs.getInt("nom_prenom")??0] as PdfTextBoxField).text = nomPrenom.text;
    (doc.form.fields[prefs.getInt("nom_fille")??0] as PdfTextBoxField).text = nomFille.text;
    (doc.form.fields[prefs.getInt("date_naissance")??0] as PdfTextBoxField).text = date.text;
    (doc.form.fields[prefs.getInt("lieu_naissance")??0] as PdfTextBoxField).text = lieuNez.text;
    (doc.form.fields[prefs.getInt("dossard")??0] as PdfTextBoxField).text = dossard.text;
    (doc.form.fields[prefs.getInt("adresse_v")??0] as PdfTextBoxField).text = adresse.text;
    (doc.form.fields[prefs.getInt("CP")??0] as PdfTextBoxField).text = CP.text;
    (doc.form.fields[prefs.getInt("ville")??0] as PdfTextBoxField).text = ville.text;
    (doc.form.fields[prefs.getInt("tel")??0] as PdfTextBoxField).text = tel.text;
    (doc.form.fields[prefs.getInt("qui_prevenir")??0] as PdfTextBoxField).text = qui.text;
    (doc.form.fields[prefs.getInt("tel_prevenir")??0] as PdfTextBoxField).text = telQui.text;

    Officiant().enregistreFichier(widget.chemin, doc).then((value) => {
      if (value)ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enregistré !"),))
      else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Une erreur est survenue :/"),))
    });

    setState(() {
      enr = true;
    });
  }

  //TODO: remplir dispositif,
}