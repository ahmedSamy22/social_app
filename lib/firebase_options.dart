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
    apiKey: 'AIzaSyDT6YF7VQGsrMGt-R4dE0YDPXgdUrDqHOk',
    appId: '1:1053699764854:web:0c76a4eae390f0d4846557',
    messagingSenderId: '1053699764854',
    projectId: 'social-app-d2734',
    authDomain: 'social-app-d2734.firebaseapp.com',
    storageBucket: 'social-app-d2734.appspot.com',
    measurementId: 'G-JMDW4GT2MY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCaGBIbLG7RErM3ARwIK8TO7OjGx1rS_ak',
    appId: '1:1053699764854:android:5ca0dbb2763e96ac846557',
    messagingSenderId: '1053699764854',
    projectId: 'social-app-d2734',
    storageBucket: 'social-app-d2734.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNkv4eZD9ohjZpIQ1eejB3CzSfIhkfm5g',
    appId: '1:1053699764854:ios:864c83191441d422846557',
    messagingSenderId: '1053699764854',
    projectId: 'social-app-d2734',
    storageBucket: 'social-app-d2734.appspot.com',
    iosClientId: '1053699764854-sdstji1j23f2gn00qrab4b8q7ou2uqn4.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDNkv4eZD9ohjZpIQ1eejB3CzSfIhkfm5g',
    appId: '1:1053699764854:ios:864c83191441d422846557',
    messagingSenderId: '1053699764854',
    projectId: 'social-app-d2734',
    storageBucket: 'social-app-d2734.appspot.com',
    iosClientId: '1053699764854-sdstji1j23f2gn00qrab4b8q7ou2uqn4.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialApp',
  );
}