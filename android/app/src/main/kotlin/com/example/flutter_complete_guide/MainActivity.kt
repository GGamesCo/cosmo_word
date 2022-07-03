package com.ggame.cosmo_word

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
//import com.google.firebase.analytics.FirebaseAnalytics

class MainActivity: FlutterActivity() {
//    private lateinit var firebaseAnalytics: FirebaseAnalytics
//
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        AudienceNetworkInitializeHelper.initialize(this);
    }
}
