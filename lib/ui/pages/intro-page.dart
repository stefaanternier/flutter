import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/ui/components/buttons/cust_flat_button.dart';
import 'package:youplay/ui/components/buttons/cust_raised_button.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

class IntroPage extends StatelessWidget {

  final Function() next;
  final String title ;
  final String subTitle;
  final String image;
  final double index ;
  final bool buttonAccent;

  const IntroPage({
    required this.next,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.index,
    this.buttonAccent = false,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

        appBar: AppBar(
            centerTitle: true,
            title: Hero(
              tag: 'redSquare',
              child: new Image(
                image: new AssetImage(AppConfig().appBarIcon!),
                height: 32.0,
                width: 32.0,
              ),
            ),
        ),
        drawer: ARLearnNavigationDrawerContainer(),
        body: WebWrapper(
            child: Center(
          child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                  child: Text(
                    title.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  subTitle,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: TextStyle(
                    color: const Color(0xFFA0ABB5),
                    fontSize: 20.0,
                  ),
                ),
                new Image(
                  image: new AssetImage('graphics/intro/$image.png'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                  child: buttonAccent?
                      CustomRaisedButton(
                          primaryColor: const Color(0xFF632273),
                          onPressed: this.next,
                          title: "ik ben er klaar voor".toUpperCase())
                      : CustomFlatButton(
                    title: 'Volgende'.toUpperCase(),
                    colorBorder: const Color(0xFFD2DAE2),
                    color: Colors.black,
                    backgroundColor: Colors.white,
                    onPressed: this.next,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 22),
                  child: new DotsIndicator(
                    dotsCount: 3,
                    position: index,
                    decorator: DotsDecorator(
                      color: colorFromHex('#D2DAE2'), //
                      activeColor: colorFromHex('#A0ABB5'), //#D2DAE2
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Color colorFromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
