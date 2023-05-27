package com.ipiccie.app_secours;

import static android.Manifest.permission.READ_EXTERNAL_STORAGE;
import static android.Manifest.permission.WRITE_EXTERNAL_STORAGE;
import static android.content.ContentValues.TAG;
import static android.os.Build.VERSION.SDK_INT;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.provider.Settings;
import android.util.Log;
import android.widget.Toast;

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

    private boolean checkPermission() {
        if (SDK_INT >= Build.VERSION_CODES.R) {
            return Environment.isExternalStorageManager();
        } else {
            int result = ContextCompat.checkSelfPermission(this, READ_EXTERNAL_STORAGE);
            int result1 = ContextCompat.checkSelfPermission(this, WRITE_EXTERNAL_STORAGE);
            return result == PackageManager.PERMISSION_GRANTED && result1 == PackageManager.PERMISSION_GRANTED;
        }
    }


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
        if(checkPermission()){
            litPDF();
        }else{
            Toast.makeText(this, "Permissions insuffisantes", Toast.LENGTH_SHORT).show();
        }
        com.google.android.material.floatingactionbutton.FloatingActionButton versDispositif = findViewById(R.id.vers_dispositif);
        versDispositif.setOnClickListener(v ->{
            Intent intention = new Intent(this, MainActivity.class);
            intention.putExtra("dispositif","-1");
            startActivity(intention);
        });
    }

    public String[] chemins(){
        File directory = new File(Environment.getExternalStorageDirectory() + "/Documents/App_secours/");
        if (!directory.exists() && !directory.isDirectory()){
            if (directory.mkdir()){
                Log.d(TAG, "nouveau dossier");
            }else{
                Toast.makeText(this, "Impossible de créer un dossier, permissions insuffisantes", Toast.LENGTH_SHORT).show();
            }
        }
        File[] files = directory.listFiles();
        if (files!= null && Objects.requireNonNull(files).length>0){
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

    private void requestPermission() {
        if (SDK_INT >= Build.VERSION_CODES.R) {
            try {
                Intent intent = new Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION);
                intent.addCategory("android.intent.category.DEFAULT");
                intent.setData(Uri.parse(String.format("package:%s",getApplicationContext().getPackageName())));
                startActivityForResult(intent, 2296);
            } catch (Exception e) {
                Intent intent = new Intent();
                intent.setAction(Settings.ACTION_MANAGE_ALL_FILES_ACCESS_PERMISSION);
                startActivityForResult(intent, 2296);
            }
        } else {
            //below android 11
            ActivityCompat.requestPermissions(this, new String[]{WRITE_EXTERNAL_STORAGE}, 0);
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 2296 &&SDK_INT >= Build.VERSION_CODES.R) {
            if (Environment.isExternalStorageManager()) {
                checkPermission();
            } else {
                Toast.makeText(this, "Cette permission est nécessaire au bon fonctionnement de l'application!", Toast.LENGTH_SHORT).show();
            }
        }
    }
}