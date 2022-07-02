// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAK95SNgpFzlKjsEzaaRCVykpBPptpMWX8',
    appId: '1:255893037221:web:2b194f656ea098aea5ad4c',
    messagingSenderId: '255893037221',
    projectId: 'ggames-cosmo-word',
    authDomain: 'ggames-cosmo-word.firebaseapp.com',
    storageBucket: 'ggames-cosmo-word.appspot.com',
    measurementId: 'G-1D6R4YZ37Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCHnyOS9734j8eg91bCokLJ5rB-NVU8r3s',
    appId: '1:255893037221:android:e18b44324c983672a5ad4c',
    messagingSenderId: '255893037221',
    projectId: 'ggames-cosmo-word',
    storageBucket: 'ggames-cosmo-word.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAeeuCOVHtVVg4xCbbLCo82XH8QhRqXId0',
    appId: '1:255893037221:ios:e5ee0b0bc1808495a5ad4c',
    messagingSenderId: '255893037221',
    projectId: 'ggames-cosmo-word',
    storageBucket: 'ggames-cosmo-word.appspot.com',
    androidClientId: '255893037221-u8f4et940g12sm386dih3jihp109drub.apps.googleusercontent.com',
    iosClientId: '255893037221-0oln20pfdi17j68063ap9gc771p85939.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterCompleteGuide',
  );
}
