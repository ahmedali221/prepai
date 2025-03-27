class ChatMessage {
  final String id;
  final String text;
  final String sender;
  final bool isUser;
  final DateTime createdAt;

  ChatMessage({
    required this.id,
    required this.text,
    required this.sender,
    required this.isUser,
    required this.createdAt,
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'sender': sender,
      'isUser': isUser,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Convert from Firestore Map
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      sender: map['sender'] ?? '',
      isUser: map['isUser'] ?? false,
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
