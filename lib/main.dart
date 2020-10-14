import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_last_time/data/all_data.dart';
import 'package:my_last_time/presentation/add_screen.dart';
import 'package:my_last_time/presentation/dash_screen.dart';
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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => DataCubit(),
        child: MaterialApp(
          title: 'Last Time',
          onGenerateRoute: _registerRouteWithParameters,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
            // This makes the visual density adapt to the platform that you run
            // the app on. For desktop platforms, the controls will be smaller and
            // closer together (more dense) than on mobile platforms.
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage(title: 'Last Time'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum SingingCharacter { male, female }

class _MyHomePageState extends State<MyHomePage> {
  SingingCharacter _character = SingingCharacter.male;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.blue[400]),
              height: MediaQuery.of(context).size.height - 815,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Last Time',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 700,
              child: Image(image: AssetImage('assets/clock.png')),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 890,
              child: Text(''),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 850,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'First Name',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 850,
              child: TextField(
                controller: firstName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 850,
              child: Text(''),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 850,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Last Name',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 850,
              child: TextField(
                  controller: lastName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20)),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 850,
              child: Text(''),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 850,
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
                onPressed: () => {
                  context.bloc<DataCubit>().addData(
                      PersonalData(firstName.text, lastName.text, gender)),
                  print(firstName),
                  print(lastName),
                  print(gender),
                  Navigator.of(context).pushNamed(AppRoutes.pageDashEvent,
                      arguments: DashParameters("Dashboard")),
                },
                color: Colors.blue,
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
}
