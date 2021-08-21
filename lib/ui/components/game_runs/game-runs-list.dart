import 'package:flutter/material.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/ui/components/game_runs/run_list_entry.dart';

class GameRunList extends StatelessWidget {

  List<Run> runList;
  Function(int) tapRun;

  GameRunList({
    required this.runList,
    required this.tapRun,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List<Column>.generate(
          runList.length,
              (index) => Column(
            children: [
              Divider(),
              RunListEntry(
                  title:
                  "${(runList[index]).title}",
                  lastModificationDate: runList[index].lastModificationDate,
                  onTap: () {
                    tapRun(index);
                  }
              ),
            ],
          ),
        ))    ;
  }
}
