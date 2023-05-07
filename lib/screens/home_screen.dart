import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api/api.dart';
import '../main.dart';
import '../models/chat_user.dart';
import '../widgets/chat_user_card.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

 List<ChatUser> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     //аппбар-головна
      appBar: AppBar(
       leading: const Icon(CupertinoIcons.home),
       title: const Text('Dzen') ,
       actions: [
        //пошук
        IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
        //параметри профілю
        IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(user: list[0],)));
        }, icon: const Icon(Icons.more_vert))
       ],


      ),
      //флоатін кнопка на головній для додавання юзерів
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () async {

            await APIs.auth.signOut();
            await GoogleSignIn().signOut();
            
        }, child: const Icon(Icons.add_comment_rounded)),
      ),
    
    
    body: StreamBuilder(
      stream: APIs.firestore.collection('users').snapshots(),
      builder: (context, snapshot) {

        switch (snapshot.connectionState) {
          // якшо данні завантажило
          case ConnectionState.waiting:
          case ConnectionState.none:
            return const Center(child: CircularProgressIndicator());

            //якшо завантажоло шось - показати це
            case ConnectionState.active:
            case ConnectionState.done:
        
           

        
          final data = snapshot.data?.docs;
          list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
        
        if(list.isNotEmpty){
          return ListView.builder(
         itemCount: list.length,
         padding: EdgeInsets.only(top: mq.height * .01),
         physics: const BouncingScrollPhysics(),
         itemBuilder: (context, index) {
          return ChatUserCard(user: list[index]);
          // return Text('Name: ${list[index]}');
        });
        } else {
          return const Center(
            child: Text('Нема з\'єднання',
                style: TextStyle(fontSize: 20)),
          );
        }

        }

      
       },
      ),
    );
  }
}