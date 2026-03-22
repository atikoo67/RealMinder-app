package com.example.real_mind

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import io.flutter.Log
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineGroup

class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {

        if (intent.action == Intent.ACTION_BOOT_COMPLETED ||
            intent.action == Intent.ACTION_LOCKED_BOOT_COMPLETED) {

            Log.d("BootReceiver", "Device rebooted — rescheduling reminders")

            val engineGroup = FlutterEngineGroup(context)
            val engine = engineGroup.createAndRunDefaultEngine(context)
            val channel = MethodChannel(engine.dartExecutor, "schedule_rescheduler")

            channel.invokeMethod("rescheduleAfterReboot", null)
        }
    }
}
