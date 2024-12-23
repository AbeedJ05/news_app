// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyCSWljDqHuJqf8TJWhfrJpQBfxv8DNel40',
    appId: '1:230204649164:web:77f74104263e80c8ab5c69',
    messagingSenderId: '230204649164',
    projectId: 'hotel-flutter-175ab',
    authDomain: 'hotel-flutter-175ab.firebaseapp.com',
    storageBucket: 'hotel-flutter-175ab.firebasestorage.app',
    measurementId: 'G-MFH9CXD5TR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA8tN7c9sX1rpF98jWaAMWIi1_CNQySEFk',
    appId: '1:230204649164:android:9a854a04cac4b53bab5c69',
    messagingSenderId: '230204649164',
    projectId: 'hotel-flutter-175ab',
    storageBucket: 'hotel-flutter-175ab.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAr-HKXe3jBlnQo5ei5uEbKNELI5j0eZKE',
    appId: '1:230204649164:ios:017c6763b399181bab5c69',
    messagingSenderId: '230204649164',
    projectId: 'hotel-flutter-175ab',
    storageBucket: 'hotel-flutter-175ab.firebasestorage.app',
    androidClientId: '230204649164-rrl0gi1jcj7dbcsuf7gov6k6rars5ekv.apps.googleusercontent.com',
    iosClientId: '230204649164-4bq2r240qbnplsp6tgpjnoebq7pjbd5h.apps.googleusercontent.com',
    iosBundleId: 'com.example.hotelApp',
  );

}