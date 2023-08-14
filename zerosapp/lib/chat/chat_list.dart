import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zeros/chat/chat.dart';
import '../Testing/Theme/app_color.dart';
import '../models/posts.dart';

class ChatListScreen extends StatelessWidget {
  static var routeName='/ChatListScreen';

  const ChatListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Staff'),
        backgroundColor: AppColor.kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0), // Adjust the top padding value as needed
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('staff')
              .where('isActive', isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColor.kPlaceholder2,
                  backgroundColor: AppColor.kPlaceholder3,
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No staff till now.'));
            }

            List<Staff> staffItems = snapshot.data!.docs
                .map((doc) => Staff.fromJson(doc.data() as Map<String, dynamic>))
                .toList();

            return ListView.separated(
              itemCount: staffItems.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                Staff staff = staffItems[index];

                return GestureDetector(
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserChatPage(
                            todoItemId: snapshot.data!.docs[index].id,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserChatPage(
                            todoItemId: snapshot.data!.docs[index].id,
                          ),
                        ),
                      );
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(staff.photoURL!),
                              backgroundColor: AppColor.kWhiteColor,
                            ),
                            const SizedBox(width: 16),
                            // FullName
                            Text(
                              '${staff.firstname} ${staff.lastname}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
