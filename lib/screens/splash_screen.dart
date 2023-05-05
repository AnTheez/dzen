
import 'dart:developer';

import 'package:dzen_chat/api/api.dart';
import 'package:dzen_chat/screens/home_screen.dart';
import  'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../main.dart';
import 'auth/login_screen.dart';

//сплеш скрін

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){
        //вихід з повн скрін 
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent)
        );

        if(APIs.auth.currentUser != null) {
            log('\nUser: ${APIs.auth.currentUser}');

           //навігація на головну
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
   
        } else {
           //навігація на login
          Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
           }
      });
    }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
     //аппбар
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('ДзеньКіт ') ,
      ),
      
      body: Stack(children: [
        //привітальне зображення
        Positioned(
          top: mq.height * .15,
          right: mq.width * .25,
          width: mq.width * .5,
          child: Image.asset('images/login.png')),
          
          //низ напис
          Positioned(
          bottom: mq.height * .15,
          width: mq.width ,
          
          child: const Text('ЗРОБЛЕНО В УКРАЇНІ З ❤',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16, 
                color: Colors.black87,
                letterSpacing: .5
              ))),
            
      ]),
    );
  }
}