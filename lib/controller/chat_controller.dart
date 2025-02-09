import 'package:ai_assistent/apis/apis.dart';
import 'package:ai_assistent/model/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class Chat_Controller extends GetxController {
  final textC = TextEditingController();
  final scrollController = ScrollController();
  final list = <Message>[
    Message(msg: 'Hello! How can I help you?', msgType: MessageType.bot)
  ].obs;

  Future<void> askQuestion() async {
    if (textC.text.trim().isNotEmpty) {
      final userMessage = textC.text.trim();
      list.add(Message(msg: userMessage, msgType: MessageType.user));
      textC.text = '';

      // Adding a placeholder for the bot response
      list.add(Message(msg: 'Please wait...', msgType: MessageType.bot));

      scrollDown();

      // Get response from the API
      final res = await Apis.getAnswer(userMessage);

      // Remove "Please wait..." placeholder and add the actual bot response
      list.removeLast();
      list.add(Message(msg: res, msgType: MessageType.bot));

      scrollDown();
    }
  }

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }
}
