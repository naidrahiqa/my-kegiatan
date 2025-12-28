class ChatMessage {
  final String id;
  final String message;
  final bool isUser;
  final DateTime timestamp;
  final MessageType type;
  
  ChatMessage({
    required this.id,
    required this.message,
    required this.isUser,
    required this.timestamp,
    this.type = MessageType.text,
  });

  factory ChatMessage.user(String message) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: message,
      isUser: true,
      timestamp: DateTime.now(),
      type: MessageType.text,
    );
  }

  factory ChatMessage.ai(String message, {MessageType type = MessageType.text}) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: message,
      isUser: false,
      timestamp: DateTime.now(),
      type: type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'isUser': isUser ? 1 : 0,
      'timestamp': timestamp.toIso8601String(),
      'type': type.toString(),
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'],
      message: map['message'],
      isUser: map['isUser'] == 1,
      timestamp: DateTime.parse(map['timestamp']),
      type: MessageType.values.firstWhere(
        (e) => e.toString() == map['type'],
        orElse: () => MessageType.text,
      ),
    );
  }
}

enum MessageType {
  text,
  suggestion,
  analysis,
}
