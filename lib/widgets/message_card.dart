import 'package:flutter/material.dart';

import '../api/api.dart';
import '../main.dart';
import '../models/message.dart';

// for showing single message details
class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});

  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.message.fromId
        ? _greenMessage()
        : _blueMessage();
  }

  // sender or another user message
  Widget _blueMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //msg content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(mq.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .04, vertical: mq.height * .01),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 245, 255),
                border: Border.all(color: Color.fromARGB(255, 221, 245, 255)),
                //making borders curved
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            //show text
            child: Text(
              widget.message.msg,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ),
        //
        Padding(
          padding: EdgeInsets.only(right: mq.width * .04),
          child: Text(widget.message.sent,
              style: const TextStyle(fontSize: 13, color: Colors.black54)),
        ),
      ],
    );
  }

  // our or user message
  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       
        //time
        Row(
          children: [
             //for adding some space
            SizedBox(width: mq.width * .04),

            //double tick blue icon for message read
              const Icon(Icons.done_all_rounded, color: Colors.blue, size: 20),

            //for adding some space
            const SizedBox(width: 2),
            //read time
            Text(
                '${widget.message.read}12:00',
                style: const TextStyle(fontSize: 13, color: Colors.black54)),
          ],
        ),

         //msg content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(mq.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .04, vertical: mq.height * .01),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 222, 255, 214),
                border: Border.all(color: Color.fromARGB(255, 222, 255, 214)),
                //making borders curved
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            //show text
            child: Text(
              widget.message.msg,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }
}
