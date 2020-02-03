package com.tau.velocitydemo;

import android.app.Activity;
import android.app.Notification;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.NotificationCompat;
import android.support.v4.app.NotificationManagerCompat;
import android.view.Menu;
import android.view.MenuItem;

import com.rhomobile.rhodes.RhoMain;
import com.rhomobile.rhodes.RhodesService;
import com.rhomobile.rhodes.RhoRubySingleton;
import com.rhomobile.rhodes.osfunctionality.*;
import android.app.Notification.Builder;



class DefaultMain extends RhoMain// implements com.rhomobile.rhodes.RhodesService.Listener
{
    public static String CHANEL_ID = "VELOCITY_CHANEL";

    @Override
    public void onAppStart()
    {
        super.onAppStart();

        Builder builder = AndroidFunctionalityManager.getAndroidFunctionality().getNotificationBuilder(MainActivity.instance(), CHANEL_ID, MainActivity.instance().getString(R.string.name_chanel))
                .setSmallIcon(R.mipmap.icon)
                .setContentTitle("Velocitydemo")
                .setContentText("Server started on: " + RhoRubySingleton.instance().getRubyServerURL())
                .setPriority(Notification.PRIORITY_HIGH)
                .setOngoing(true);

        builder.setVibrate(new long[]{100, 200, 300, 400, 500, 400, 300, 200, 400});

        //NotificationManagerCompat notificationManager = NotificationManagerCompat.from(MainActivity.instance());
        //notificationManager.notify(1, builder.build());

        RhodesService.getInstance().startServiceForeground(1, builder.build());
        MainActivity.instance().finish();
        //RhodesService.getInstance().setListener(this);
    }
/*
    @Override
    public void serviceStarted(RhodesService rhodesService) {

        Builder builder = AndroidFunctionalityManager.getAndroidFunctionality().getNotificationBuilder(MainActivity.instance(), CHANEL_ID, MainActivity.instance().getString(R.string.name_chanel))
                .setSmallIcon(R.mipmap.icon)
                .setContentTitle("Velocitydemo")
                .setContentText("Server started on: " + RhoRubySingleton.instance().getRubyServerURL())
                .setPriority(Notification.PRIORITY_HIGH)
                .setOngoing(true);

        builder.setVibrate(new long[]{100, 200, 300, 400, 500, 400, 300, 200, 400});

        rhodesService.startServiceForeground(0, builder.build());
    }
*/
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

        //startService(new Intent(this, com.rhomobile.rhodes.RhodesService.class));
        startForegroundService(new Intent(this, com.rhomobile.rhodes.RhodesService.class));
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

