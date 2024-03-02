import 'package:hive/hive.dart';
import 'package:christmes/models/chatUsersModel.dart';
import 'package:christmes/widgets/conversationList.dart';
import 'package:flutter/material.dart';
class GroupPage extends StatefulWidget {
  @override
  GroupPageState createState() => GroupPageState();
}

class GroupPageState extends State<GroupPage> {




  List<ChatUsers> chatUsers = Hive.box('client').get("groupUsers");

  //List<ChatUsers> chatUsers = [];

  @override
  Widget build(BuildContext context) {

    print("Groupuser "+chatUsers.toString());

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: Hive.box('util').get("darkmode", defaultValue: true)? ThemeMode.dark : ThemeMode.light,
    darkTheme: ThemeData.dark(),

    home: Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        child: Column(



          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SafeArea(



              child: Padding(
                padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text("Groups",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                    Container(
                      padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: Row(
                        children: const <Widget>[
                          Icon(Icons.add,color: Colors.pink,size: 20,),
                          SizedBox(width: 2,),
                          Text("Add New",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    )
                  ],
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey.shade100
                      )
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ConversationList(

                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  imageUrl: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  roomID: chatUsers[index].roomID,
                  messages: [],
                  isMessageRead: (index == 0 || index == 3)?true:false,
                );
              },
            ),],

        ),
      ),
     ),
    );
  }
}

