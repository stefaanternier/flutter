import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class ImageCacheRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image cache Route'),
      ),
      body: Center(
        child:Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            RaisedButton(
              child: Text('Go back!'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),



      ),
    );
  }
}
