import 'package:flutter/material.dart';
// import 'package:moneyapp/screens/home.dart';
import 'package:moneyapp_v1/screens/home.dart';
import 'package:moneyapp_v1/screens/statistics.dart';
import '../component/bottomnavigationbar.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/model/add_date.dart';
//Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AdddataAdapter());
  await Hive.openBox<Add_data>('data');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bottom(),
    );
  }
}