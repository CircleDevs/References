import 'package:flutter/material.dart';
import 'package:lvl_1/Blocs/ChatScreenBloc.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ChatScreenBloc _chatScreenBloc = ChatScreenBloc();

  // The list of ChatMessage widgets to display on the screen
  final List<ChatMessage> _messages = <ChatMessage>[];

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () {
                  _chatScreenBloc.handleSubmittedText(_textController.text);
                  _textController.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Top level Material Scaffold object
    return Scaffold(
      // The Appbar at the top of the application
      appBar: AppBar(
        // What the AppBar should contain as its main text
        title: Text("Chat Test"),
      ),
      // Layout children widgets in a Vertical structure
      body: Column(
        children: <Widget>[
          // Flexible Child that takes up the rest of the available space
          Flexible(
            child: StreamBuilder(
              stream: _chatScreenBloc.textMessageSubj.stream,
              builder: (context, snapshot) {
                // Create a ChatMessage Widget from the Snapshot Data
                if(snapshot.hasData) {
                  _messages.insert(0, ChatMessage(text: snapshot.data));
                }
                // Display the ListView
                return ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _messages[index],
                  itemCount: _messages.length,
                );
              },
            ),
          ),
          // Draws a horizontal rule between the UI for displaying messages
          // and the text input field for composing messages
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          )
        ],
      ),
    );
  }
}

// A Chat bubble widget
class ChatMessage extends StatelessWidget {
  final String text;
  final String _name = "Daniel Kim";

  ChatMessage({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Place inset padding symmetric along the vertical axis
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        // Align to the Start of the Row
        crossAxisAlignment: CrossAxisAlignment.start,
        // The Children to display in this Widget horizontally
        children: <Widget>[
          // Place a CircleAvatar with a Margin of 16 LP
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              child: Text(_name[0]),
            ),
          ),
          // Lay items vertically
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // The Children to lay vertically
            children: <Widget>[
              // First lay out the User's name
              Text(_name, style: Theme.of(context).textTheme.subhead),
              // Layout the Text that the user has typed
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(text),
              ),
            ],
          )
        ],
      ),
    );
  }
}
