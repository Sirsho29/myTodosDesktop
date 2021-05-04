import 'package:flutter/material.dart';
import 'package:my_todos/screens/calender.dart';
import 'package:my_todos/screens/editProfile.dart';
import 'package:my_todos/variables.dart';
import 'package:my_todos/widgets/motivation.dart';

class Home extends StatelessWidget {
  final GlobalKey scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      endDrawer: Drawer(
        child: Container(
            color: Colors.black87,
            child: Column(
              children: [
                SizedBox(height: size.height / 20),
                CircleAvatar(
                  backgroundImage: AssetImage(getAvatarPath(avatar)),
                  radius: 80,
                ),
                SizedBox(height: size.height / 20),
                ListTile(
                  title: Text(
                    'TODOs',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          opaque: false, // set to false
                          pageBuilder: (_, __, ___) => CalenderTodos(),
                        ));
                  },
                ),
                SizedBox(height: size.height / 20),
                ListTile(
                  title: Text(
                    'Edit Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          opaque: false, // set to false
                          pageBuilder: (_, __, ___) => Profile(),
                        ));
                  },
                ),
                SizedBox(height: size.height / 20),
              ],
            )),
      ),
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          Builder(builder: (ctx) {
            return IconButton(
                iconSize: 50,
                icon:
                    Image(height: 50, image: AssetImage(getAvatarPath(avatar))),
                onPressed: () {
                  Scaffold.of(ctx).openEndDrawer();
                });
          })
        ],
      ),
      body: Motivations(),
    );
  }
}
