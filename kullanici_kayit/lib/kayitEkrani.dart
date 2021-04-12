import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kullanici_kayit/home_page.dart';

import 'giris_ekrani.dart';

class KayitEkrani extends StatefulWidget {
  @override
  _KayitEkraniState createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
//-------------------Kayıt parametleri tutucuları-----------

  String email, sifre;

//-------------------
  var _formAnahtari = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Kayıt"),
        centerTitle: true,
      ),
      body: Form(
        key: _formAnahtari,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (alinanMail) {
                  email = alinanMail;
                },
                validator: (alinanMail) {
                  return alinanMail.contains("@") ? null : "Mail Geçersiz";
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Email adresinizi buraya giriniz.",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                onChanged: (alinanSifre) {
                  sifre = alinanSifre;
                },
                validator: (alinanSifre) {
                  return alinanSifre.length >= 6
                      ? null
                      : "En az 6 Karakter girin";
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Şifre",
                  hintText: "Şifrenizi buraya giriniz..",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    kayitOl();
                  },
                  child: Text("Kaydol"),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => GirisEkrani()));
                  },
                  child: Text("Zaten Hesabım Var."),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Email ve şifreye göre firebaseye kullanıcı ekler
  void kayitOl() {
    if (_formAnahtari.currentState.validate()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: sifre)
          .then((user) {
        //----Başarılı ise anasayfaya git
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => Anasayfa()),
          (Route<dynamic> route) =>false);
      }).catchError((hata) {
        //---------Başarısız ise hata ver
        Fluttertoast.showToast(msg: hata);
      });
    }
  }
}
