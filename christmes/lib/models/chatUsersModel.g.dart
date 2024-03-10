// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatUsersModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatUsersAdapter extends TypeAdapter<ChatUsers> {
  @override
  final int typeId = 0;

  @override
  ChatUsers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatUsers(
      name: fields[0] as String,
      messageText: fields[1] as String,
      imageURL: fields[2] as String,
      time: fields[3] as String,
      roomID: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChatUsers obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.messageText)
      ..writeByte(2)
      ..write(obj.imageURL)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.roomID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatUsersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChatUsersListAdapter extends TypeAdapter<ChatUsersList> {
  @override
  final int typeId = 1;

  @override
  ChatUsersList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatUsersList(
      list: (fields[0] as List).cast<ChatUsers>(),
    );
  }

  @override
  void write(BinaryWriter writer, ChatUsersList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatUsersListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
