import 'package:berita/clients/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;

class CustomCard extends StatefulWidget {
  final Article article;
  CustomCard({Key key, this.article}) : super(key: key);

  @override
  _CustomCard createState() => _CustomCard();
}

class _CustomCard extends State<CustomCard> {
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
    return Container(
      height: 130,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
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
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      article.title != null ? article.title : "No title",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        article.description != null
                            ? article.description
                            : article.content != null
                                ? article.content
                                : ("No content"),
                        // "asdasd",
                        softWrap: true,
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          timeago.format(articlePosted, locale: 'en_short'),
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 13),
                        ),
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.bookmark,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.done_rounded,
                        size: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
