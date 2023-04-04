import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
// // import 'package:todoflutter/util/adapter.dart';
import 'package:mytask/screens/home.dart';
import 'package:mytask/util/adapter.dart';
import 'package:mytask/util/notification.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  await Hive.initFlutter();

  NotificationApi().initNotification();
  tz.initializeTimeZones();
  Hive.registerAdapter(DateTimeAdapter());

 await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );
  // open a box
  var box = await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Root widget
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Task',
      home: Home()
    );
  }
}