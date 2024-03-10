import 'package:hive/hive.dart';

part 'chatUsersModel.g.dart'; // Name of the generated file

@HiveType(typeId: 0) // Unique typeId
class ChatUsers {
  @HiveField(0)
  String name;

  @HiveField(1)
  String messageText;

  @HiveField(2)
  String imageURL;

  @HiveField(3)
  String time;

  @HiveField(4)
  String roomID;

  ChatUsers({
    required this.name,
    required this.messageText,
    required this.imageURL,
    required this.time,
    required this.roomID,
  });
}

@HiveType(typeId: 1)
class ChatUsersList {
  @HiveField(0)
  final List<ChatUsers> list;

  ChatUsersList({required this.list});
}
