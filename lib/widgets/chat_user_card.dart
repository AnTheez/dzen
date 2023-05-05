import 'package:dzen_chat/main.dart';
import 'package:dzen_chat/models/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 6),
      // color: Colors.blue.shade100,
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {},
        child: ListTile(

          //юзер профіль зображення
          leading: const CircleAvatar(child: Icon(CupertinoIcons.person)),

          //ім'я
          title: Text(widget.user.name),

          //останнє повідомлення
          subtitle: Text(widget.user.about, maxLines: 1),

          //час останнього повідомлення
          trailing: const Text(
            '12:00 PM',
            style: TextStyle(color: Colors.black54),
          ), 
        ),
      ),
    );
  }
}