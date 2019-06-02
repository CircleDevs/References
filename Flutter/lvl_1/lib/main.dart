import 'package:flutter/material.dart';
import 'Views/ChatScreen.dart';

void main() => runApp(FriendlychatApp());

class FriendlychatApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FriendlyChat',
      home: ChatScreen(),
    );
  }
}