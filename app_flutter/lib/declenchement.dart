import 'package:app_secours/Officiant.dart';
import 'package:app_secours/menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class Declenchement extends StatefulWidget {

  String chemin;

  Declenchement({super.key, required this.chemin});

  @override
  State<Declenchement> createState() => _DeclenchementState();
}

class _DeclenchementState extends State<Declenchement> {

  bool enr = true;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Déclenchement'),
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
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: num_dispositif,
                  decoration: const InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Motif dispositif',
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
                    border: const OutlineInputBorder(),
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
                  Flexible(child:
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
                  ), flex: 1,),
                  Flexible(child:
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
                  ), flex: 1,),
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
    });
    setState(() {
      future = "ok";
    });
  }

  metChampsAJour() async {
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
    });
  }

  Future<bool>enregistre()async{
    if (widget.chemin == ""){
      TextEditingController nomPdf = TextEditingController();
      nomPdf.text = dispositif.text;
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