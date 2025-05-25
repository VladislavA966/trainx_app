import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const _apiKey =
    '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';

enum ChatSender { user, assistant }

class ChatMessage {
  final String text;
  final ChatSender sender;

  ChatMessage({required this.text, required this.sender});
}

class ChatController extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  final String basePrompt;
  final String userProfileInfo;

  bool isLoading = false;

  List<ChatMessage> get messages => List.unmodifiable(_messages);

  ChatController({
    required this.basePrompt,
    required this.userProfileInfo,
  });

  Future<void> sendMessage(String userText) async {
    _messages.add(ChatMessage(text: userText, sender: ChatSender.user));
    isLoading = true;
    notifyListeners();

    final response = await _getAiResponse(userText);

    _messages.add(ChatMessage(text: response, sender: ChatSender.assistant));
    isLoading = false;
    notifyListeners();
  }

  Future<String> _getAiResponse(String userText) async {
    final uri = Uri.parse('https://api.openai.com/v1/chat/completions');

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "system", "content": "$basePrompt\n$userProfileInfo"},
          ..._messages.map((m) => {
                "role": m.sender == ChatSender.user ? "user" : "assistant",
                "content": m.text,
              }),
          {"role": "user", "content": userText}
        ]
      }),
    );

    final decoded = jsonDecode(response.body);
    return decoded['choices'][0]['message']['content'].toString().trim();
  }
}

@RoutePage()
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  late final ChatController chat;

  @override
  void initState() {
    super.initState();
    chat = ChatController(
      basePrompt: "Ты AI помощник по циклическим видам спорта...",
      userProfileInfo: "Возраст: 29, Вид спорта: бег, Цель: 10 км",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Ассистент")),
      body: Column(
        children: [
          Expanded(
            child: AnimatedBuilder(
              animation: chat,
              builder: (context, _) => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: chat.messages.length,
                itemBuilder: (_, i) {
                  final msg = chat.messages[i];
                  return Align(
                    alignment: msg.sender == ChatSender.user
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: msg.sender == ChatSender.user
                            ? Colors.blue.shade100
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(msg.text),
                    ),
                  );
                },
              ),
            ),
          ),
          if (chat.isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(controller: _controller),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      _controller.clear();
                      await chat.sendMessage(text);
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
