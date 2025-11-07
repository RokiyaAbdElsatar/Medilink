import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/views/navigation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> messages = [];

  String? userId;

  @override
  void initState() {
    super.initState();
    _initializeUserId();
    _showWelcomeMessage();
  }

  /// ✅ تحميل أو إنشاء user_id
  Future<void> _initializeUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedId = prefs.getString('user_id');

    if (storedId == null) {
      storedId = const Uuid().v4();
      await prefs.setString('user_id', storedId);
      print("🆕 تم إنشاء user_id جديد: $storedId");
    } else {
      print("♻️ تم تحميل user_id الموجود: $storedId");
    }

    setState(() => userId = storedId);
  }

  /// 💬 الرسالة الافتتاحية
  void _showWelcomeMessage() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        messages.add({
          'text':
              '👨‍⚕️ مرحبًا! أنا MediBot الطبيب الذكي 😊\nممكن أعرف بتعاني من إيه عشان نبدأ؟',
          'isUser': false,
          'time': DateFormat('HH:mm').format(DateTime.now()),
        });
      });
    });
  }

  /// 🧠 إرسال الرسالة للسيرفر واستقبال الرد
  Future<void> sendMessage() async {
    final messageText = _controller.text.trim();
    if (messageText.isEmpty || userId == null) return;

    setState(() {
      messages.add({
        'text': messageText,
        'isUser': true,
        'time': DateFormat('HH:mm').format(DateTime.now()),
      });
    });

    _controller.clear();

    final url = Uri.parse('http://192.168.1.12:7000/chatbot'); // ⚠️ بدّلي IP حسب جهازك

    try {
      print("📩 Sending to server => user_id: $userId | message: $messageText");

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId, // ✅ إرسال المعرف المحفوظ
          'message': messageText,
        }),
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
      print("Error in sendMessage: $e");
      setState(() {
        messages.add({
          'text': '⚠️ حدث خطأ أثناء الاتصال بالسيرفر.',
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

          // 🟦 إدخال الرسائل
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
                                hintText: "اكتب رسالتك...",
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
