import 'package:flutter/material.dart';

void main() {
  runApp(TestApp());
}

class TestApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test 1',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = "";

  void changeText(String text) {
    this.setState(() {
      this.text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold widget can contain other widgets
    return Scaffold(
        //In questo caso Scaffold contiene il Widget AppBar che a sua volta contiene il Widget Text
        appBar: AppBar(
          title: Text("Hello Bro!"),
        ),
        body: Column(children: <Widget>[
          TextBoxWidget(
              this.changeText /*reference to a function, not executing*/),
          Text(this.text)
        ]));
  }
}

class TextBoxWidget extends StatefulWidget {
  final Function(String) callback;

  TextBoxWidget(this.callback); //{}lo rendono un parametro opzionale

  @override
  _TextBoxWidgetState createState() => _TextBoxWidgetState();
}

class _TextBoxWidgetState extends State<TextBoxWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose(); //dispose comes form State
    controller.dispose();
  }

  void click() {
    widget.callback(controller.text);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.messenger_rounded),
          labelText: "Type something:",
          suffixIcon: IconButton(
            icon: Icon(Icons.send_rounded),
            splashColor: Colors.blueGrey,
            tooltip: "Post Message",
            onPressed: this.click,
          )),
    );
  }
}
