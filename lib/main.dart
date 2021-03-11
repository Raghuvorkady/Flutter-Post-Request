import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:post_request/user_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserModel _userModel;

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController jobController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
            ),
            TextField(
              controller: jobController,
            ),
            SizedBox(
              height: 32,
            ),
            _userModel == null ? Container() : Text("the user ${_userModel.name} is created successfully at time ${_userModel.createdAt.toIso8601String()}\n"
                "\n\t\t\tname: \t:\t ${_userModel.name}\n\n\t\t\tjob: \t:\t ${_userModel.job}\n\n\t\t\tid: \t:\t ${_userModel.id}\n\n\t\t\tcreatedAt: \t:\t ${_userModel.createdAt}\n"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final String name = nameController.text;
          final String jobTitle = jobController.text;

          final UserModel userModel = await createUser(name, jobTitle);

          setState(() {
            _userModel = userModel;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

Future<UserModel> createUser(String name, String jobTitle) async {
  final String apiUrl = "https://reqres.in/api/users";

  final response =
      await http.post(apiUrl, body: {"name": name, "job": jobTitle});

  if (response.statusCode == 201) {
    final String responseString = response.body;
    return userModelFromJson(responseString);
  } else
    return null;
}
