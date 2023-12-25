import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicales_details/Colors/colors.dart';
import 'package:vehicales_details/firebase_options.dart';
import 'package:vehicales_details/screens/Screen_one.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: appBarcolor),
        colorScheme: ColorScheme.fromSeed(seedColor: ButtonColor),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const ScreenOne(),
    );
  }
}
