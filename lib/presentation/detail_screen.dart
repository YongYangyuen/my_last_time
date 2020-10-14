import 'package:flutter/material.dart';
import 'package:my_last_time/config/routes.dart';
import 'add_screen.dart';
import 'dash_screen.dart';


bool isEdit = false;
int editIndex;

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
              'every ' + days[widget.index].toString() + ' day(s)',
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
                    myControllerTextDay.text = days[widget.index],
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
      ]),
    );
  }
}
