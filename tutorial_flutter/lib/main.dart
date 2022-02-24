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
          TextBoxWidget(
              this.newPost /*reference to a function, not executing*/),
          SizedBox(height: 30) //Custom spacer
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
    FocusScope.of(context).unfocus();
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
  void like(Function callback) {
    this.setState(() {
      callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.listItems.length,
      itemBuilder: (context, index) {
        var post = this.widget.listItems[index];
        return Card(
            child: Row(children: <Widget>[
          Expanded(
              child: ListTile(
                  title: Text(post.body), subtitle: Text(post.author))),
          Row(
            children: <Widget>[
              Container(
                child:
                    Text(post.likes.toString(), style: TextStyle(fontSize: 20)),
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              ),
              IconButton(
                icon: Icon(Icons.thumb_up_alt),
                onPressed: () => this.like(post.likePost),
                color: post.userLiked
                    ? Colors.blue
                    : Colors.black, //? = if true, : = else
              )
            ],
          )
        ]));
      },
    );
  }
}
