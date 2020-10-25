import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_last_time/config/routes.dart';
import 'add_screen.dart';
import 'dash_screen.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

bool isEdit = false;
int editIndex;
CountDownController _controller = CountDownController();
bool _isPause = false;

class DetailParameters {
  final int index;
  const DetailParameters(this.index);
}

class DetailScreen extends StatefulWidget {
  final int index;
  DetailScreen({this.index});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  DashScreen _myDashScreen = new DashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Event - " + events[widget.index]),
      ),
      body: Column(children: [
        Stack(children: [
          Container(
            alignment: Alignment.center,
            height: 200,
            decoration: BoxDecoration(color: Colors.blue, border: Border.all()),
            child: ListTile(
              leading:
                  Text(events[widget.index], style: TextStyle(fontSize: 30)),
              title: Text(
                '',
                style: TextStyle(fontSize: 30),
              ),
              trailing: Text(
                '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Container(
            height: 170,
            width: MediaQuery.of(context).size.width - 20,
            alignment: Alignment.bottomRight,
            child: Text(
              'every ' + daysForShow[widget.index].toString() + ' day(s)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
                alignment: Alignment.topRight,
                child: MaterialButton(
                  onPressed: () => {
                    isEdit = true,
                    editIndex = widget.index,
                    myControllerTextEvent.text = events[widget.index],
                    myControllerTextDay.text =
                        daysForShow[widget.index].toString(),
                    Navigator.of(context).pushNamed(AppRoutes.pageAddEvent,
                        arguments: AddParameters("Edit Event")),
                  },
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.edit,
                    size: 24,
                  ),
                  padding: EdgeInsets.all(16),
                  shape: CircleBorder(),
                )),
          ),
        ]),
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          alignment: Alignment.center,
          child: Text(
            'Remaining Time',
            style: TextStyle(fontSize: 30),
          ),
        ),
        Container(
            decoration: BoxDecoration(color: Colors.black),
            height: MediaQuery.of(context).size.height * 0.25,
            alignment: Alignment.center,
            child: CircularCountDownTimer(
              // Countdown duration in Seconds
              duration: 3,

              // Controller to control (i.e Pause, Resume, Restart) the Countdown
              controller: _controller,

              // Width of the Countdown Widget
              width: MediaQuery.of(context).size.width / 2,

              // Height of the Countdown Widget
              height: MediaQuery.of(context).size.height / 2,

              // Default Color for Countdown Timer
              color: Colors.white,

              // Filling Color for Countdown Timer
              fillColor: Colors.red,

              // Background Color for Countdown Widget
              backgroundColor: null,

              // Border Thickness of the Countdown Circle
              strokeWidth: 5.0,

              // Text Style for Countdown Text
              textStyle: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),

              // true for reverse countdown (max to 0), false for forward countdown (0 to max)
              isReverse: true,

              // true for reverse animation, false for forward animation
              isReverseAnimation: true,

              // Optional [bool] to hide the [Text] in this widget.
              isTimerTextShown: true,

              // Function which will execute when the Countdown Ends
              onComplete: () {
                // Here, do whatever you want
                print('Countdown Ended');
                timesUp[widget.index] = true;
                setState(() {});
              },
            )),
        Stack(children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
                alignment: Alignment.topLeft,
                child: MaterialButton(
                  onPressed: () => {
                    setState(() {
                      if (_isPause) {
                        _isPause = false;
                        _controller.resume();
                      } else {
                        _isPause = true;
                        _controller.pause();
                      }
                    })
                  },
                  color: _isPause ? Colors.orange : Colors.red,
                  textColor: Colors.white,
                  child: Icon(
                    _isPause ? Icons.play_arrow : Icons.pause,
                    size: 40,
                  ),
                  padding: EdgeInsets.all(16),
                  shape: CircleBorder(),
                )),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
                alignment: Alignment.topRight,
                child: MaterialButton(
                  onPressed: () => {
                    showAlertDialog(context),
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.skip_next,
                    size: 40,
                  ),
                  padding: EdgeInsets.all(16),
                  shape: CircleBorder(),
                )),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
                alignment: Alignment.center,
                child: MaterialButton(
                  onPressed: () => {
                    showAlertDialog2(context),
                  },
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.done,
                    size: 40,
                  ),
                  padding: EdgeInsets.all(16),
                  shape: CircleBorder(),
                )),
          ),
        ]),
        Stack(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(25.0, 8.0, 0, 0),
            child: Container(
                alignment: Alignment.topLeft,
                child: Text(_isPause ? "RESUME" : "PAUSE",
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 8.0, 30.0, 0),
            child: Container(
                alignment: Alignment.topRight,
                child: Text('SKIP',
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
                alignment: Alignment.center,
                child: Text('DONE',
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ),
        ]),
        Visibility(
          visible: timesUp[widget.index],
          child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.orange),
              child: Text('It\'s time to do this event now.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
        ),
      ]),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("NO"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("YES"),
      onPressed: () {
        setState(() {
          _controller.restart();
          _isPause = false;
          _controller.resume();
          timesUp[widget.index] = false;
        });
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Caution"),
      content: Text('''Do you want to skip this round?
The time will be reseted.'''),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog2(BuildContext context) {
    // set up the buttons
    Widget continueButton2 = FlatButton(
      child: Text("OK"),
      onPressed: () {
        setState(() {
          _controller.restart();
          _isPause = false;
          _controller.resume();
          timesUp[widget.index] = false;
        });
        Navigator.pop(context);
      },
    );
    AlertDialog alert2 = AlertDialog(
      title: Text("Congratulations !!!"),
      content: Text('''You've just finished this event.
The time will be reseted for next round.'''),
      actions: [
        continueButton2,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert2;
      },
    );
  }
}
