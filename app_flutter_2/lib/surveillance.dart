import 'package:app_secours/menu.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'Officiant.dart';

class Surveillance extends StatefulWidget {

  String chemin;

  Surveillance({super.key, required this.chemin});

  @override
  State<Surveillance> createState() => _SurveillanceState();
}

class _SurveillanceState extends State<Surveillance> {

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


  @override
  void initState() {
    litFichier();
    super.initState();
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
                  const Positioned(child: Align(
                    alignment: Alignment.centerLeft,
                    child:
                    Padding(padding: EdgeInsets.all(4),child:
                    const Text("Indiquez les pauses >6s", style:TextStyle(fontStyle: FontStyle.italic)),
                    ),
                  )),
                  Padding(padding:const EdgeInsets.all(4),child: TextField(
                    onChanged: (text){setState(() {
                      enr = false;
                    }); },
                    controller: amplitude1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
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
                      border: OutlineInputBorder(),
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
                      border: OutlineInputBorder(),
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
                      border: OutlineInputBorder(),
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
                      border: OutlineInputBorder(),
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
                      border: OutlineInputBorder(),
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
                      border: OutlineInputBorder(),
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
                      border: OutlineInputBorder(),
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
                      const Positioned(child: Align(
                        alignment: Alignment.centerLeft,
                        child:
                        Padding(padding: EdgeInsets.all(4),child:
                        const Text("Indiquez les pauses >6s", style:TextStyle(fontStyle: FontStyle.italic)),
                        ),
                      )),
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
      /*securite.text = (doc.form.fields[11] as PdfTextBoxField).text;
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
      heure.text = (doc.form.fields[22] as PdfTextBoxField).text;*/
    });
    setState(() {
      future = "ok";
    });
  }

  metChampsAJour() async {
    PdfDocument doc = await Officiant().litFichier(widget.chemin, context);
    /*(doc.form.fields[0] as PdfTextBoxField).text = securite.text;
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
    (doc.form.fields[8] as PdfTextBoxField).text = heure.text;*/
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
                    if (x =="0"){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Un fichier du même nom existe déjà"),));return;}
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