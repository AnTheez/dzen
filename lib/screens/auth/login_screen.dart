import 'dart:developer'; //dart:math
import 'dart:io';

import 'package:dzen_chat/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import  'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../api/api.dart';
import '../../helper/dialogs.dart';
import '../../main.dart';

//аутент гугл вікно

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), (){
      setState(() {
        _isAnimate = true;
      });
    });
  }

  // handles google login button click
  _handleGoogleBtnClick() {
    //for showing progress bar
    Dialogs.showProgressBar(context);

    _signInWithGoogle().then((user) async {
      //for hiding progress bar
      Navigator.pop(context);

      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

        if ((await APIs.userExists())) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        } else {
          await APIs.createUser().then((value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          });
        }
      }
    });
  }

Future<UserCredential?> _signInWithGoogle() async {
  try{
    await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await APIs.auth.signInWithCredential(credential);
  } catch (e) {
    log('\n_signInWithGoogle: $e');
    Dialogs.showSnackbar(context, 'Шось не грузить 🌝 (Перевір свій Інет ДОВБЕНь!!)');
    return null;
  }
}


  @override
  Widget build(BuildContext context) {
    // mq = MediaQuery.of(context).size;
    return Scaffold(
     //аппбар
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('ДзеньКіт ') ,
      ),
      
      body: Stack(children: [
        //привітальне зображення
        AnimatedPositioned(
          top: mq.height * .15,
          right: _isAnimate ? mq.width * .25 : -mq.width * .5,
          width: mq.width * .5,
          duration: const Duration(seconds: 1),
          child: Image.asset('images/login.png')),
          
          //гугл кнопка
          Positioned(
          bottom: mq.height * .15,
          left: mq.width * .05,
          width: mq.width * .9,
          height: mq.height * .06,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 238, 237, 248), 
              shape: const StadiumBorder(),
              elevation: 1,
            ),
            onPressed: (){
              _handleGoogleBtnClick();
            }, 
            //зображення гугл на кнопку гугла
            icon: Image.asset('images/google.png', height: mq.height * .04,), 
            
            //текст кнопки
            label: RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 18),
                children: [
                  TextSpan(text: 'Приєднатись через '),
                  TextSpan(text: 'Google',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              
      

            ]),
            ))),
      ]),
    );
  }
}