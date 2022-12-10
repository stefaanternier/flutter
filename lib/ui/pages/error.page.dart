import 'package:flutter/material.dart';
import 'package:youplay/ui/components/buttons/cust_raised_button.container.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';

class ErrorPage extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const ErrorPage({required this.text, required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ARLearnNavigationDrawerContainer(),
      appBar: new AppBar(centerTitle: true, title: new Text('Fout', style: new TextStyle(color: Colors.white))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: new Icon(
              Icons.warning,
              color: const Color(0xFFA0ABB5),
              size: 150,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFA0ABB5),
                    fontSize: 20.0,
                  )),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: CustomRaisedButtonContainer(
              onPressed: onPressed,
              title: 'Terug naar home',
            ),
          ))
        ],
      ),
    );
  }
}
