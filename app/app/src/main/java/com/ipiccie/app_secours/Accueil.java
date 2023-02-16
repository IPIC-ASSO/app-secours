package com.ipiccie.app_secours;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Environment;
import android.util.Log;

import com.itextpdf.text.pdf.AcroFields;
import com.itextpdf.text.pdf.PdfDocument;
import com.itextpdf.text.pdf.PdfReader;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class Accueil extends AppCompatActivity {

    private List<String> nomsDisp;
    private List<String> listeDates;
    private List<String> listeChemins;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_accueil);
        SharedPreferences prefs = getBaseContext().getSharedPreferences("dispositifs", Context.MODE_PRIVATE);//clé: nom dispositif; valeur: index dans DB
        SharedPreferences prefs2 = getBaseContext().getSharedPreferences("dates", Context.MODE_PRIVATE);//clé: nom dispositif; valeur: date

        String[] dispositifs = prefs.getAll().keySet().toArray(new String[0]);
        String[] dates = new String[dispositifs.length];
        for (int indice =0; indice<dispositifs.length; indice++){
            dates[indice] = prefs2.getString(dispositifs[indice],"--:--");
        }

        litPDF();
        RecyclerView usineDeRecyclage = findViewById(R.id.recycle_pas_bien);
        LeRecyclageCestBien eboueur = new LeRecyclageCestBien(this, nomsDisp.toArray(new String[0]), listeDates.toArray(new String[0]), listeChemins.toArray(new String[0]));
        usineDeRecyclage.setAdapter(eboueur);
        usineDeRecyclage.setLayoutManager(new LinearLayoutManager(this));
        com.google.android.material.floatingactionbutton.FloatingActionButton versDispositif = findViewById(R.id.vers_dispositif);
        versDispositif.setOnClickListener(v ->{
            Intent intention = new Intent(this, MainActivity.class);
            intention.putExtra("dispositif","-1");
            startActivity(intention);
        });
    }

    public String[] chemins(){
        File directory = new File(Environment.getExternalStorageDirectory() + "/Documents/App_secours/");
        File[] files = directory.listFiles();
        if (Objects.requireNonNull(files).length>0){
            String[] chemins = new String[files.length];
            for (int i = 0; i < Objects.requireNonNull(files).length; i++)
            {
                chemins[i] = (files[i].getPath());
                Log.d("Files", "FileName:" + files[i].getName());
            }
            return chemins;
        }
        else return new String[0];
    }

    public void litPDF(){
        String[] chemins = chemins();
        nomsDisp =  new ArrayList<>();
        listeDates =  new ArrayList<>();
        listeChemins = new ArrayList<>();
        for (String monPdf:Objects.requireNonNull(chemins)){
            try {
                PdfReader lecteur = new PdfReader(monPdf);
                AcroFields champs = lecteur.getAcroFields();
                nomsDisp.add(champs.getField("dispositif"));
                listeDates.add(champs.getField("Date"));
                listeChemins.add(monPdf);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
    }
}