import 'package:hive/hive.dart';

part 'chatMessageModel.g.dart';

@HiveType(typeId: 2) // Assign a unique typeId
class ChatMessage {
  @HiveField(0) // Assign a unique index to each field
  String messageContent;

  @HiveField(1)
  String messageType;

  ChatMessage({required this.messageContent, required this.messageType});
}

@HiveType(typeId: 3)
class ChatMessageList {
  @HiveField(0)
  final List<ChatMessage> list;

  ChatMessageList({required this.list});
}