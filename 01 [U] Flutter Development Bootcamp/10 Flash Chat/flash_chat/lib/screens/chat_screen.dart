import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/message_bubble.dart';

User? loggedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const String id = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final messageTextController = TextEditingController();
  String? messageText;

  void getCurrentUser() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        if (kDebugMode) {
          print('User is currently signed out!');
          Navigator.pushNamed(context, WelcomeScreen.id);
        }
      } else {
        if (kDebugMode) {
          print('User is signed in!');
        }
        loggedInUser = user;
      }
    });
  }

  // void messageStream() {
  //   _firestore.collection('messages').get().then((value) {
  //     for (var doc in value.docs) {
  //       print('init');
  //       print(doc.data());
  //     }
  //   });
  //
  //   _firestore.collection('messages').snapshots().listen((value) {
  //     for (var doc in value.docs) {
  //       print('realtime');
  //       print(doc.data());
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Flexible(
              flex: 1,
              child: ChatList(),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      await _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser?.email,
                      });

                      messageTextController.clear();
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);
  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final Stream<QuerySnapshot> _messageStream =
      FirebaseFirestore.instance.collection('messages').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        // return ListView.builder(
        //   itemBuilder: (BuildContext context, int index) {
        //     if (index < snapshot.data!.docs.length) {
        //       var data = snapshot.data!.docs;
        //       String sender = data.elementAt(index)['sender'];
        //       String text = data.elementAt(index)['text'];
        //       return MessageBubble(
        //           sender: sender,
        //           text: text,
        //           isMe: sender == loggedInUser?.email);
        //     }
        //   },

        return ListView(
          children: snapshot.data!.docs.reversed.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            String sender = data['sender'];
            String text = data['text'];
            return MessageBubble(
                sender: sender,
                text: text,
                isMe: sender == loggedInUser?.email);
          }).toList(),
        );
      },
    );
  }
}
