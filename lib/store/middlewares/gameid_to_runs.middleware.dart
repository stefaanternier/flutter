


// final deleteRunEpic = new TypedEpic<AppState, DeleteRunAction>(_deleteRunEpic); //dispatched from take picture
//
// Stream<dynamic> _deleteRunEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
//   return actions
//       .where((action) => action is DeleteRunAction)
//       .asyncMap(((action) async {
//     await RunsApi.deletePlayerFromRun(action.run.runId);
//     await Future.delayed(const Duration(seconds: 2), (){});
//     return  ApiRunsParticipateAction(action.run.gameId);
//   }));
// }
