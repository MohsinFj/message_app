import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:message_app/components/chat_bubble.dart';
import 'package:message_app/components/my_textfield.dart';
import 'package:message_app/services/auth/auth_service.dart';
import 'package:message_app/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  final TextEditingController _messageController = TextEditingController();
  // get chat and authServices
  final ChatServices _chatServices = ChatServices();
  final AuthServices _authServices = AuthServices();

  // send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      String message = _messageController.text;
      _messageController.clear();
      await _chatServices.sendMessage(receiverID, message);

      // clear text controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          // display all messages
          Expanded(child: _buildMessageList()),

          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    String snederID = _authServices.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatServices.getMessages(snederID, receiverID),
      builder: (context, snapshot) {
        // errors
        if (snapshot.hasError) {
          return const Text("Error");
        }
        // loading...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        // return list view
        return ListView(
          reverse: true,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser =
        data['senderID'] == _authServices.getCurrentUser()!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child:
            ChatBubble(message: data['message'], isCurrentUser: isCurrentUser));
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
              child: MyTextfield(
                  hintText: "Type a message",
                  obscureText: false,
                  controller: _messageController)),
          Container(
            margin: const EdgeInsets.only(right: 20),
            decoration: const BoxDecoration(
                color: Colors.green, shape: BoxShape.circle),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
