package com.ipiccie.app_secours;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;

public class LeRecyclageCestBien extends RecyclerView.Adapter<AdaptateurAdapte> {

    String[] listeDispositifs;
    String[] listeDates;

    String[] listeChemins;
    Context context;

    public LeRecyclageCestBien (Context context, String[] listeDispositifs, String[] listeDates, String[] listeChemins){
        this.context = context;
        this.listeDispositifs = listeDispositifs;
        this.listeDates = listeDates;
        this.listeChemins = listeChemins;
    }

    @NonNull
    @Override
    public AdaptateurAdapte onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        Context contexte = parent.getContext();
        LayoutInflater inflater = LayoutInflater.from(contexte);
        View view = inflater.inflate(R.layout.profil_dispositif, parent, false);

        return new AdaptateurAdapte(view);
    }

    @Override
    public void onBindViewHolder(@NonNull AdaptateurAdapte holder, int position) {
        holder.dateDispositif.setText(listeDispositifs[position]);
        holder.nomDispositif.setText(listeDates[position]);
        holder.view.setOnClickListener(v->{
            Intent intention = new Intent(context,MainActivity.class);
            intention.putExtra("dispositif", listeChemins[position]);
            context.startActivity(intention);
        });
    }

    @Override
    public int getItemCount() {
        return listeDispositifs.length;
    }

    @Override
    public void onAttachedToRecyclerView(RecyclerView recyclerView) {
        super.onAttachedToRecyclerView(recyclerView);
    }

}
