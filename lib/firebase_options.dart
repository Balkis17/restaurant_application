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
    apiKey: 'AIzaSyB3lht_KVDwXsSHUT8RiwwdoLM91LW-xtE',
    appId: '1:748498943797:web:346b4fb86cb81ca709567c',
    messagingSenderId: '748498943797',
    projectId: 'restaurant-application-41850',
    authDomain: 'restaurant-application-41850.firebaseapp.com',
    storageBucket: 'restaurant-application-41850.appspot.com',
    measurementId: 'G-0T2X0P245S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbHcb2kmWHaaEt-ZmGd4XtFBQ1YmH80QI',
    appId: '1:748498943797:android:002308fdceacab7309567c',
    messagingSenderId: '748498943797',
    projectId: 'restaurant-application-41850',
    storageBucket: 'restaurant-application-41850.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDl7raBRgkOVYxy1ANiORIEuHTy8dAxnFk',
    appId: '1:748498943797:ios:c25c583ca6d081c709567c',
    messagingSenderId: '748498943797',
    projectId: 'restaurant-application-41850',
    storageBucket: 'restaurant-application-41850.appspot.com',
    iosBundleId: 'com.example.restaurantApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDl7raBRgkOVYxy1ANiORIEuHTy8dAxnFk',
    appId: '1:748498943797:ios:a868a4156c5b1f9f09567c',
    messagingSenderId: '748498943797',
    projectId: 'restaurant-application-41850',
    storageBucket: 'restaurant-application-41850.appspot.com',
    iosBundleId: 'com.example.restaurantApplication.RunnerTests',
  );
}