import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  void setUpPushNotifications() async{

    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();


   // fcm.subscribeToTopic('chat'); -- this sends the message to all users who sent a message on the app

    final token = await fcm.getToken();
    print(token); // this token could be sent to Firestore too

  }

  @override
  void initState() {
    super.initState();
    
    setUpPushNotifications();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        actions: [
          IconButton(
            onPressed: () {
              //automatically switched back to the AuthScreen
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: ChatMessages(),
          ),
          NewMessage(),
        ],
      ),
    );
  }
}
