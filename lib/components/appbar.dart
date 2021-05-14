import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;

  CustomAppBar(
    this.title, {
    Key key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          new Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.menu),
            ),
          ),
          new Expanded(
            flex: 8,
            child: Center(
              child: Text(
                title,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          new Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.notifications),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: true,
      elevation: 0,
    );
  }
}
