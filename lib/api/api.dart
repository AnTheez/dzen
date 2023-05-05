import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/chat_user.dart';


class APIs {

  //для авторизації
  static FirebaseAuth auth = FirebaseAuth.instance;

  //для клауда firestore

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

//повернення корект юзера

  static User get user => auth.currentUser!;

  //перевірка чи нема ще юзера

  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }
  //для створення новго юзера

    static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUser(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: "Hey, I'm using We Chat!",
        image: user.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');

    return await firestore.collection('users').doc(user.uid).set(chatUser.toJson());  
  }
}