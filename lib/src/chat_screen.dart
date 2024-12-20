import 'package:flutter/material.dart';
import 'models/chat_message.dart';
import 'message_bubble.dart';

typedef SendMessageCallback = void Function(String message);

class ChatScreen extends StatefulWidget {
  final List<ChatMessage> messages;
  final SendMessageCallback onSendMessage;
  final String hintText;

  const ChatScreen({
    super.key,
    required this.messages,
    required this.onSendMessage,
    this.hintText = 'Type a message...',
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            padding: const EdgeInsets.all(8.0),
            itemCount: widget.messages.length,
            itemBuilder: (context, index) {
              final message = widget.messages[index];
              return MessageBubble(message: message);
            },
          ),
        ),
        _buildInputField(theme),
      ],
    );
  }

  Widget _buildInputField(ThemeData theme) {
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
                hintStyle: theme.textTheme.bodyMedium,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: theme.colorScheme.primary,
            ),
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
