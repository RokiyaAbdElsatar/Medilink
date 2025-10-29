import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medilink/core/constant/appcolor.dart';
import 'package:medilink/views/navigation_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> messages = [
    {
      'text': 'hi, i have a question about a medication i\'m taking.',
      'isUser': true,
      'time': '12:00',
    },
    {
      'text':
          'sure! what medication are you taking and what would you like to know',
      'isUser': false,
      'time': '12:00',
    },
    {
      'text': 'i\'ve been prescribed amoxicillin. what is it used for?',
      'isUser': true,
      'time': '12:01',
    },
    {
      'text':
          'amoxicillin is an antibiotic. it’s commonly used to treat bacterial infections such as respiratory',
      'isUser': false,
      'time': '12:01',
    },
    {
      'text': 'can i take it on an empty stomach',
      'isUser': true,
      'time': '12:02',
    },
    {
      'text':
          'yes, you can take amoxicillin with or without food. however, taking it with food might help reduce stomach upset',
      'isUser': false,
      'time': '12:02',
    },
  ];

  void sendMessage() {
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

    /**  TO DO **/
    //Chat bot response simulation
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
                    mainAxisAlignment: isUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!isUser) ...[
                        // رسالة البوت
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
                        // رسالة المستخدم
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
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.attach_file,
                              color: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                hintText: "Type a message",
                                border: InputBorder.none,
                              ),
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
