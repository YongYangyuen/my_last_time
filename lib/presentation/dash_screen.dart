import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_last_time/config/routes.dart';
import 'package:my_last_time/data/all_data.dart';
import 'package:my_last_time/main.dart';
import 'add_screen.dart';
import 'detail_screen.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'detail_screen.dart';

List events = [];
int endTime1Day = 60 * 60 * 24; // 1 day
List days = [];
List daysForShow = [];
List timesUp = [];

TextEditingController event = TextEditingController();
TextEditingController day = TextEditingController();

class DashParameters {
  final String title;
  const DashParameters(this.title);
}

class DashScreen extends StatefulWidget {
  DashScreen({
    Key key,
    this.title,
    int index,
  }) : super(key: key);

  void updateData(String event, int day) {
    if (isEdit) {
      events[editIndex] = event;
      days[editIndex] = endTime1Day * day;
      daysForShow[editIndex] = day;
      timesUp[editIndex] = false;
    } else {
      events.add(event);
      days.add(endTime1Day * day);
      daysForShow.add(day);
      timesUp.add(false);
    }
    isEdit = false;
  }

  final String title;

  @override
  _DashScreenState createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Row(
            children: <Widget>[
              Text(widget.title),
              BlocBuilder<DataCubit, String>(builder: (context, state) {
                return Text(
                  ' - Hi ' + '$state',
                  style: Theme.of(context).textTheme.headline6,
                );
              }),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Container(
              child: ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Visibility(
                    visible: timesUp[index],
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            "Today",
                            style: TextStyle(
                              fontSize: 48.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Card(
                      color: timesUp[index] ? Colors.orange : Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListTile(
                          onTap: () => {
                                isEdit = false,
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.pageDetailEvent,
                                        arguments: DetailParameters(index))
                                    .then((data) => {this.setState(() {})}),
                              },
                          leading: Icon(
                            Icons.event,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          title: Text(
                            events[index],
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'every ' +
                                daysForShow[index].toString() +
                                ' day(s)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          trailing: timesUp[index]
                              ? Icon(
                                  Icons.warning,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                )),
                    ),
                  ),
                  Divider(), //                           <-- Divider
                ],
              );
            },
          )),
        ),
        floatingActionButton: SizedBox(
          height: 50,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: Colors.blue)),
            color: Colors.blue,
            splashColor: Colors.blue,
            textTheme: ButtonTextTheme.accent,
            textColor: Colors.white,
            onPressed: () => {
              isEdit = false,
              Navigator.of(context).pushNamed(AppRoutes.pageAddEvent,
                  arguments: AddParameters("Add Event")),
              myControllerTextEvent.clear(),
              myControllerTextDay.clear(),
            },
            child: Text(
              'Add Event',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
        ));
  }
}
