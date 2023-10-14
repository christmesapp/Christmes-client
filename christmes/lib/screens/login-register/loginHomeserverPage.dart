import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../misc/colors.dart';
import '../../utils/client.dart';
import '../hamburger_menu.dart';
import '../homePage.dart';
import 'registerPage.dart';



class LoginHomeserverPage extends StatefulWidget {
  @override
  _LoginHomeserverPage createState() => _LoginHomeserverPage();
}

class _LoginHomeserverPage extends State<LoginHomeserverPage> {
  final passwordController = TextEditingController();
  final userController = TextEditingController();
  final homeserverController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    passwordController.dispose();
    userController.dispose();
    homeserverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 150,

                  child: const Image(image: AssetImage('../img/christmes_logo.png')),
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: homeserverController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Homeserver',
                    hintText: 'Enter valid homeserver'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: userController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter secure password'),
              ),
            ),Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            TextButton(
              onPressed: (){
                //TODO FORGOT PASSWORD SCREEN GOES HERE
                showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: Text('Forgot Password function'),
                    );
                  },
                );
              },

              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: AppColors.blueColor, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  Hive.box('client').put("homeserver", homeserverController.text);
                  Hive.box('client').put("username", userController.text);
                  Hive.box('client').put("pwd", passwordController.text);
                  MatrixClient client = MatrixClient();
                  await client.getRooms();
                  //await client.getMessages("!OvzGnzTrZefYXEFufr:matrix.org");

                  //print(await Future.value(client.getAvatar()));
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomePage()));
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
      Container(
        height: 20,
        width: 200,
        child: InkWell(
          onTap: () {

            print('Clicked on new User');
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => RegisterPage()));
          },
          child: Text('New User? Create Account'),
        ),
      ),
          ],
        ),
      ),
    );
  }
}
