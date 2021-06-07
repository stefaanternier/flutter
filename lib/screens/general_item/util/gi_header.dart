import 'package:flutter/material.dart';

class GeneralItemAppBar extends SliverAppBar {
  GeneralItemAppBar(String title)
      : super(
            expandedHeight: 110.0,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("$title",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 16.0,
                  )),
              background: new DecoratedBox(
                  decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: new AssetImage('graphics/gameMessagesHeader.png'),
                ),
                shape: BoxShape.rectangle,
              )),
            ));
}
