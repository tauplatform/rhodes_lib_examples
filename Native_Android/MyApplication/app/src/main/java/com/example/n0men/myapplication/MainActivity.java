package com.example.n0men.myapplication;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Button;

import com.rhomobile.rhodes.RhodesActivity;
import com.rhomobile.rhodes.RhoMain;
import com.rhomobile.rhodes.RhodesService;
import com.rhomobile.rhodes.util.JSONGenerator;

import org.json.JSONStringer;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collection;


class DefaultMain extends RhoMain
{
    @Override
    public void onAppStart()
    {
        super.onAppStart();

        Button binit = (Button) MainActivity.instance().findViewById(R.id.test1);
        binit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                com.rhomobile.rhodes.RhoRubySingleton.instance().executeRubyMethodWithJSON("Model1", "fillModelByPredefinedSet", null);
            }
        });

        Button btest2 = (Button) MainActivity.instance().findViewById(R.id.test2);
        btest2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                new Thread(new Runnable() {
                    public void run() {
                        String serverUrl = com.rhomobile.rhodes.RhoRubySingleton.instance().getRubyServerURL() + "/app/Model1/get_first_item_field_by_name?fieldName=attr1";
                        String request = serverUrl;

                        try
                        {
                            URL url = new URL(request);
                            HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
                            urlConnection.setReadTimeout(200);
                            urlConnection.setConnectTimeout(200);
                            urlConnection.setRequestMethod("GET");
                            InputStream in = urlConnection.getInputStream();
                            InputStreamReader inputStreamReader = new InputStreamReader(in);
                            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
                            String response = null, out = "";

                            while((response = bufferedReader.readLine()) != null) {
                                out += response;
                            }

                            Log.d("TestAPP", out);

                            bufferedReader.close();
                            inputStreamReader.close();
                            in.close();
                            urlConnection.disconnect();
                        }

                        catch (java.io.IOException e)
                        {
                        }
                    }
                }).start();

            }
        });

        Button btest3 = (Button) MainActivity.instance().findViewById(R.id.test3);
        btest3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String str = com.rhomobile.rhodes.RhoRubySingleton.instance().executeRubyMethodWithJSON("Model1", "getAllItemsAsHashes", null);
                String str2 = com.rhomobile.rhodes.RhoRubySingleton.instance().executeRubyMethodWithJSON("Model1", "receiveAllItemAsArrayOfHashesWithParams",
                        "[{\"key1_array\":[\"param_array1_item1_string_value\",\"param_array1_item2_string_value\"],\"key2_integer\":1234567,\"key3_bool\":true},0.123450]");
            }
        });

    }
}

public class MainActivity extends RhodesActivity {

    static MainActivity instance = null;

    static public MainActivity instance()
    {
        return instance;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        instance = this;

        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);

        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                        .setAction("Action", null).show();
            }
        });

        startService(new Intent(this, com.rhomobile.rhodes.RhodesService.class));
        RhodesService.setRhoMain(new DefaultMain());
    }

    @Override
    public void onStart()
    {
        super.onStart();
    }

    @Override
    public void onResume()
    {
        super.onResume();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}

