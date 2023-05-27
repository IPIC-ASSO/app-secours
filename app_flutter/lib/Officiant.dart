import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class Officiant{

  Officiant(){}

  Future<PdfDocument> litFichier(String chemin, BuildContext context) async {
    final PdfDocument doc;
    if (chemin==""){
      final ByteData data = await rootBundle.load('assets/fiche_bilan_V2.pdf');
      final Uint8List bytes = data.buffer.asUint8List();
      doc = PdfDocument(inputBytes: bytes);
    }else{
      doc = PdfDocument(inputBytes: File(chemin).readAsBytesSync());
    }
    return doc;
  }

  Future<bool> enregistreFichier(String chemin, PdfDocument document)async{
    if(chemin!=null){
      print(document.form.fields.count);
      print(chemin);
      File(chemin).writeAsBytesSync(await document.save().catchError((err)=> print(err)));
      return true;
    }
    return false;
  }

  Future<String> nouveauChemin(String nom_dispositif) async {
    Directory? telechargements;
    if (Platform.isIOS) {
      telechargements = await getDownloadsDirectory();
    } else {
      telechargements = Directory('/storage/emulated/0/Download');
    }
    if(telechargements!=null){
      if (await File(telechargements.path + "/app_pro_civile/"+ nom_dispositif).exists()){
        return "0";
      }else{
        return telechargements.path + "/app_pro_civile/"+ nom_dispositif+".pdf";
      }
    }else return "1";
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  Future<bool> Confirme(context) async {
    bool continu = true;
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Avertissement'),
          content:Text('Des modifications n\'ont pas été enregistrées, souhaitez vous quand même changer de page?'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(_);
                },
                child: Text('Continuer')),
            ElevatedButton(
                onPressed: () {
                  continu = false;
                  Navigator.pop(_);
                },
                child: Text('Annuler')),
          ],
          elevation: 24,
        ),
        barrierDismissible: false);
    return continu;
  }
}