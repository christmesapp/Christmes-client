import 'package:christmes/screens/homePage.dart';
import 'package:christmes/screens/loginPage.dart';
import 'package:christmes/screens/personalPage.dart';
import 'package:christmes/utils/client.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/chatUsersModel.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ChatUsersAdapter());
  Hive.registerAdapter(ChatUsersListAdapter());
  var box = await Hive.openBox('client');
  var util = await Hive.openBox("util");
  var chats = await Hive.openBox<ChatUsersList>("chats");
  print("username");
  print(box.get("username"));
  if(chats.get("chat")!=null&&chats.get("group")!=null){
    MatrixClient client = MatrixClient();
    await client.getRooms();

  }
  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    if(Hive.box('client').get("username")==null){
      return MaterialApp(
      title: 'Christmes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
    }else {

      return MaterialApp(
      title: 'Christmes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );}

  }
}

