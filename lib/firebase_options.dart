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
        return windows;
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
    apiKey: 'AIzaSyBeemzWyZx-yQEJFkPwW0As8A4sa70pKLQ',
    appId: '1:88627130661:web:4fe053799c7b83d6e32acc',
    messagingSenderId: '88627130661',
    projectId: 'fir-123ae',
    authDomain: 'fir-123ae.firebaseapp.com',
    storageBucket: 'fir-123ae.appspot.com',
    measurementId: 'G-0G0GX72QT2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBT9oQtix8yFBqBeJCbqLFtz6FFxmkuKuo',
    appId: '1:88627130661:android:edb35a4fdd6da324e32acc',
    messagingSenderId: '88627130661',
    projectId: 'fir-123ae',
    storageBucket: 'fir-123ae.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC1IDlbIrNMy0y9EFz6yRasB18msWdCI-U',
    appId: '1:88627130661:ios:2340a89c366486dce32acc',
    messagingSenderId: '88627130661',
    projectId: 'fir-123ae',
    storageBucket: 'fir-123ae.appspot.com',
    iosBundleId: 'com.example.intercheck',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC1IDlbIrNMy0y9EFz6yRasB18msWdCI-U',
    appId: '1:88627130661:ios:2340a89c366486dce32acc',
    messagingSenderId: '88627130661',
    projectId: 'fir-123ae',
    storageBucket: 'fir-123ae.appspot.com',
    iosBundleId: 'com.example.intercheck',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBeemzWyZx-yQEJFkPwW0As8A4sa70pKLQ',
    appId: '1:88627130661:web:4acd4a3ecfac4e79e32acc',
    messagingSenderId: '88627130661',
    projectId: 'fir-123ae',
    authDomain: 'fir-123ae.firebaseapp.com',
    storageBucket: 'fir-123ae.appspot.com',
    measurementId: 'G-TEC71R0QPT',
  );

}