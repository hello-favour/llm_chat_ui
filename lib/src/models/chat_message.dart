import 'message_type.dart';

class ChatMessage {
  final String text;
  final MessageType messageType;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.messageType,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
