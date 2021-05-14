import 'package:berita/clients/article.dart';
import 'package:berita/clients/news.dart';
import 'package:berita/components/appbar.dart';
import 'package:berita/components/card.dart';
import 'package:berita/components/headline.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  int _counter = 0;
  int _selectedIndex = 0;
  Future<ResponseNews> futureHeadlines;
  Article topNews;

  List<Article> latestNews;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  @override
  void initState() {
    super.initState();
    futureHeadlines = News.getHeadlines();
    futureHeadlines
        .then((value) => {print("asdasd"), topNews = value.article[0]});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Latest'),
      body: Container(
        color: Colors.white38,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              FutureBuilder<ResponseNews>(
                future: futureHeadlines,
                builder: (context, res) {
                  if (res.hasData) {
                    return Headline(
                      child: Text(res.data.article[0].title),
                      article: res.data.article[0],
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              FutureBuilder<ResponseNews>(
                  future: futureHeadlines,
                  builder: (context, res) {
                    if (res.hasData) {
                      var news = res.data.article.sublist(1);
                      return Column(children: [
                        for (var i in news) CustomCard(article: i)
                      ]);
                    }
                    return CircularProgressIndicator();
                  })
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'News',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorite',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
