import 'package:ai_assistent/model/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart'; // Import markdown package

import '../Helper/global.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    const r = Radius.circular(15);
    return message.msgType == MessageType.user
        ? // User's message
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(width: 6),
        Container(
          constraints: BoxConstraints(maxWidth: mq.width * .6),
          margin: EdgeInsets.only(
              bottom: mq.height * .02, right: mq.width * .02),
          padding: EdgeInsets.symmetric(
              vertical: mq.height * .01, horizontal: mq.width * .03),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.only(
                  topLeft: r, topRight: r, bottomLeft: r)),
          child: Text(message.msg),
        ),
        CircleAvatar(
          radius: 18,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.person_2_sharp,
            size: 28,
            color: Colors.blue,
          ),
        )
      ],
    )
        : // Bot's message
    Row(
      children: [
        const SizedBox(width: 6),
        CircleAvatar(
          radius: 18,
          backgroundColor: Colors.white,
          child: Image.asset(
            'assets/images/logo.png',
            width: 24,
          ),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: mq.width * .75),
          margin: EdgeInsets.only(
              bottom: mq.height * .02, left: mq.width * .02),
          padding: EdgeInsets.symmetric(
              vertical: mq.height * .01, horizontal: mq.width * .03),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.only(
                  topLeft: r, topRight: r, bottomRight: r)),
          child: message.msg.contains(RegExp(r'\*\*.*\*\*|\_.*\_'))
              ? // Render markdown if message contains markdown syntax
          MarkdownBody(
            data: message.msg,
            selectable: true, // Allow text selection
          )
              : // Default plain text if no markdown syntax
          Text(message.msg),
        ),
      ],
    );
  }
}
