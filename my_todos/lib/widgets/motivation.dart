import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_todos/screens/editProfile.dart';
import 'package:my_todos/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Motivations extends StatefulWidget {
  @override
  _MotivationsState createState() => _MotivationsState();
}

class _MotivationsState extends State<Motivations> {
  List nums;

  getPrefs() {
    isCallingLocalFirstTime = true;
    SharedPreferences.getInstance().then((pref) {
      if (!pref.containsKey('username')) {
        Navigator.push(
            context,
            PageRouteBuilder(
              opaque: false, // set to false
              pageBuilder: (_, __, ___) => Profile(),
            ));
      } else {
        // print('username : '+pref.getString('username'));
        setState(() {
          username = pref.getString('username') == null
              ? 'Anonymous'
              : pref.getString('username');
          avatar = pref.getInt('avatar') == null ? 4 : pref.getInt('avatar');
          shortTermGoal = pref.getString('shortTermGoal') == null
              ? 'Not selected'
              : pref.getString('shortTermGoal');
          todos = pref.getStringList('todos') == null
              ? []
              : pref.getStringList('todos');
          data = pref.getString('data') == null
              ? {}
              : jsonDecode(pref.getString('data'));
        });
      }
    });
  }

  @override
  void initState() {
    nums = List.generate(11, (index) => index);
    nums.shuffle();
    if (!isCallingLocalFirstTime) getPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceEvenly,
          children: List.generate(9, (i) {
            return Container(
                constraints: BoxConstraints(
                  maxHeight: size.height / 2,
                  maxWidth: size.width / 3,
                ),
                child:
                    Image(image: AssetImage('assets/img/${nums[i] + 1}.jpg')));
          }),
        ),
      ),
    );
  }
}
