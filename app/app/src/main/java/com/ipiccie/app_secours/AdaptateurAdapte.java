package com.ipiccie.app_secours;



import android.view.View;
import android.widget.TextView;

import androidx.recyclerview.widget.RecyclerView;

public class AdaptateurAdapte extends RecyclerView.ViewHolder {
        TextView nomDispositif;
        TextView dateDispositif;
        View view;

    AdaptateurAdapte(View itemView) {
        super(itemView);
        nomDispositif = (TextView)itemView.findViewById(R.id.text_dispositif);
        dateDispositif = (TextView)itemView.findViewById(R.id.date_dispositif);
        view  = itemView;
        }
}
