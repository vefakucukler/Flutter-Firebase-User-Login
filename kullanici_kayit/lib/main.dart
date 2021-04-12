import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kullanici_kayit/kayitEkrani.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserApp(),
  ));
}

class UserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KayitEkrani(
      
    );
  }
}