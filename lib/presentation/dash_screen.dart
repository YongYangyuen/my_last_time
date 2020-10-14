import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_last_time/config/routes.dart';
import 'package:my_last_time/data/all_data.dart';
import 'package:my_last_time/main.dart';
import 'add_screen.dart';
import 'detail_screen.dart';

List events = ['Run at staduim', 'Sweep the floor', 'Mop the floor'];
List days = [3, 7, 7];
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

  void updateData(String name, int score) {
    if (isEdit) {
      events[editIndex] = name;
      days[editIndex] = score;
    } else {
      events.add(name);
      days.add(score);
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
            BlocBuilder<DataCubit, List>(builder: (context, state) {
              return Text(
                ' - Hi ' + gender + ' ' + firstName.text + ' ' + lastName.text,
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
                ListTile(
                  onTap: () => {
                    isEdit = false,
                    Navigator.of(context).pushNamed(AppRoutes.pageDetailEvent,
                        arguments: DetailParameters(index)),
                  },
                  leading: Text(
                    events[index],
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  title: Text(
                    '',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  trailing: Text(
                    'every ' + days[index].toString() + ' day(s)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Divider(), //                           <-- Divider
              ],
            );
          },
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          isEdit = false,
          Navigator.of(context).pushNamed(AppRoutes.pageAddEvent,
              arguments: AddParameters("Add Event")),
          myControllerTextEvent.clear(),
          myControllerTextDay.clear(),
        },
        tooltip: 'Add Event',
        child: Icon(Icons.add),
      ),
    );
  }
}
