import 'package:app_secours/Officiant.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';

import 'menu.dart';

class Partager extends StatefulWidget {

  String chemin;

  Partager({super.key, required this.chemin});

  @override
  State<Partager> createState() => _PartagerState();
}

class _PartagerState extends State<Partager> with TickerProviderStateMixin {

  late AnimationController _controller;
  @override
  void initState() {
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
        title: const Text('Partager'),
      ),
      body: corps(),
      drawer:Menu(widget.chemin,true),
    );
  }

  Widget corps(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(3,8,3,3),
      child:ListView(
      children: [
        const Icon(Icons.settings_input_composite_outlined),
        const Center(child:Text("En chantier")),
        Padding(
          padding: const EdgeInsets.all(4),
          child: ElevatedButton(
            child: Row(
                children: const [
                  Expanded(flex:0,child: Icon(Icons.picture_as_pdf,color: Colors.white,)),
                  Expanded(child: Text(
                    'Voir le Pdf',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),)
                ]),
            onPressed: (){OpenFile.open(widget.chemin);},
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: ElevatedButton(
            child: Row(
                children: const [
                  Expanded(flex:0,child: Icon(Icons.share_rounded,color: Colors.white,)),
                  Expanded(child: Text(
                    'Partager le Pdf',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),)
                ]),
            onPressed: (){
              Share.shareFiles([widget.chemin], text: 'dispositif: ${widget.chemin.split("/")[widget.chemin.split("/").length-2]} n° ${widget.chemin.split("/").last}');
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: ElevatedButton(
            child: Row(
                children: const [
                  Expanded(flex:0,child: Icon(Icons.save_alt,color: Colors.white,)),
                  Expanded(child: Text(
                    'Télécharger le Pdf',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),)
                ]),
            onPressed: (){
              Officiant().enregistreFichierTelechargement(widget.chemin)
                  .then((value)  {
                    if(value)ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Pdf enregistré dans les téléchargements"),));
                    else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enregistrement impossible :/"),));
                  });
            },
          ),
        )
    ])
    );
  }
}