import 'dart:typed_data'; // For Uint8List
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class AiImageFeature extends ConsumerStatefulWidget {
  @override
  ConsumerState createState() => _ImageScreenState();
}

class _ImageScreenState extends ConsumerState<AiImageFeature> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController(); // Add ScrollController
  List<Map<String, dynamic>> chatData = []; // Stores messages and their images
  bool isLoading = false; // Tracks loading state for Lottie animation

  // Function to make the API call to the text-to-image API
  Future<void> sendMessage(String message) async {
    if (message.isEmpty) return;

    // Add user message to the chat
    setState(() {
      chatData.add({'type': 'text', 'content': message});
      isLoading = true; // Show loader
    });

    try {
      // Encode the prompt properly
      final encodedPrompt = Uri.encodeComponent(message);

      // Make the API call
      final response = await http.get(
        Uri.parse('https://image.pollinations.ai/prompt/$encodedPrompt'),
      );

      if (response.statusCode == 200) {
        final Uint8List bytes = response.bodyBytes;

        // Add the generated image to the chat
        setState(() {
          chatData.add({'type': 'image', 'content': Image.memory(bytes)});
        });
      } else {
        print('Error: Unexpected response (${response.statusCode})');
        setState(() {
          chatData.add({
            'type': 'error',
            'content': 'Failed to generate image. Try again.',
          });
        });
      }
    } catch (e) {
      print('Error in sending message: $e'); // Log error
      setState(() {
        chatData.add({
          'type': 'error',
          'content': 'An error occurred. Please check your connection.',
        });
      });
    } finally {
      setState(() {
        isLoading = false; // Hide loader
        // Scroll to the bottom after adding a new message
        _scrollToBottom();
      });
    }
  }

  // Scroll to the bottom of the ListView
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Imagine"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Display chat messages and images
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Attach ScrollController
              physics: const BouncingScrollPhysics(), // Apply bouncing scroll physics
              itemCount: chatData.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (isLoading && index == chatData.length) {
                  // Show Lottie loader while loading
                  return Center(
                    child: Lottie.asset(
                      'assets/lottie/loader.json',
                      height: 150,
                    ),
                  );
                }

                final item = chatData[index];
                if (item['type'] == 'text') {
                  // Right side for user text messages
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color of the container
                          border: Border.all(color: Colors.black26, width: 2), // Black border
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20), // Curve on the top-right corner
                            bottomRight: Radius.circular(20), // Curve on the bottom-right corner
                          ),
                        ),
                        child: Text(
                          item['content'], // User message
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  );
                } else if (item['type'] == 'image') {
                  // Left side for generated images
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: item['content'], // Image widget
                      ),
                    ),
                  );
                } else if (item['type'] == 'error') {
                  // Error message
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.redAccent, // Error message color
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item['content'], // Error message
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
          // Text input and send button
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200, // Light background for input
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Type your prompt...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      maxLines: null,
                      minLines: 1,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.blue),
                    onPressed: () {
                      sendMessage(_controller.text.trim());
                      _controller.clear();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}