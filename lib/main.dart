import 'package:aplicacionfinal/Controller/AccTestProvider.dart';
import 'package:aplicacionfinal/Controller/AuthProvider.dart';
import 'package:aplicacionfinal/Controller/DirectTestProvider.dart';
import 'package:aplicacionfinal/Controller/IndrectTestProvider.dart';
import 'package:aplicacionfinal/View/DirectTest.dart';
import 'package:aplicacionfinal/View/HistoryPage.dart';
import 'package:aplicacionfinal/View/HomePage.dart';
import 'package:aplicacionfinal/View/IndirectTest.dart';
import 'package:aplicacionfinal/View/LoginPage.dart';
import 'package:aplicacionfinal/View/RegisterPage.dart';
import 'package:aplicacionfinal/View/TestDeAcummulacion.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> AuthProvider()),
        ChangeNotifierProvider(create: (context)=> DirectTestProvider()),
        ChangeNotifierProvider(create: (context)=> IndirectTestProvider()),
        ChangeNotifierProvider(create: (context)=> AccTestProvider())
      ],
    child: MaterialApp(
      routes: {
        "/register": (context) => RegisterPage(),
        "/": (context) => LoginPage(),
        "/home": (context)=> HomePage(),
        "/directtest": (context)=> DirectTest(),
        "/indirecttest": (context)=> IndirectTest(),
        "/testacumulador": (context)=> TestAcumulador(),
        "/history": (context)=> HistoryPage()

      }
    ),
    );
  }
}
