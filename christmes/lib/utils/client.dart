import 'dart:js_util';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:matrix/matrix.dart';
import '../models/chatMessageModel.dart';
import '../screens/chatDetailPage.dart';
import '../screens/groupPage.dart';
import '../screens/chatPage.dart';
import '../models/chatUsersModel.dart';
import '../widgets/conversationList.dart';
import 'JSONRoom.dart';



GroupPageState gp = new GroupPageState();
ChatPageState cp = ChatPageState();

class MatrixClient {
  String username="";
  String pwd="";

  MatrixClient() {
    username= Hive.box('client').get("username");
    pwd= Hive.box('client').get("pwd");
    print(username+pwd);

  }


  final client = Client(
    "Client",
  );

  List chatrooms = [];

Future<Uri?> getAvatar () async {
  final pic = client.getContentThumbnail("matrix.org", "tHwINSDGpHigLhiNfKAQxMeR", 800, 600);
  //return client.getContentThumbnail("matrix.org", "tHwINSDGpHigLhiNfKAQxMeR", 800, 600);
  return client.getAvatarUrl(client.userID!);

}


  ChatDetailPageState cdp = ChatDetailPageState();








  Future<void> getRooms() async {

    //chat

    List<ChatUsers> chatUsers = [];

//groups

    List<ChatUsers> groupUsers = [];

    await client.checkHomeserver("https://matrix-client.matrix.org/");

    await client.login(
      LoginType.mLoginPassword,
      identifier: AuthenticationUserIdentifier(user: username),
      password: pwd,
    );


      List list = await client.getJoinedRooms();
      for(int i=0; i<list.length; i++){
        bool? directchat = false;
        directchat = client.getRoomById(list[i])?.isDirectChat;
        if(directchat!=null) {
          if (directchat) {
            chatUsers.add(ChatUsers(
                name: client.getRoomById(list[i])!.displayname,
                messageText: client.getRoomById(client.getRoomById(list[i])!.id)?.lastEvent?.text ?? 'Default Value',
                imageURL: "https://matrix-client.matrix.org/_matrix/media/v3/thumbnail/matrix.org/tHwINSDGpHigLhiNfKAQxMeR?width=800&height=600&method=scale",
                time: "Now",
                roomID: client.getRoomById(list[i])!.id));
          } else {
            groupUsers.add(ChatUsers(name: client.getRoomById(list[i])!.displayname,
                messageText: client.getRoomById(client.getRoomById(list[i])!.id)?.lastEvent?.text ?? 'Default Value',
                imageURL: "https://matrix-client.matrix.org/_matrix/media/v3/thumbnail/matrix.org/tHwINSDGpHigLhiNfKAQxMeR?width=800&height=600&method=scale",
                time: "Now", roomID: client.getRoomById(list[i])!.id));
          }
        }
      }



    Hive.box<ChatUsersList>("chats").put("chat", ChatUsersList(list: chatUsers));
    Hive.box<ChatUsersList>("chats").put("group", ChatUsersList(list: groupUsers));


    client.logout();
  }

  //messages

  Future<void> sentmessage (String message, String roomID, String us, String pass) async {
    await client.checkHomeserver("https://matrix-client.matrix.org/");

    await client.login(
      LoginType.mLoginPassword,
      identifier: AuthenticationUserIdentifier(user: us),
      password: pass,

    );
    print(roomID);
    await client.getRoomById(roomID)?.sendTextEvent(message);

    chatrooms = client.rooms;

    client.logout();
  }

 Future<List<ChatMessage>> getMessages(String roomID) async {
    List<ChatMessage> clientmessages = [];

    username= Hive.box('client').get("username");
    pwd= Hive.box('client').get("pwd");



    await client.checkHomeserver("https://matrix-client.matrix.org/");

    await client.login(
      LoginType.mLoginPassword,
      identifier: AuthenticationUserIdentifier(user: username),
      password: pwd,

    );

    GetRoomEventsResponse response = await client.getRoomEvents(roomID, "", Direction.b,limit: 9999999);
    Map<String, dynamic> json = response.toJson();
    print("json");
    print(json);
  List<Chunk>? chunk = JSONRoom.fromJson(json).chunk;
    print(chunk!.length);

    for(int i=0; i<chunk.length; i++){

      String type = chunk.elementAt(i).type.toString();
      if(type == "m.room.message"){
        String msg = chunk.elementAt(i).content!.body.toString();
        String senders;
        print(chunk.elementAt(i).type.toString());
        print(chunk.elementAt(i).content!.body.toString());
        String sender = chunk.elementAt(i).sender.toString();

        if(sender.contains(username.toLowerCase())) {
          print("sender");

          clientmessages.add(ChatMessage(messageContent: msg, messageType: "sender"));
        }else{
          print("receiver");

          clientmessages.add(ChatMessage(messageContent: msg, messageType: "receiver"));
        }
      }
    }

    client.logout();
    print("logoutmsg");
    return clientmessages;
  }


}