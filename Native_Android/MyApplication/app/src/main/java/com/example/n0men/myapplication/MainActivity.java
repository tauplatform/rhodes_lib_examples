package com.example.n0men.myapplication;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.snackbar.Snackbar;
import androidx.appcompat.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Button;

import com.rhomobile.rhodes.RhodesActivity;
import com.rhomobile.rhodes.RhoMain;
import com.rhomobile.rhodes.RhodesService;
import com.rhomobile.rhodes.RhoRubySingleton;
import com.rhomobile.rhodes.socket.SSLImpl;

import org.json.JSONStringer;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLSession;
import javax.net.ssl.SSLSocketFactory;

import javax.net.ssl.HttpsURLConnection;


class DefaultMain extends RhoMain
{

    class RhoHostVerifier implements HostnameVerifier
    {
        @Override
        public  boolean verify(String hostname, SSLSession session)
        {
            return true;
        }
    }


    public  void rest_api_sample()
    {
        String serverUrl = RhoRubySingleton.instance().getRubyServerURL() + "/app/Model1/get_first_item_field_by_name?fieldName=attr1";
        String request = serverUrl;

        boolean is_https = RhodesService.isLocalHttpsServerEnable();

        try
        {
            URL url = new URL(request);
            HttpURLConnection urlConnection = null;

            if(is_https)
            {
                urlConnection = (HttpsURLConnection) url.openConnection();
                ((HttpsURLConnection)urlConnection).setSSLSocketFactory(SSLImpl.getSecureClientFactory());
                ((HttpsURLConnection)urlConnection).setHostnameVerifier(new RhoHostVerifier());
            }
            else
                urlConnection = (HttpURLConnection) url.openConnection();

            urlConnection.setReadTimeout(2000);
            urlConnection.setConnectTimeout(2000);
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

        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    @Override
    public void onAppStart()
    {
        super.onAppStart();

        Button binit = (Button) MainActivity.instance().findViewById(R.id.test1);
        binit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                RhoRubySingleton.instance().executeInRubyThread(new RhoRubySingleton.RhoRunnable() {
                    public void rhoRun() {
                        RhoRubySingleton.instance().executeRubyMethodWithJSON("Model1", "fillModelByPredefinedSet", null);
                    }
                });
            }
        });

        Button btest2 = (Button) MainActivity.instance().findViewById(R.id.test2);
        btest2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                new Thread(new Runnable() {
                    public void run() {
                        rest_api_sample();
                    }
                }).start();

            }
        });

        Button btest3 = (Button) MainActivity.instance().findViewById(R.id.test3);
        btest3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                RhoRubySingleton.instance().executeInRubyThread(new RhoRubySingleton.RhoRunnable() {
                    public void rhoRun() {
                        String str = RhoRubySingleton.instance().executeRubyMethodWithJSON("Model1", "getAllItemsAsHashes", null);
                        Log.d("TestAPP", "Model1.getAllItemsAsHashes() result:");
                        Log.d("TestAPP", str);

                        String str2 = RhoRubySingleton.instance().executeRubyMethodWithJSON("Model1", "receiveAllItemAsArrayOfHashesWithParams",
                                "[{\"key1_array\":[\"param_array1_item1_string_value\",\"param_array1_item2_string_value\"],\"key2_integer\":1234567,\"key3_bool\":true},0.123450]");
                        Log.d("TestAPP", "Model1.receiveAllItemAsArrayOfHashesWithParams() result:");
                        Log.d("TestAPP", str2);
                    }
                });
            }
        });

        Button btest4 = (Button) MainActivity.instance().findViewById(R.id.test4);

        RhoRubySingleton.IRubyNativeCallback nativeCallback = new RhoRubySingleton.IRubyNativeCallback() {
            @Override
            public void onRubyNative(String s) {
                Log.d("TestAPP", "RubyNativeCallback received ! with param in JSON:");
                Log.d("TestAPP", s);
            }
        };
        RhoRubySingleton.instance().addRubyNativeCallback("mySuperMegaRubyNativeCallbackID", nativeCallback);

        btest4.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                RhoRubySingleton.instance().executeInRubyThread(new RhoRubySingleton.RhoRunnable() {
                    public void rhoRun() {
                        Log.d("TestAPP", "execute Model1.callRubyNativeCallback() in ruby thread");
                        RhoRubySingleton.instance().executeRubyMethodWithJSON("Model1", "callRubyNativeCallback", null);
                    }
                });
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

