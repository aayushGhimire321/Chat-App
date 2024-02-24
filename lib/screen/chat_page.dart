import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../message_bubble.dart';
import 'constraints.dart';
import 'login.dart';

class ChatPage extends StatefulWidget {
  static String route = "ChatPage";
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  late User loggedInUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseDatabase = FirebaseFirestore.instance;

  getLoggedInUser() async {
    loggedInUser = _auth.currentUser!;
    print(loggedInUser.email);
  }

  @override
  void initState() {
    getLoggedInUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        automaticallyImplyLeading: false,
        title: Text(loggedInUser.email!),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pushReplacementNamed(context, LoginScreen.route);
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/background.jpg"),
                      fit: BoxFit.cover)),
              child: StreamBuilder(
                stream: _firebaseDatabase
                    .collection(MESSAGE_COLLECTION)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final messageQS = snapshot.data!.docs.reversed;
                  List<MessageBubble> messageBubbleList = <MessageBubble>[];
                  for (var singleMSGData in messageQS) {
                    final message = singleMSGData.data();
                    print("--> $message");
                    print(message["msgText"]);
                    print("Actual message --> ${message[MESSAGE_TEXT]}");
                    // MessageBubble(
                    //   message: message[MESSAGE_TEXT],
                    //   sender: loggedInUser.email!,
                    // );
                    // print(message[MESSAGE_SENDER]==loggedInUser.email!);

                    messageBubbleList.add(MessageBubble(
                      message: message[MESSAGE_TEXT],
                      sender: message[MESSAGE_SENDER],
                      isMe: message[MESSAGE_SENDER] == loggedInUser.email!,
                    ));
                  }
                  return ListView(
                    reverse: true,
                    children: messageBubbleList,
                  );
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: Colors.cyan.shade900, width: 2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    onChanged: (newValue) {},
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15.0),
                        hintText: "Type your message here",
                        border: InputBorder.none),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (_messageController.text != "") {
                        _firebaseDatabase.collection(MESSAGE_COLLECTION).add({
                          MESSAGE_SENDER: loggedInUser.email,
                          MESSAGE_TEXT: _messageController.text
                        });
                      }
                      _messageController.clear();
                    },
                    icon: Icon(Icons.send)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
