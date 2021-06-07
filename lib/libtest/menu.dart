import 'package:flutter/material.dart';
import 'package:youplay/libtest/camera.dart';
import 'package:youplay/libtest/sign_in.dart';
import 'package:youplay/libtest/video.dart';

import 'googlemap.dart';
import 'image_cache.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Open Image'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImageCacheRoute()),
                  );
                },
              ),
              RaisedButton(
                child: Text('Sign in '),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GoogleSignInScreen()),
                  );
                },
              ),
              RaisedButton(
                child: Text('Video'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoRoute()),
                  );
                },
              ),
              RaisedButton(
                child: Text('Google Map'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GoogleMapRoute()),
                  );
                },
              ),
              RaisedButton(
                child: Text('camera'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraRoute()),
                  );
                },
              ),

            ]),
      ),
    );
  }
}
