import 'package:echo/component/bubble_chat.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
          ),
          title: Text("User User",
              style: Theme.of(context).textTheme.displayMedium),
          subtitle: Text("Active now",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 10)),
        ),
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).colorScheme.onSecondary,
            )),
      ),
      body: Card(
        elevation: 0,
        child: ListView(
          reverse: true,
          children: [
            BubbleChat(isMe: false),
            BubbleChat(isMe: true),
            BubbleChat(isMe: false),
            BubbleChat(isMe: true),
            BubbleChat(isMe: false),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: TextField(
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.primary,
                  ))),
        ),
      ),
    );
  }
}
