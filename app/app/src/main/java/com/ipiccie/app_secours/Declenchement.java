package com.ipiccie.app_secours;

import android.app.DatePickerDialog;
import android.app.TimePickerDialog;
import android.content.res.AssetManager;
import android.net.Uri;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.TimePicker;

import com.itextpdf.text.pdf.PdfDocument;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfWriter;


import java.io.IOException;
import java.io.InputStream;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;
import java.util.Objects;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link Declenchement#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Declenchement extends Fragment {

    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;
    final Calendar myCalendar= Calendar.getInstance();
    EditText date;
    EditText heure;
    EditText heure_depart;
    EditText heure_arrive;

    public Declenchement() {
        // Required empty public constructor
    }

    public static Declenchement newInstance(String param1, String param2) {
        Declenchement fragment = new Declenchement();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment

        return inflater.inflate(R.layout.fragment_declenchement, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        String chemin = this.requireActivity().getIntent().getStringExtra("dispositif");
        PdfDocument pdf;
        /*if (chemin.equals("-1")){
            InputStream src = getResources().openRawResource(R.raw.cerfa);
            try {
                pdf = new PdfDocument(new PdfReader(src), new PdfWriter(chemin));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }else{
            try {
                pdf = new PdfDocument(new PdfReader(chemin), new PdfWriter(chemin));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }*/
        
        date = (EditText) view.findViewById(R.id.date);
        heure = (EditText) view.findViewById(R.id.heure);
        heure_depart = (EditText) view.findViewById(R.id.heure_depart);
        heure_arrive = (EditText) view.findViewById(R.id.heure_arrive);
        DatePickerDialog.OnDateSetListener dateC = (view1, year, month, day) -> {
            myCalendar.set(Calendar.YEAR, year);
            myCalendar.set(Calendar.MONTH,month);
            myCalendar.set(Calendar.DAY_OF_MONTH,day);
            updateLabel();
        };
        TimePickerDialog.OnTimeSetListener monPreneurDheure = (timePicker, i, i1) -> heure.setText(String.format("%s:%s",i,i1));
        TimePickerDialog.OnTimeSetListener monPreneurDheure2 = (timePicker, i, i1) -> heure_depart.setText(String.format("%s:%s",i,i1));
        TimePickerDialog.OnTimeSetListener monPreneurDheure3 = (timePicker, i, i1) -> heure_arrive.setText(String.format("%s:%s",i,i1));
        date.setOnClickListener(view12 -> new DatePickerDialog(this.requireContext(),dateC,myCalendar.get(Calendar.YEAR),myCalendar.get(Calendar.MONTH),myCalendar.get(Calendar.DAY_OF_MONTH)).show());
        heure.setOnClickListener(v-> new TimePickerDialog(this.requireContext(),monPreneurDheure,myCalendar.get(Calendar.HOUR_OF_DAY),myCalendar.get(Calendar.MINUTE),true).show());
        heure_depart.setOnClickListener(v2->new TimePickerDialog(this.requireContext(),monPreneurDheure2,myCalendar.get(Calendar.HOUR_OF_DAY),myCalendar.get(Calendar.MINUTE),true).show());
        heure_arrive.setOnClickListener(v3->new TimePickerDialog(this.requireContext(),monPreneurDheure3,myCalendar.get(Calendar.HOUR_OF_DAY),myCalendar.get(Calendar.MINUTE),true).show());
    }

    private void retrouvePdf(String chemin, View view) {
    }

    private void updateLabel(){
        String myFormat="MM/dd/yy";
        SimpleDateFormat dateFormat=new SimpleDateFormat(myFormat, Locale.FRANCE);
        date.setText(dateFormat.format(myCalendar.getTime()));
    }
}