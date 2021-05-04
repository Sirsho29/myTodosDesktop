import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:my_todos/screens/todo.dart';
import 'package:my_todos/variables.dart';

// Map data = {
//   '2542021': {'all': false, 'leetcode': true, 'workout': true},
//   '2642021': {'all': true, 'leetcode': true, 'workout': true},
//   '152021': {'all': false, 'leetcode': true, 'workout': true},
//   '352021': {'all': true, 'leetcode': true, 'workout': true},
//   '452021': {'all': false, 'leetcode': true, 'workout': true},
// };

//data
class CalenderTodos extends StatefulWidget {
  @override
  _CalenderTodosState createState() => _CalenderTodosState();
}

class _CalenderTodosState extends State<CalenderTodos> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
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
      ),
      backgroundColor: Colors.black87,
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: size.height,
              width: size.height - MediaQuery.of(context).padding.top,
              alignment: Alignment.center,
              child: CalendarCarousel(
                // onDayPressed: (DateTime date) {
                //   this.setState(() => _currentDate = date);
                // },
                customDayBuilder: (a, b, c, d, e, f, g, h, i) {
                  //a bool isSelectable,
                  //b int index,
                  //c bool isSelectedDay,
                  //d bool isToday,
                  //e bool isPrevMonthDay,
                  //f TextStyle textStyle,
                  //g bool isNextMonthDay,
                  //h bool isThisMonthDay,
                  //i DateTime day
                  // if(e)
                  if (data == null) {
                    data = {};
                  }
                  String currentDay =
                      i.day.toString() + i.month.toString() + i.year.toString();
                  String currentDate = i.day.toString() +
                      '.' +
                      (i.month.toString().length == 1 ? '0' : '') +
                      i.month.toString() +
                      '.' +
                      i.year.toString();
                  if (g) {
                    return Container(
                        alignment: Alignment.center, child: day(i.day, false));
                  } else if (e) {
                    return data.containsKey(currentDay)
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    opaque: false, // set to false
                                    pageBuilder: (_, __, ___) => Todo(
                                      currentDateId: currentDay,
                                      date: currentDate,
                                    ),
                                  ));
                            },
                            child: data[currentDay]['all']
                                ? Container(
                                    color: Colors.green,
                                    alignment: Alignment.center,
                                    child: day(i.day, false))
                                : Container(
                                    color: Colors.redAccent,
                                    alignment: Alignment.center,
                                    child: day(i.day, false)),
                          )
                        : Container(
                            alignment: Alignment.center,
                            child: day(i.day, false));
                  } else {
                    if (d) {
                      // print(currentDay);
                      // print(data[currentDay]['all']);
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  opaque: false, // set to false
                                  pageBuilder: (_, __, ___) => Todo(
                                    currentDateId: currentDay,
                                    date: currentDate,
                                    isToday: true,
                                  ),
                                )).then((value) {
                              setState(() {});
                            });
                          },
                          child: data.containsKey(currentDay)
                              ? data[currentDay]['all']
                                  ? Stack(
                                      children: [
                                        Container(
                                            color: Colors.blueAccent,
                                            alignment: Alignment.center,
                                            child: day(i.day, true)),
                                        Positioned(
                                          top: 5,
                                          right: 5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.green),
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : Container(
                                      color: Colors.blueAccent,
                                      alignment: Alignment.center,
                                      child: day(i.day, true))
                              : Container(
                                  alignment: Alignment.center,
                                  color: Colors.blueAccent,
                                  child: day(i.day, true)));
                    }
                    return data.containsKey(currentDay)
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    opaque: false, // set to false
                                    pageBuilder: (_, __, ___) => Todo(
                                      currentDateId: currentDay,
                                      date: currentDate,
                                    ),
                                  ));
                            },
                            child: data[currentDay]['all']
                                ? Container(
                                    color: Colors.green,
                                    alignment: Alignment.center,
                                    child: day(i.day, true))
                                : Container(
                                    color: Colors.redAccent,
                                    alignment: Alignment.center,
                                    child: day(i.day, true)))
                        : Container(
                            alignment: Alignment.center,
                            child: day(i.day, true));
                  }
                  //  else if (d) {
                  //   return Container(
                  //       color: Colors.blueAccent,
                  //       alignment: Alignment.center,
                  //       child: day(i.day, true));
                  // }
                },

                thisMonthDayBorderColor: Colors.grey,
                height: size.height,
                childAspectRatio: 1,
                selectedDateTime: DateTime.now(),
                daysHaveCircularBorder: false,
              ),
            )),
      ),
    );
  }
}

Widget day(int date, bool thisMonth) {
  return Text(
    date.toString(),
    style: TextStyle(
        color: thisMonth ? Colors.white : Colors.white60,
        fontSize: 32,
        fontWeight: FontWeight.w200),
  );
}
