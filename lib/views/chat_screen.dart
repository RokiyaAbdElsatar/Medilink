import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/views/navigation_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> messages = [];

  /// 🧠 دالة إرسال الرسالة واستقبال الرد من السيرفر (Gemini API)
  Future<void> sendMessage() async {
    final messageText = _controller.text.trim();
    if (messageText.isEmpty) return;

    setState(() {
      messages.add({
        'text': messageText,
        'isUser': true,
        'time': DateFormat('HH:mm').format(DateTime.now()),
      });
    });

    _controller.clear();

    // 🔗 رابط الـ FastAPI (بدّلي IP حسب جهازك)
final url = Uri.parse('http://127.0.0.1:8000/chatbot');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': messageText}),
      );

      if (response.statusCode == 200) {
        final reply = jsonDecode(response.body)['reply'];
        setState(() {
          messages.add({
            'text': reply,
            'isUser': false,
            'time': DateFormat('HH:mm').format(DateTime.now()),
          });
        });
      } else {
        throw Exception('Failed to get AI response');
      }
    } catch (e) {
      setState(() {
        messages.add({
          'text': '⚠️ Error: Could not connect to AI server.',
          'isUser': false,
          'time': DateFormat('HH:mm').format(DateTime.now()),
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leadingWidth: 30,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp, color: Color(AppColor.primary)),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NavigationScreen()),
          ),
        ),
        title: Row(
          children: [
            Image.asset('assets/images/Robot.png', width: 32, height: 32),
            const SizedBox(width: 8),
            const Text(
              "MediBot",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isUser = msg['isUser'] as bool;

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment:
                        isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!isUser) ...[
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              msg['text'],
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          msg['time'],
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                      ] else ...[
                        Text(
                          msg['time'],
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF009FE3),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              msg['text'],
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),

          // حقل الإدخال
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                hintText: "Type a message...",
                                border: InputBorder.none,
                              ),
                              onSubmitted: (_) => sendMessage(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xFF009FE3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
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
