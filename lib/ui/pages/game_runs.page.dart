import 'package:flutter/material.dart';
import 'package:youplay/ui/components/appbar/game-title-themed-app-bar.container.dart';
import 'package:youplay/ui/components/game_runs/game-runs-header.dart';
import 'package:youplay/ui/components/game_runs/game-runs-list.container.dart';
import 'package:youplay/ui/components/game_runs/new_run.button.container.dart';
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              Expanded(flex: 0, child: GameRunsHeader()),
              Expanded(flex: 1, child: SingleChildScrollView(child: GameRunsListContainer())),
              Expanded(flex: 0, child: NewRunButtonContainer())
            ])));
  }

  @override
  void initState() {
    widget.init();
  }
}
