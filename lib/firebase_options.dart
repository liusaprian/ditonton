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
    apiKey: 'AIzaSyDgg8F8WooyK9q4V7SZz4injhpxKaBBVds',
    appId: '1:1082393751167:web:74484bcb3b00ab3e20594a',
    messagingSenderId: '1082393751167',
    projectId: 'ditonton-632fe',
    authDomain: 'ditonton-632fe.firebaseapp.com',
    storageBucket: 'ditonton-632fe.appspot.com',
    measurementId: 'G-YQN1217Y49',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUJD9jqiRLc1QIYlNfBONkKaOtX7v6M8U',
    appId: '1:1082393751167:android:93b7fa42b7b7445e20594a',
    messagingSenderId: '1082393751167',
    projectId: 'ditonton-632fe',
    storageBucket: 'ditonton-632fe.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3tJLjPAIORLTw8pbJIzkJBJne0zKqUSI',
    appId: '1:1082393751167:ios:770f1b05b81bc88c20594a',
    messagingSenderId: '1082393751167',
    projectId: 'ditonton-632fe',
    storageBucket: 'ditonton-632fe.appspot.com',
    iosClientId: '1082393751167-gfo6mcd4j1n27d4nbrpslfhe554k4g1h.apps.googleusercontent.com',
    iosBundleId: 'com.dicoding.ditonton',
  );
}