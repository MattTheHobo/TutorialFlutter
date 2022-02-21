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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Scaffold widget can contain other widgets
    return Scaffold(
        //In questo caso Scaffold contiene il Widget AppBar che a sua volta contiene il Widget Text
        appBar: AppBar(
          title: Text("Hello Bro!"),
        ),
        body: TextBoxWidget());
  }
}

class TextBoxWidget extends StatefulWidget {
  @override
  _TextBoxWidgetState createState() => _TextBoxWidgetState();
}

class _TextBoxWidgetState extends State<TextBoxWidget> {
  final controller = TextEditingController();
  String text = "";

  @override
  void dispose() {
    super.dispose(); //dispose comes form State
    controller.dispose();
  }

  void changeText(text) {
    if (text == "Clear") { //If the user write Clear, the TextField gets cleared
      controller.clear();
      text = "";
    }

    setState(() {
      //Force refresh the flutter widget
      this.text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextField(
        controller: this.controller,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.messenger_rounded),
            labelText: "Type something:"),
        onChanged: (text) => this.changeText(text),
      ),
      Text(this.text)
    ]);
  }
}

