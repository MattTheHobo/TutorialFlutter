import 'package:flutter/material.dart';

void main() {
  runApp(TestApp());
}

class Post {
  String body;
  String author;
  int likes = 0;
  bool userLiked = false;

  Post(this.body, this.author);

  void likePost() {
    this.userLiked = !this.userLiked;
    if (this.userLiked) {
      this.likes += 1;
    } else {
      this.likes -= 1;
    }
  }
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
  List<Post> posts = [];

  void newPost(String text) {
    this.setState(() {
      posts.add(new Post(text, "Matt"));
    });
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold widget can contain other widgets
    return Scaffold(
        //In questo caso Scaffold contiene il Widget AppBar che a sua volta contiene il Widget Text
        appBar: AppBar(
          title: Text("Hello"),
        ),
        body: Column(children: <Widget>[
          Expanded(
              child:
                  PostList(this.posts)), //Expanded uses all the space possible
          Expanded(
              child: TextBoxWidget(
                  this.newPost /*reference to a function, not executing*/))
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

class PostList extends StatefulWidget {
  final List<Post> listItems;

  PostList(this.listItems);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.listItems.length,
      itemBuilder: (context, index) {
        var post = this.widget.listItems[index];
      },
    );
  }
}
