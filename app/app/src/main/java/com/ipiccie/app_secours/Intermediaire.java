package com.ipiccie.app_secours;

import androidx.appcompat.app.AppCompatActivity;

import android.net.Uri;
import android.os.Bundle;

public class Intermediaire extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        final Uri uri = Uri.parse("file:///android_asset/cerfa_13971-03.pdf");
        /*final PdfConfiguration configuration = new PdfConfiguration.Builder()
                .scrollDirection(PageScrollDirection.HORIZONTAL)
                .build();
        PdfFragment fragment = (PdfFragment) getSupportFragmentManager()
                .findFragmentById(R.id.contient_declenchement);

        // If no fragment exists, create a new one.
        if (fragment == null) {
            fragment = PdfFragment.newInstance(uri, configuration);
            getSupportFragmentManager()
                    .beginTransaction()
                    .replace(R.id.contient_declenchement, fragment)
                    .commit();
        }*/
        setContentView(R.layout.activity_intermediaire);
    }
}