import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('message id ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Notification(),
      // home: BlocProvider<NetworkCubit>(
      //   create: (context) => NetworkCubit(),
      //   child: const Notification(),
      // ),
    );
  }
}

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  void initState() {
    FirebaseApi firebaseApi = FirebaseApi();
    firebaseApi.requestPermission();
    firebaseApi.getToken();
    firebaseApi.initInfo();
    Future.delayed(const Duration(seconds: 10), () {
      firebaseApi.sendPushNotification();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
    );
  }
}

class FirebaseApi {
  final _firebaseInstance = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> requestPermission() async {
    NotificationSettings settings = await _firebaseInstance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted Permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional Permission');
    } else {
      print('User denied');
    }
  }

  Future<void> getToken() async {
    await _firebaseInstance.getToken().then((token) => print('token   $token'));
  }

  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),
          htmlFormatContentTitle: true);
      AndroidNotificationDetails androidPlatformChannelSprcific =
          AndroidNotificationDetails(
        'lizi', 'lizi',
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true,
        // sound: const RawResourceAndroidNotificationSound('notification')
      );
      NotificationDetails platformChannelSpecific =
          NotificationDetails(android: androidPlatformChannelSprcific);
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, platformChannelSpecific,
          payload: message.data['title']);
    });
  }

  void sendPushNotification() async {
    try {
      FirebaseMessaging.instance.subscribeToTopic('all_users');
      await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
          headers: {
            'content-Type': 'application/json',
            'Authorization':
                'key=AAAAFKKWsSU:APA91bGxoSyhGoGVvpKwCa-vPsrZVBX4ZggRMr-66R3dphIeZK1uLTAchTOhlnKoxy4sEAu_O9BWn-SVQhlOHLY5MV2V8Up8HZ8WUH54WQ1IJm4ubEwDRRrIEKAOvtTM7Nph8rcYGaXx'
          },
          body: jsonEncode({
            'notification': {'title': 'Test Again', 'body': 'All Users Received this message'},
            'priority': 'high',
            'to': '/topics/all_users'
          }));
    } catch (e) {
      print('error $e');
    }
  }
}

// class FirstPage extends StatefulWidget {
//   const FirstPage({super.key});
//
//   @override
//   State<FirstPage> createState() => _FirstPageState();
// }
//
// class _FirstPageState extends State<FirstPage> {
//   @override
//   void initState() {
//     super.initState();
//     getCurrentLocation();
//     final networkCubit = context.read<NetworkCubit>();
//     networkCubit.checkNetwork();
//   }
//
//   final Location _locationController = Location();
//
//   LatLng? _currentLocation;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<NetworkCubit, NetworkState>(
//       listener: (context, state) {
//         if (state is NetworkDisconnected) {
//           snackBar('Network DisConnected', context);
//         }
//       },
//       child: Scaffold(
//         body: GoogleMap(
//           initialCameraPosition: CameraPosition(
//               target: _currentLocation ?? const LatLng(0, 0), zoom: 10),
//           markers: {
//             Marker(
//                 markerId: const MarkerId('_currentLocation'),
//                 icon: BitmapDescriptor.defaultMarker,
//                 position: _currentLocation ?? const LatLng(0, 0)),
//             const Marker(
//                 markerId: MarkerId('_sourceLocation'),
//                 icon: BitmapDescriptor.defaultMarker,
//                 position: LatLng(8.7019, 77.7281)),
//             const Marker(
//                 markerId: MarkerId('_destinationLocation'),
//                 icon: BitmapDescriptor.defaultMarker,
//                 position: LatLng(8.6790, 77.7268))
//           },
//         ),
//       ),
//
//       // Scaffold(
//       //   body: Center(
//       //     child: Column(
//       //       mainAxisAlignment: MainAxisAlignment.center,
//       //       children: [
//       //         GestureDetector(
//       //             onTap: () {
//       //               Navigator.push(
//       //                   context,
//       //                   MaterialPageRoute(
//       //                       builder: (context) => const SecondPage()));
//       //             },
//       //             child: const Text('SecondPage')),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//     );
//   }
//
//   void getCurrentLocation() async {
//     bool serviceEnabled;
//     PermissionStatus permissionStatus;
//     serviceEnabled = await _locationController.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await _locationController.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }
//     permissionStatus = await _locationController.hasPermission();
//     if (permissionStatus == PermissionStatus.denied) {
//       permissionStatus = await _locationController.requestPermission();
//       if (permissionStatus != PermissionStatus.granted) {
//         return;
//       }
//     }
//     _locationController.onLocationChanged
//         .listen((LocationData currentLocation) async {
//       if (currentLocation.longitude != null &&
//           currentLocation.latitude != null) {
//         try {
//           setState(() {
//             _currentLocation =
//                 LatLng(currentLocation.latitude!, currentLocation.longitude!);
//             print('_currentLocation  $_currentLocation');
//           });
//         } catch (e) {
//           print('Error getting placemarks: $e');
//         }
//       }
//     });
//   }
// }

// class SecondPage extends StatelessWidget {
//   const SecondPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text('FirstPage')),
//             const SizedBox(
//               height: 20,
//             ),
//             GestureDetector(
//                 onTap: () async {
//                   final result = await Connectivity().checkConnectivity();
//                   if (result == ConnectivityResult.none) {
//                     snackBar('Network connection failed', context);
//                     return;
//                   }
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const ThirdPage()));
//                 },
//                 child: const Text('ThirdPage')),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ThirdPage extends StatelessWidget {
//   const ThirdPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('This is final page'),
//             const SizedBox(
//               height: 20,
//             ),
//             GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text('SecondPage')),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// void snackBar(String isConnected, BuildContext context) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     content: Text(isConnected),
//     duration: const Duration(seconds: 5),
//   ));
// }
