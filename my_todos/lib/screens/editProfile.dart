import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_todos/variables.dart';
import 'package:my_todos/widgets/todoChip.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController text;
  int tecType = 0;
  //1:name
  //2:goal
  //3:todos
  @override
  void initState() {
    text = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: Container(
          height: size.height / 1.5,
          width: size.width / 2,
          color: Colors.black87,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                          size: size.width / 60,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: SpeedDial(
                          buttonSize: 60,
                          orientation: SpeedDialOrientation.Up,
                          closeManually: false,
                          useRotationAnimation: true,
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage(getAvatarPath(avatar)),
                              child: Icon(
                                Icons.edit,
                                color: Colors.black54,
                                size: size.width / 60,
                              ),
                              foregroundColor: Colors.black,
                              radius: 80,
                            ),
                          ),
                          children: List.generate(6, (i) {
                            return SpeedDialChild(
                              onTap: () {
                                print(avatar);
                                avatar = i + 1;
                                setState(() {});
                              },
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: GestureDetector(
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage(getAvatarPath(i + 1)),
                                    radius: 60,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height / 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: size.width / 60),
                        Text(username,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        Container(
                          width: size.width / 60,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                tecType = 1;
                              });
                            },
                            child: Icon(Icons.edit_outlined,
                                size: size.width / 60, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: size.height / 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: size.width / 60),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text('Short Term Goal :  ',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                        Text(shortTermGoal,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(color: Colors.white54, fontSize: 20)),
                      ],
                    ),
                    Container(
                        width: size.width / 60,
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(Icons.calendar_today_outlined,
                              size: size.width / 60, color: Colors.white),
                        ))
                  ],
                ),
                Wrap(
                  children: [
                        Container(
                          child: Text('TODOs :  ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ] +
                      [
                        (todos.length == 0)
                            ? Container(
                                child: Text('No added TODOs',
                                    style: TextStyle(
                                        color: Colors.white54, fontSize: 20)),
                              )
                            : Container(height: 0, width: 0),
                      ] +
                      List.generate(todos.length, (index) {
                        return Container(
                            child: TodoChip(
                          index: index,
                          onDeleted: () {
                            todos.removeAt(index);
                            setState(() {});
                            SharedPreferences.getInstance().then((value) {
                              value.setStringList('todos', todos);
                            });
                          },
                        ));
                      }) +
                      [
                        Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: GestureDetector(
                              child: Icon(
                                Icons.add_box_outlined,
                                size: size.width / 60,
                                color: Colors.white,
                              ),
                              onTap: () {
                                setState(() {
                                  tecType = 2;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Container(
                    // color: Colors.white,
                    height: size.height / 20,
                    width: size.width / 4.5,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: tecType == 0 ? 0 : 1,
                      child: Row(
                        children: [
                          Container(
                            width: size.width / 5,
                            child: TextFormField(
                              controller: text,
                              style: TextStyle(color: Colors.white),
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Username',
                                hintStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Colors.grey,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 6.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (tecType == 1) {
                                  setState(() {
                                    tecType = 0;
                                    username = text.text;
                                    text.clear();
                                  });
                                  SharedPreferences.getInstance().then((value) {
                                    value.setString('username', username);
                                  });
                                } else if (tecType == 2) {
                                  setState(() {
                                    tecType = 0;
                                    todos.add(text.text);
                                    text.clear();
                                  });
                                  SharedPreferences.getInstance().then((value) {
                                    value.setStringList('todos', todos);
                                  });
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
