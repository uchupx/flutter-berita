import 'package:berita/clients/article.dart';
import 'package:berita/clients/news.dart';
import 'package:berita/components/appbar.dart';
import 'package:berita/components/bottom_navbar.dart';
import 'package:berita/screens/listpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:berita/components/card.dart';
import 'package:berita/components/headline.dart';
import 'package:berita/components/shimmer/headline.dart';
import 'package:berita/components/shimmer/list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/list': (context) => ListPage()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  bool isLoading = true;
  List<Article> _articles = List<Article>();
  List<Widget> _pages;
  String title = "Latest";

  PageController controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _setLoading(bool loading) {
    setState(() => isLoading = loading);
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      ListPage(),
      _mainBuild(),
    ];
    _setLoading(true);
    _getArticles().then((value) => _setLoading(false));
  }

  void onRefresh() {
    setState(() {
      isLoading = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index == 3) {
        print("awww");
      } else {
        controller.jumpToPage(index);
      }
    });
  }

  Future _getArticles() async {
    var tmp = await News.getHeadlines();
    var tmpArticles = List<Article>();

    tmp.article.forEach((i) {
      if (i.urlToImage != null &&
          i.content != null &&
          i.description != null &&
          i.title != null) {
        tmpArticles.add(i);
      }
    });
    _articles = tmpArticles;
  }

  Future _refreshData() async {
    _setLoading(true);
    await _getArticles();
    _setLoading(false);
    setState(() {});
  }

  Widget _shimmerLoading() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      children: [
        ShimmerHeadline(),
        Column(
          children: [
            ShimmerList(),
            ShimmerList(),
            ShimmerList(),
            ShimmerList()
          ],
        ),
      ],
    );
  }

  Widget _mainBuild() {
    return PageView(
      children: [
        RefreshIndicator(
            onRefresh: _refreshData,
            child: isLoading ? _shimmerLoading() : _dashboard()),
        ListPage(),
      ],
      controller: controller,
    );
  }

  Widget _dashboard() {
    var news = _articles.sublist(1);
    if (_articles.length > 0) {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          Headline(
            child: Text(_articles[0].title),
            article: _articles[0],
          ),
          Column(
            children: [
              for (var i in news)
                CustomCard(
                  article: i,
                )
            ],
          ),
        ],
      );
    } else {
      return _shimmerLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Latest'),
      body: Navigator(
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;

          switch (settings.name) {
            case '/':
              builder = (BuildContext context) => _mainBuild();
              break;
            case '/list':
              builder = (BuildContext context) => ListPage();
              break;
            default:
          }

          return MaterialPageRoute(
            builder: builder,
            settings: settings,
          );
        },
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
        // currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
