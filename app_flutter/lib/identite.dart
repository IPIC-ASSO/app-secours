import 'package:app_secours/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:intl/intl.dart';

import 'Officiant.dart';

class Identite extends StatefulWidget {

  String chemin;

  Identite({super.key, required this.chemin});

  @override
  State<Identite> createState() => _IdentiteState();
}

class _IdentiteState extends State<Identite> {

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
    if (future !=null && future == "ok"){
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
      nomPrenom.text = (doc.form.fields[0] as PdfTextBoxField).text;
      nomFille.text = (doc.form.fields[1] as PdfTextBoxField).text;
      date.text = (doc.form.fields[2] as PdfTextBoxField).text;
      lieuNez.text = (doc.form.fields[3] as PdfTextBoxField).text;
      adresse.text = (doc.form.fields[4] as PdfTextBoxField).text;
      CP.text = (doc.form.fields[5] as PdfTextBoxField).text;
      ville.text = (doc.form.fields[6] as PdfTextBoxField).text;
      tel.text = (doc.form.fields[7] as PdfTextBoxField).text;
      qui.text = (doc.form.fields[8] as PdfTextBoxField).text;
      telQui.text = (doc.form.fields[9] as PdfTextBoxField).text;
    });
    setState(() {
      future = "ok";
    });
  }

  metChampsAJour() async {
    PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
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
}