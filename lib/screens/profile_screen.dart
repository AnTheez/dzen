import 'package:cached_network_image/cached_network_image.dart';
import 'package:dzen_chat/screens/auth/login_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api/api.dart';
import '../main.dart';
import '../models/chat_user.dart';
import '../helper/dialogs.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //аппбар-головна
        appBar: AppBar(
          title: const Text('Профайл'),
        ),
        //флоатін кнопка на головній для додавання юзерів
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            onPressed: () async {
              // progress dialog
              Dialogs.showProgressBar(context);

              // sing out from app
              await APIs.auth.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value) {

                  // hidden progress dialog
                  Navigator.pop(context);
                  // for moving to home screen
                  Navigator.pop(context);
                  // replacing home screen with login screen
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()));

                });
              });
            },
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Вийти'),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
          child: Column(
            children: [
              SizedBox(
                //трохи місця додали
                width: mq.width,
                height: mq.height * .03,
              ),
              //юзер профіль зображення
              Stack(
                children: [
                  // profile picture
                  ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .1),
                    child: CachedNetworkImage(
                      width: mq.height * .2,
                      height: mq.height * .2,
                      fit: BoxFit.fill,
                      imageUrl: widget.user.image,
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person)),
                    ),
                  ),

                  // edit img btn
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: MaterialButton(
                      elevation: 1,
                      onPressed: () {},
                      shape: const CircleBorder(),
                      color: Colors.white,
                      child: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),

              //трохи місця додали
              SizedBox(
                height: mq.height * .03,
              ),

              Text(widget.user.email,
                  style: const TextStyle(color: Colors.black54, fontSize: 16)),

              //трохи місця додали
              SizedBox(
                height: mq.height * .05,
              ),

              TextFormField(
                initialValue: widget.user.name,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person, color: Colors.blue),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'твій нинішній Нейм',
                    label: const Text('ЮзерНейм')),
              ),

              //трохи місця додали
              SizedBox(
                height: mq.height * .02,
              ),

              TextFormField(
                initialValue: widget.user.about,
                decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.info_outline, color: Colors.blue),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'Шось про себе',
                    label: const Text('Статус')),
              ),

              //трохи місця додали
              SizedBox(
                height: mq.height * .05,
              ),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: Size(mq.width * .5, mq.height * .06)),
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  size: 28,
                ),
                label: const Text(
                  'ОНОВИТИ',
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ));
  }
}
