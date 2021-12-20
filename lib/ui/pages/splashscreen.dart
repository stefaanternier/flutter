import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';

class SplashScreen extends StatelessWidget {
  final Function() onTap;
  const SplashScreen({ required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            toolbarHeight: MediaQuery.of(context).size.height,
            title: Hero(
              tag: 'redSquare',
              child: new Image(
                image: new AssetImage(AppConfig().appBarIcon!),
                height: 152.0,
                width: 152.0,

              ),
            )),
        body: Container(),
      ),
    );


        return Container(
        decoration: BoxDecoration(color: AppConfig().themeData!.primaryColor),
      child: Stack(
          alignment: const Alignment(0, 0),
          children: [
            // Text("test")
            Hero(
              tag: 'logo',
              child: new Image(
                image: new AssetImage(AppConfig().appBarIcon!),
                height: 32.0,
                width: 32.0,
              ),
            )
          ])
    );
  }
}
