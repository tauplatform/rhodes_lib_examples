package com.tau.velocitydemo;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;

import com.rhomobile.rhodes.RhoMain;
import com.rhomobile.rhodes.RhodesService;


class DefaultMain extends RhoMain
{
    @Override
    public void onAppStart()
    {
        super.onAppStart();

    }
}

public class MainActivity extends Activity {

    static MainActivity instance = null;

    static public MainActivity instance()
    {
        return instance;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        instance = this;

        //setContentView(R.layout.activity_main);
        //Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);

        //FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);

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

