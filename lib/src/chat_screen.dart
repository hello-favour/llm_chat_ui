import 'package:flutter/material.dart';
import 'package:llm_chat_ui/llm_chat_ui.dart';
import 'message_bubble.dart';

typedef SendMessageCallback = void Function(String message);

class ChatScreen extends StatefulWidget {
  final List<ChatMessage> messages;
  final SendMessageCallback onSendMessage;
  final String hintText;
  final bool showSystemMessages;

  const ChatScreen({
    super.key,
    required this.messages,
    required this.onSendMessage,
    this.hintText = 'Type a message...',
    this.showSystemMessages = true,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final visibleMessages = widget.showSystemMessages
        ? widget.messages
        : widget.messages
            .where((msg) => msg.messageType != MessageType.system)
            .toList();

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            padding: const EdgeInsets.all(8.0),
            itemCount: visibleMessages.length,
            itemBuilder: (context, index) {
              final message = visibleMessages[index];
              return MessageBubble(message: message);
            },
          ),
        ),
        _buildInputField(),
      ],
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final text = _controller.text.trim();
              if (text.isNotEmpty) {
                widget.onSendMessage(text);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
