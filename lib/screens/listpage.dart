import 'package:berita/clients/article.dart';
import 'package:berita/clients/news.dart';
import 'package:berita/components/card.dart';
import 'package:berita/components/shimmer/list.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _listPage createState() => _listPage();
}

class _listPage extends State<ListPage> {
  bool isLoading = true;
  List<Article> _articles = List<Article>();
  void _setLoading(bool loading) {
    setState(() => isLoading = loading);
  }

  @override
  void initState() {
    super.initState();
    _setLoading(true);
    _getArticles().then((value) => _setLoading(false));
  }

  void onRefresh() {
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _doGetArticles() async {
    await _getArticles();
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

  @override
  Widget _shimmerLoading() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      children: [
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

  Widget _list() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      children: [
        Column(
          children: [
            for (var i in _articles)
              CustomCard(
                article: i,
              )
          ],
        )
      ],
    );
  }

  Widget _mainBuild() {
    return RefreshIndicator(
        onRefresh: _refreshData,
        child: isLoading ? _shimmerLoading() : _list());
  }

  Widget build(BuildContext context) {
    return _mainBuild();
  }
}
