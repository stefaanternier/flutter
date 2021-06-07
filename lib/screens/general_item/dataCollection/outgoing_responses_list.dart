
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/state/app_state.dart';

class OutGoingResponses extends StatelessWidget {
  final Store<AppState> store;

  OutGoingResponses(this.store);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
        store: store,
        child: new StoreConnector<AppState, dynamic>(
            converter: (store) => {
              "keys":currentRunResponsesSelector(store.state),
//              "runstate": currentRunStateSelector(store.state)
            },
            builder: (context, map) {
              return new Scaffold(
                appBar: AppBar(
                  title: Text("Outgoing Responses"),
                ),
                floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.file_upload),
                    onPressed: () {
                      print("about to upload files");
//                      store.dispatch(new SyncFileResponse(runId: map["runstate"].run.runId));
                    }),
                body: Center(
                  child:  ListView.builder(
                        padding: EdgeInsets.all(8.0),
                        itemExtent: 20.0,
                        itemCount: map["keys"].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                              'entry $index ${map["keys"][index].userId} ${map["keys"][index].toString()}');
                        },
                      ),
                ),
              );
            }));
  }
}
