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
        return macos;
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
    apiKey: 'AIzaSyDhRNSUpt7fP4k-ODJDjSANSm3DDT9WWzc',
    appId: '1:717171624414:web:64021e520a579bbb5fb54f',
    messagingSenderId: '717171624414',
    projectId: 'saferoute0',
    authDomain: 'saferoute0.firebaseapp.com',
    storageBucket: 'saferoute0.appspot.com',
    measurementId: 'G-M42J7F9R1V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVBG3wtmfXEOZpGaEvX4g6X8pNE2vTWlQ',
    appId: '1:717171624414:android:558de2f90a2d18455fb54f',
    messagingSenderId: '717171624414',
    projectId: 'saferoute0',
    storageBucket: 'saferoute0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_3tE9i4V-dX8_r5NcXmii3MMvOxbtlIc',
    appId: '1:717171624414:ios:f92fa4f2667ff3e25fb54f',
    messagingSenderId: '717171624414',
    projectId: 'saferoute0',
    storageBucket: 'saferoute0.appspot.com',
    iosBundleId: 'com.example.safeRoute00',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC_3tE9i4V-dX8_r5NcXmii3MMvOxbtlIc',
    appId: '1:717171624414:ios:8af612e0df24c8bf5fb54f',
    messagingSenderId: '717171624414',
    projectId: 'saferoute0',
    storageBucket: 'saferoute0.appspot.com',
    iosBundleId: 'com.example.safeRoute00.RunnerTests',
  );
}