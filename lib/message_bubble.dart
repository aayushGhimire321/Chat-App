import 'package:flutter/material.dart';
import 'package:nepali_chat/screen/constraints.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String sender;
  final bool isMe;
  const MessageBubble(
      {super.key,
        required this.message,
        required this.sender,
        required this.isMe});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment:
      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        isMe
            ? Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: Text(sender,
              style: TextStyle(color: Colors.white, fontSize: 12)),
        )
            : Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(sender,
              style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
        Padding(
          padding:
          EdgeInsets.only(bottom: 15.0, top: 3.0, left: 10.0, right: 10.0),
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isMe ? Colors.teal[200] : Colors.grey[200],
              borderRadius:
              isMe ? kSenderMessageBubble : kReceiverMessageBubble,
            ),
            child: Text(message,
                style: TextStyle(color: Colors.black, fontSize: 15)),
          ),
        ),
      ],
    );
  }
}
