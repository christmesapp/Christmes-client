import 'dart:convert';

import 'package:christmes/screens/homePage.dart';
import 'package:christmes/screens/loginPage.dart';
import 'package:christmes/utils/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {

  await Hive.initFlutter();



  const secureStorage = FlutterSecureStorage();
  // if key not exists return null
  final encryptionKeyString = await secureStorage.read(key: 'key');
  if (encryptionKeyString == null) {
    final key = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'key',
      value: base64UrlEncode(key),
    );}
  final key = await secureStorage.read(key: 'key');
  final encryptionKeyUint8List = base64Url.decode(key!);
  print('Encryption key Uint8List: $encryptionKeyUint8List');
  final box = await Hive.openBox('client', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));

  print("username");
  print(box.get("username"));
  if(box.get("username")!=null){
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

