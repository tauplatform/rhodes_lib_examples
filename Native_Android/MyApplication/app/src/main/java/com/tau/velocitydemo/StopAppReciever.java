package com.tau.velocitydemo;

import android.app.NotificationManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

public class StopAppReciever extends BroadcastReceiver {
    private static MainActivity instance = null;
    private static final String TAG = "StopAppReciever";
    @Override
    public void onReceive(Context context, Intent intent) {
        Log.d(TAG, "Call StopAppReciever");
        instance.killApp();
    }

    public static void SetMainActivity(MainActivity ac)
    {
        instance = ac;
    }
}
