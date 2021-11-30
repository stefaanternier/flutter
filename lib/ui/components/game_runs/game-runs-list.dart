import 'package:flutter/material.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/ui/components/game_runs/run_list_entry.dart';

class GameRunList extends StatelessWidget {
  List<Run> runList;
  Function(int) tapRun;
  final Function(Run) deleteRun;

  GameRunList({required this.runList,
    required this.deleteRun,
    required this.tapRun, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List<Column>.generate(
      runList.length,
      (index) => Column(
        children: [
          Divider(),
          RunListEntry(
              title: "${(runList[index]).title}",
              run: runList[index],
              deleteRun: deleteRun,
              lastModificationDate: runList[index].lastModificationDate,
              onTap: () {
                tapRun(index);
              }),
        ],
      ),
    ));
  }
}
