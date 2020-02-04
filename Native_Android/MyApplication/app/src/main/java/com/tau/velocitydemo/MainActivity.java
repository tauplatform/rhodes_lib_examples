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
import android.os.Build;
import android.app.PendingIntent;


class DefaultMain extends RhoMain// implements com.rhomobile.rhodes.RhodesService.Listener
{
    public static String CHANEL_ID = "VELOCITY_CHANEL";



    @Override
    public void onAppStart()
    {
        super.onAppStart();

        Intent stopIntent = new Intent(MainActivity.instance(), StopAppReciever.class);
        stopIntent.putExtra("STOP", 1);
        PendingIntent stopPendingIntent =
                PendingIntent.getBroadcast(MainActivity.instance(), 0, stopIntent, 0);

        Builder builder = AndroidFunctionalityManager.getAndroidFunctionality().getNotificationBuilder(MainActivity.instance(), CHANEL_ID, MainActivity.instance().getString(R.string.name_chanel))
                .setSmallIcon(R.mipmap.icon)
                .setContentTitle("Velocitydemo")
                .setContentText("Server started on: " + RhoRubySingleton.instance().getRubyServerURL())
                .setPriority(Notification.PRIORITY_HIGH)
                .setOngoing(false)
                .addAction(new Notification.Action.Builder(R.drawable.ic_stop, "Stop", stopPendingIntent).build());

        builder.setVibrate(new long[]{100, 200, 300, 400, 500, 400, 300, 200, 400});

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

    public void killApp()
    {
        RhodesService.getInstance().stopSelf();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        StopAppReciever.SetMainActivity(this);
        instance = this;
        if(Build.VERSION.SDK_INT >= 28)
            startForegroundService(new Intent(this, com.rhomobile.rhodes.RhodesService.class));
        else
            startService(new Intent(this, com.rhomobile.rhodes.RhodesService.class));

        RhodesService.setRhoMain(new DefaultMain());
    }

    @Override
    public void onStart()

    {
        super.onStart();
        finish();
    }

    @Override
    public void onResume()
    {
        super.onResume();
        finish();
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

