import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_todos/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todo extends StatefulWidget {
  final String currentDateId;
  final bool isToday;
  final String date;
  Todo(
      {@required this.currentDateId,
      this.isToday = false,
      @required this.date});

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  void initState() {
    if (!data.containsKey(widget.currentDateId)) {
      Map temp = Map();
      temp.addAll({'all': false});
      todos.forEach((element) {
        temp.addAll({element: false});
      });
      data.addAll({widget.currentDateId: temp});
    }
    SharedPreferences.getInstance().then((value) {
      pref = value;
    });
    super.initState();
  }

  SharedPreferences pref;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black12,
        body: Center(
            child: Container(
          height: size.height / 1.5,
          width: size.width / 3,
          color: Colors.black87,
          child: Scaffold(
            backgroundColor: Colors.black87,
            appBar: AppBar(
              backgroundColor: Colors.black87,
              leading: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                widget.date,
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  children: List.generate(
                      data[widget.currentDateId].keys.length, (i) {
                String key = data[widget.currentDateId].keys.toList()[i];
                return CheckboxListTile(
                  title: Text(
                    (i + 1).toString() + '. ' + key,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
                  ),
                  value: data[widget.currentDateId][key],
                  onChanged: !widget.isToday?null:(v) {
                    setState(() {
                      data[widget.currentDateId][key] = v;
                    });
                    pref.setString('data', jsonEncode(data));
                  },
                  activeColor: Colors.white,
                  checkColor: Colors.black,
                );
              })),
            ),
          ),
        )));
  }
}
