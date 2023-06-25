import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class Officiant{

  Officiant();

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
    File(chemin).writeAsBytesSync(await document.save().catchError((err)=> log(err.toString())));
    document.dispose();
    return true;
  }

  Future aplatit(String chemin, BuildContext context) async {
    final PdfDocument doc = await litFichier(chemin, context);
    doc.form.flattenAllFields();
    await doc.save().then((value) => doc.dispose());
  }

  Future<bool> enregistreFichierTelechargement(String chemin)async{

    File fichier = File(chemin);
    Directory? telechargements;
    if (Platform.isIOS) {
      telechargements = await getDownloadsDirectory();
    } else {
      telechargements = Directory('/storage/emulated/0/Download');
    }
    if (telechargements!=null) {
      String chemin2 = "${telechargements.path}/app_pro_civile/${chemin.split("/").last}";
      File fichier2 = File(chemin2);
      fichier2.create(recursive: true);
      Uint8List bytes = await fichier.readAsBytes();
      await fichier2.writeAsBytes(bytes);
      return true;
    }
    return false;
  }

  Future<String> nouveauChemin2(String groupe, String nom) async{
    Directory directoire;
    if (!Platform.isIOS) {
      directoire = await getExternalStorageDirectory()??await getApplicationDocumentsDirectory();
    } else {
      directoire = await getApplicationDocumentsDirectory();
    }
    if (await File("${directoire.path}/pdf/$groupe/$nom.pdf").exists()){
      return "0";
    }else{
      final dossier = Directory("${directoire.path}/pdf/$groupe");
      if (!await dossier.exists()){
        await dossier.create(recursive: true);
      }
      return "${directoire.path}/pdf/$groupe/$nom.pdf";
    }
  }

  Future suprDirectoire(String disp)async{
    Directory directoire;
    if (!Platform.isIOS) {
      directoire = await getExternalStorageDirectory()??await getApplicationDocumentsDirectory();
    } else {
      directoire = await getApplicationDocumentsDirectory();
    }
    if (await Directory("${directoire.path}/pdf/$disp").exists()){
      await Directory("${directoire.path}/pdf/$disp").delete(recursive: true);
    }
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: 7),child:const Text("Loading..." )),
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
          title: const Text('Avertissement'),
          content:const Text('Des modifications n\'ont pas été enregistrées, souhaitez vous quand même changer de page?'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(_);
                },
                child: const Text('Continuer')),
            ElevatedButton(
                onPressed: () {
                  continu = false;
                  Navigator.pop(_);
                },
                child: const Text('Annuler')),
          ],
          elevation: 24,
        ),
        barrierDismissible: false);
    return continu;
  }
}