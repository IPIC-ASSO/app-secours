import 'package:app_secours/menu.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'Officiant.dart';

class Circonstanciel extends StatefulWidget {

  String chemin;

  Circonstanciel({super.key, required this.chemin});

  @override
  State<Circonstanciel> createState() => _CirconstancielState();
}

class _CirconstancielState extends State<Circonstanciel> {

  bool enr = true;
  String future = "";
  DateTime selectedDate = DateTime.now();
  bool supr = false;
  bool balise = false;
  bool degage = false;
  bool equ_secu = false;
  bool renforts = false;
  bool SMV = false;
  bool moyens = false;
  TextEditingController securite  = TextEditingController();
  TextEditingController scene  = TextEditingController();
  TextEditingController quepasta  = TextEditingController();
  TextEditingController plainte  = TextEditingController();
  TextEditingController heure  = TextEditingController();

  @override
  void initState() {
    litFichier();
    super.initState();
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
                    labelText: 'Securité, danger(s) persistant(s)',
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
                  title: const Text("Renforts SMV pour:"),
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
                  title: const Text("Moyen suffisants OU renforts"),
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
                Flexible(
                  flex: 1,
                  child:
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
      securite.text = (doc.form.fields[11] as PdfTextBoxField).text;
      //supr = (doc.form.fields[12] as PdfCheckBoxField).isChecked;
      //balise = (doc.form.fields[13] as PdfCheckBoxField).isChecked;
      //degage = (doc.form.fields[14] as PdfCheckBoxField).isChecked;
      //equ_secu = (doc.form.fields[15] as PdfCheckBoxField).isChecked;
      //renforts = (doc.form.fields[16] as PdfCheckBoxField).isChecked;
      scene.text = (doc.form.fields[17] as PdfTextBoxField).text;
      quepasta.text = (doc.form.fields[18] as PdfTextBoxField).text;
      //SMV = (doc.form.fields[19] as PdfCheckBoxField).isChecked;
      plainte.text = (doc.form.fields[20] as PdfTextBoxField).text;
      //moyens = (doc.form.fields[21] as PdfCheckBoxField).isChecked;
      heure.text = (doc.form.fields[22] as PdfTextBoxField).text;
    });
    setState(() {
      future = "ok";
    });
  }

  metChampsAJour() async {
    PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
    (doc.form.fields[0] as PdfTextBoxField).text = securite.text;
    (doc.form.fields[1] as PdfCheckBoxField).isChecked = supr;
    (doc.form.fields[2] as PdfCheckBoxField).isChecked = balise;
    (doc.form.fields[3] as PdfCheckBoxField).isChecked = degage;
    (doc.form.fields[4] as PdfCheckBoxField).isChecked = equ_secu;
    (doc.form.fields[5] as PdfCheckBoxField).isChecked = renforts;
    (doc.form.fields[6] as PdfTextBoxField).text = scene.text;
    (doc.form.fields[7] as PdfTextBoxField).text = quepasta.text;
    (doc.form.fields[5] as PdfCheckBoxField).isChecked = SMV;
    (doc.form.fields[9] as PdfTextBoxField).text = plainte.text;
    (doc.form.fields[5] as PdfCheckBoxField).isChecked = moyens;
    (doc.form.fields[8] as PdfTextBoxField).text = heure.text;
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