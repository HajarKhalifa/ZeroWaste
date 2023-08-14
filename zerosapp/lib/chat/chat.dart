import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zeros/chat/chat_list.dart';

import '../Testing/Theme/app_color.dart';
import '../models/posts.dart';

class UserChatPage extends StatefulWidget {
  static var routeName = '/UserChatPage';
  final String todoItemId;

  UserChatPage({required this.todoItemId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<UserChatPage> {
  final TextEditingController _textController = TextEditingController();
  late CollectionReference _staffCollection;
  late CollectionReference _userDocument;
  late final String _senderId;
  late ScrollController _scrollController = ScrollController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _getSenderId();
    _userDocument = _firestore.collection('users').doc(_senderId).collection('chat');
    _staffCollection = _firestore.collection('staff').doc(widget.todoItemId).collection('chat');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _getSenderId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _senderId = user.uid;
      });
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        _scrollToLastMessage();
      });
    }
  }
  void sendMessage(String message) {
    String receiverId = widget.todoItemId;

    MessageDataModel staffMessage = MessageDataModel(
      senderId: _senderId,
      receiverId: receiverId,
      message: message,
      time: Timestamp.now(),
    );

    MessageDataModel userMessage = MessageDataModel(
      senderId: _senderId,
      receiverId: receiverId,
      message: message,
      time: Timestamp.now(),
    );

    _staffCollection
        .doc(_senderId)
        .collection('messages')
        .add(staffMessage.toJson())
        .then((_) {
      setState(() {}); // Trigger UI rebuild after sending the message
      _scrollToLastMessage();
    });

    _userDocument
        .doc(widget.todoItemId)
        .collection('messages')
        .add(userMessage.toJson())
        .then((_) {
      setState(() {}); // Trigger UI rebuild after sending the message
      _scrollToLastMessage();
    });
    _scrollToLastMessage();
    _textController.clear();
  }

  Future<void> _scrollToLastMessage() async {
    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildMessageItem(MessageDataModel message) {
    final bool isSentMessage = _senderId == message.senderId;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: isSentMessage ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: isSentMessage ? Colors.blue.withOpacity(0.2) : Colors.grey[300],
            borderRadius: BorderRadiusDirectional.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            message.message,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            gradient: LinearGradient(
              colors: [
                AppColor.kPrimaryColor.withOpacity(1),
                AppColor.kAccentColor.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Text('Chat With Us',
          style:
          TextStyle(
            color: AppColor.kWhiteColor,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),


        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChatListScreen(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _staffCollection
                    .doc(_senderId)
                    .collection('messages')
                    .orderBy('time', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (!snapshot.hasData || snapshot.data!.size == 0) {
                    return Text('No messages found');
                  }

                  List<Map<String, dynamic>> messages = snapshot.data!.docs
                      .map((doc) => doc.data() as Map<String, dynamic>)
                      .toList();

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToLastMessage();
                  });

                  return ListView.builder(
                    controller: _scrollController, // Attach the ScrollController
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> messageData = messages[index];
                      MessageDataModel message = MessageDataModel.fromJson(messageData);
                      return _buildMessageItem(message);
                    },
                  );
                },
              ),
            ),            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue.withOpacity(0.5),
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 18),
                        controller: _textController,
                        cursorColor: AppColor.kPrimaryColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type your message here...',
                          hintStyle: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.kPrimaryColor.withOpacity(0.5),
                        width: 0.5,
                      ),
                      color: AppColor.kPrimaryColor,
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 50.0,
                    child: MaterialButton(
                      onPressed: () {
                        String message = _textController.text.trim();
                        if (message.isNotEmpty) {
                          sendMessage(message);
                        }
                      },
                      minWidth: 1.0,
                      child: Icon(
                        Icons.send,
                        size: 20,
                        color: Colors.white,
                      ),
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
