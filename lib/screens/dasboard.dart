import 'package:berita/clients/article.dart';
import 'package:berita/clients/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:berita/components/card.dart';
import 'package:berita/components/headline.dart';
import 'package:berita/components/shimmer/headline.dart';
import 'package:berita/components/shimmer/list.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.articles, this.isLoading}) : super(key: key);
  List<Article> articles;
  bool isLoading;

  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  int _selectedIndex = 0;
  List<Article> articles;
  bool isLoading;
  void _setHeadlineIndexIncr() {
    setState(() {
      _selectedIndex++;
    });
  }

  @override
  void initState() {
    super.initState();
    var tmp = widget.articles;
    isLoading = widget.isLoading;

    tmp.forEach((article) {
      if (article.description != null &&
          article.title != null &&
          article.content != null &&
          article.urlToImage != null) {
        articles.add(article);
      }
    });
  }

  Widget _build() {
    print(isLoading);
    if (isLoading) {
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
    } else {
      var news = articles.sublist(_selectedIndex + 1);

      return ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          Headline(
            child: Text(articles[_selectedIndex].title),
            article: articles[_selectedIndex],
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white38,
      child: _build(),
    );
  }
}
