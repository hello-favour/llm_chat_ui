import 'package:flutter/material.dart';
import 'package:llm_chat_ui/llm_chat_ui.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.messageType == MessageType.user;
    final isAssistant = message.messageType == MessageType.assistant;
    final isSystem = message.messageType == MessageType.system;

    // Determine alignment and colors based on message type
    final alignment = isUser
        ? Alignment.centerRight
        : isAssistant
            ? Alignment.centerLeft
            : Alignment.center;
    final backgroundColor = isSystem
        ? theme.colorScheme.surfaceVariant
        : isUser
            ? theme.colorScheme.primary
            : theme.colorScheme.secondaryContainer;
    final textColor = isSystem
        ? theme.colorScheme.onSurfaceVariant
        : isUser
            ? theme.colorScheme.onPrimary
            : theme.colorScheme.onSecondaryContainer;

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          message.text,
          style: theme.textTheme.bodyMedium?.copyWith(color: textColor),
        ),
      ),
    );
  }
}
