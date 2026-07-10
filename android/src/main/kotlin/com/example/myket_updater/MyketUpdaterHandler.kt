package com.example.myket_updater

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Handler
import android.os.Looper
import androidx.core.content.pm.PackageInfoCompat
import io.flutter.plugin.common.MethodChannel
import ir.myket.developerapi.util.MyketSupportHelper

class MyketUpdaterHandler(private val context: Context) {

    companion object {
        private const val MYKET_PACKAGE_NAME = "ir.mservices.market"
    }

    private var myketHelper: MyketSupportHelper? = null

    fun checkForUpdate(result: MethodChannel.Result) {
        val handler = Handler(Looper.getMainLooper())
        val packageInfo = try {
            context.packageManager.getPackageInfo(context.packageName, 0)
        } catch (e: Exception) {
            null
        }

        val currentVersionCode = if (packageInfo != null) {
            PackageInfoCompat.getLongVersionCode(packageInfo)
        } else {
            -1L
        }
        val currentVersionName = packageInfo?.versionName ?: "unknown"

        val isMyketInstalled = try {
            context.packageManager.getPackageInfo(MYKET_PACKAGE_NAME, 0)
            true
        } catch (e: Exception) {
            false
        }

        if (!isMyketInstalled) {
            val map = HashMap<String, Any>()
            map["isUpdateAvailable"] = false
            map["error"] = false
            map["myketNotInstalled"] = true
            map["currentVersionCode"] = currentVersionCode
            map["currentVersionName"] = currentVersionName
            result.success(map)
            return
        }

        myketHelper = MyketSupportHelper(context)
        myketHelper?.startSetup { setupResult ->
            handler.post {
                if (!setupResult.isSuccess()) {
                    val map = HashMap<String, Any>()
                    map["isUpdateAvailable"] = false
                    map["error"] = true
                    map["errorMessage"] = setupResult.message ?: "Setup failed"
                    map["currentVersionCode"] = currentVersionCode
                    map["currentVersionName"] = currentVersionName
                    result.success(map)
                    return@post
                }

                myketHelper?.getAppUpdateStateAsync { updateResult, update ->
                    handler.post {
                        val map = HashMap<String, Any>()
                        if (!updateResult.isSuccess()) {
                            map["isUpdateAvailable"] = false
                            map["error"] = true
                            map["errorMessage"] = updateResult.message ?: "Update check failed"
                            map["currentVersionCode"] = currentVersionCode
                            map["currentVersionName"] = currentVersionName
                        } else {
                            map["isUpdateAvailable"] = update.isUpdateAvailable
                            map["description"] = update.description ?: ""
                            map["versionCode"] = update.versionCode
                            map["currentVersionCode"] = currentVersionCode
                            map["currentVersionName"] = currentVersionName
                            map["error"] = false
                        }
                        result.success(map)
                    }
                }
            }
        }
    }

    fun openMyketPage(result: MethodChannel.Result) {
        try {
            val intent = Intent(Intent.ACTION_VIEW).apply {
                data = Uri.parse("myket://details?id=${context.packageName}")
                setPackage(MYKET_PACKAGE_NAME)
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            }
            context.startActivity(intent)
            result.success(true)
        } catch (e: Exception) {
            try {
                val intent = Intent(Intent.ACTION_VIEW).apply {
                    data = Uri.parse("https://myket.ir/app/${context.packageName}")
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                }
                context.startActivity(intent)
                result.success(true)
            } catch (e2: Exception) {
                result.success(false)
            }
        }
    }

    fun dispose() {
        myketHelper?.dispose()
        myketHelper = null
    }
}
