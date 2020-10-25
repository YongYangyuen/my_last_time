import 'package:flutter/material.dart';
import 'package:my_last_time/config/routes.dart';
import 'package:my_last_time/presentation/dash_screen.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

final myControllerTextEvent = TextEditingController();
final myControllerTextDay = TextEditingController();

class AddParameters {
  final String title;
  AddParameters(this.title);
}

class AddScreen extends StatefulWidget {
  final String title;
  AddScreen({this.title});
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  void initState() {
    super.initState();
  }

  DashScreen _myDashScreen = new DashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan[100],
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(children: [
                Container(
                  width: 80,
                  margin: new EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.topRight,
                  child: Text(
                    "I'll do",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  width: 280.0,
                  child: TextField(
                    controller: myControllerTextEvent,
                    decoration: InputDecoration(hintText: 'Enter event'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ]),
              Container(
                child: Text(
                  'every',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: TextField(
                    enabled: false,
                    controller: myControllerTextDay,
                    decoration: InputDecoration(hintText: 'Enter day amount'),
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
              Container(
                child: Text(
                  'day(s)',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                  child: NumericKeyboard(
                      onKeyboardTap: _onKeyboardTap,
                      textColor: Colors.black,
                      rightButtonFn: () {
                        setState(() {
                          myControllerTextDay.text = myControllerTextDay.text
                              .substring(
                                  0, myControllerTextDay.text.length - 1);
                        });
                      },
                      rightIcon: Icon(
                        Icons.backspace,
                        color: Colors.red,
                      ),
                      leftButtonFn: () {
                        print('left button clicked');
                        print(myControllerTextEvent.text);
                        print(myControllerTextDay.text);
                        _myDashScreen.updateData(myControllerTextEvent.text,
                            int.parse(myControllerTextDay.text));
                        Navigator.of(context).pushNamed(AppRoutes.pageDashEvent,
                            arguments: DashParameters("Dashboard"));
                        myControllerTextEvent.clear();
                        myControllerTextDay.clear();
                      },
                      leftIcon: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly)),
            ],
          ),
        ));
  }

  _onKeyboardTap(String value) {
    setState(() {
      myControllerTextDay.text = myControllerTextDay.text + value;
    });
  }
}
