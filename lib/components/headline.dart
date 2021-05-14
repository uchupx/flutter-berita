import 'package:berita/clients/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Headline extends StatelessWidget {
  @override
  Headline({Key key, this.child, this.article}) : super(key: key);

  final Widget child;
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 200,
            width: double.infinity,
            color: Colors.black45,
            child: child,
          )),
    );
  }
}
