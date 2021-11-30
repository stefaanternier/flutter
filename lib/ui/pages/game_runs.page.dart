import 'package:flutter/material.dart';
import 'package:youplay/ui/components/appbar/game-title-themed-app-bar.container.dart';
import 'package:youplay/ui/components/game_runs/game-runs-header.dart';
import 'package:youplay/ui/components/game_runs/game-runs-list.container.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

class GameRunsPage extends StatefulWidget {
  final Function init;

  const GameRunsPage({required this.init, Key? key}) : super(key: key);

  @override
  _GameRunsPageState createState() => _GameRunsPageState();
}

class _GameRunsPageState extends State<GameRunsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: ARLearnNavigationDrawerContainer(),
        appBar: GameTitleThemedAppbarContainer(elevation: true),
        body: WebWrapper(
            child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GameRunsHeader(),
          GameRunsListContainer(),
          Divider(),
        ]))));
  }

  @override
  void initState() {
    widget.init();
  }
}
