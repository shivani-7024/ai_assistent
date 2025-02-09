import 'package:ai_assistent/controller/chat_controller.dart';
import 'package:ai_assistent/custom/message_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatbotFeature extends StatefulWidget {
  const ChatbotFeature({super.key});

  @override
  State<ChatbotFeature> createState() => _ChatbotFeatureState();
}

class _ChatbotFeatureState extends State<ChatbotFeature> {
  final _c = Get.put(Chat_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with AI Assistant'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _c.textC,
                textAlign: TextAlign.center,
                onTapOutside: (e) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  hintText: "Ask me anything that you want...",
                  hintStyle: TextStyle(fontSize: 13),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: CircleAvatar(
                radius: 24,
                child: IconButton(
                  onPressed: _c.askQuestion,
                  icon: Icon(Icons.rocket, size: 28),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Obx(
            () => ListView(
          padding: EdgeInsets.only(bottom: 70, top: 10),
          controller: _c.scrollController,
          physics: const BouncingScrollPhysics(),
          children: _c.list.map((e) {
            return MessageCard(message: e);
          }).toList(),
        ),
      ),
    );
  }
}
