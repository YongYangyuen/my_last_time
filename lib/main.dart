import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_last_time/data/all_data.dart';
import 'package:my_last_time/presentation/add_screen.dart';
import 'package:my_last_time/presentation/dash_screen.dart';
import 'package:my_last_time/presentation/detail_screen.dart';
import 'config/routes.dart';
import 'data_observer.dart';

TextEditingController firstName = TextEditingController();
TextEditingController lastName = TextEditingController();
String gender = 'Mr.';
void main() {
  Bloc.observer = DataObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => DataCubit(),
        child: MaterialApp(
          title: 'Last Time',
          onGenerateRoute: _registerRouteWithParameters,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage(title: 'Last Time'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum SingingCharacter { male, female }

class _MyHomePageState extends State<MyHomePage> {
  SingingCharacter _character = SingingCharacter.male;
  final _formKeyFirst = GlobalKey<FormState>();
  final _formKeyLast = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.blue[400]),
              height: MediaQuery.of(context).size.height * 0.095,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Last Time',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image(image: AssetImage('assets/clock.png')),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.01,
              child: Text(''),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'First Name',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formKeyFirst,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                child: TextFormField(
                  validator: (firstName) {
                    if (firstName.isEmpty) {
                      return '* Please enter your first name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  controller: firstName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.02,
              child: Text(''),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Last Name',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formKeyLast,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                child: TextFormField(
                    validator: (lastName) {
                      if (lastName.isEmpty) {
                        return '* Please enter your last name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    controller: lastName,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20)),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.02,
              child: Text(''),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Gender',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: RadioListTile<SingingCharacter>(
                title: const Text('Male', style: TextStyle(fontSize: 20)),
                value: SingingCharacter.male,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                    gender = 'Mr.';
                  });
                },
              ),
            ),
            Container(
              child: RadioListTile<SingingCharacter>(
                title: const Text('Female', style: TextStyle(fontSize: 20)),
                value: SingingCharacter.female,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                    gender = 'Ms.';
                  });
                },
              ),
            ),
            Container(
              height: 50,
              width: 120,
              child: RaisedButton(
                color: Colors.blue,
                elevation: 5,
                onPressed: () => {
                  if (_formKeyFirst.currentState.validate() &&
                      _formKeyLast.currentState.validate())
                    {
                      context.bloc<DataCubit>().addData(
                          PersonalData(firstName.text, lastName.text, gender)),
                      print(firstName),
                      print(lastName),
                      print(gender),
                      Navigator.of(context).pushNamed(AppRoutes.pageDashEvent,
                          arguments: DashParameters("Dashboard")),
                      showAlertDialog3(context),
                    },
                },
                child: Text(
                  'GO',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  showAlertDialog3(BuildContext context) {
    // set up the buttons
    Widget continueButton3 = FlatButton(
      child: Text("OK"),
      onPressed: () {
        setState(() {});
        Navigator.pop(context);
      },
    );
    AlertDialog alert3 = AlertDialog(
      title: Text("First step"),
      content: Text('''You need to press Add button for adding your event.'''),
      actions: [
        continueButton3,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert3;
      },
    );
  }
}

// ignore: missing_return
Route _registerRouteWithParameters(RouteSettings settings) {
  if (settings.name == AppRoutes.pageDashEvent) {
    return MaterialPageRoute(builder: (context) {
      DashParameters parameter = settings.arguments;
      return DashScreen(title: parameter.title);
    });
  }
  if (settings.name == AppRoutes.pageAddEvent) {
    return MaterialPageRoute(builder: (context) {
      AddParameters parameter = settings.arguments;
      return AddScreen(title: parameter.title);
    });
  }
  if (settings.name == AppRoutes.pageDetailEvent) {
    return MaterialPageRoute(builder: (context) {
      DetailParameters parameter = settings.arguments;
      return DetailScreen(index: parameter.index);
    });
  }
}
