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
    apiKey: 'AIzaSyDdPKTTa2L-h_Bj9AiZZXJbQ9DpaTPo8OA',
    appId: '1:632881112049:web:7fc01a3e4896f4c3991a50',
    messagingSenderId: '632881112049',
    projectId: 'login-flutter-384d1',
    authDomain: 'login-flutter-384d1.firebaseapp.com',
    storageBucket: 'login-flutter-384d1.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDAR71q2Jm02RogIeJSjiwBeZJkfCqtwwI',
    appId: '1:632881112049:android:d86b641204393e77991a50',
    messagingSenderId: '632881112049',
    projectId: 'login-flutter-384d1',
    storageBucket: 'login-flutter-384d1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnGvZW62rLQISwnyoJ1FuVRQmN2d6jXLo',
    appId: '1:632881112049:ios:4020193d50e0b6c0991a50',
    messagingSenderId: '632881112049',
    projectId: 'login-flutter-384d1',
    storageBucket: 'login-flutter-384d1.firebasestorage.app',
    iosClientId: '632881112049-9mbckq57s32ch4so21fajp6fjjkie5vt.apps.googleusercontent.com',
    iosBundleId: 'com.example.login',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCnGvZW62rLQISwnyoJ1FuVRQmN2d6jXLo',
    appId: '1:632881112049:ios:4020193d50e0b6c0991a50',
    messagingSenderId: '632881112049',
    projectId: 'login-flutter-384d1',
    storageBucket: 'login-flutter-384d1.firebasestorage.app',
    iosClientId: '632881112049-9mbckq57s32ch4so21fajp6fjjkie5vt.apps.googleusercontent.com',
    iosBundleId: 'com.example.login',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDdPKTTa2L-h_Bj9AiZZXJbQ9DpaTPo8OA',
    appId: '1:632881112049:web:ffddd7e50aaca5bb991a50',
    messagingSenderId: '632881112049',
    projectId: 'login-flutter-384d1',
    authDomain: 'login-flutter-384d1.firebaseapp.com',
    storageBucket: 'login-flutter-384d1.firebasestorage.app',
  );
}
