import 'package:berita/clients/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;

class Headline extends StatefulWidget {
  @override
  Headline({Key key, this.child, this.article}) : super(key: key);

  final Widget child;
  final Article article;
  _Headline createState() => _Headline();
}

class _Headline extends State<Headline> {
  final timeNow = DateTime.now();
  var article;
  DateTime articlePosted;
  @override
  void initState() {
    super.initState();
    article = widget.article;
    var tmpDate = DateTime.parse(widget.article.publishedAt);
    var dur = tmpDate.difference(timeNow);
    articlePosted = tmpDate.subtract(dur);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
            Text(
              article.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: article.urlToImage == null
                        ? AssetImage('assets/images/no-image-post.png')
                        : NetworkImage(article.urlToImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              article.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              timeago.format(articlePosted, locale: 'en_short'),
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
            ),
          ],
        ));
  }
}
