import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youplay/models/organisation.dart';
import 'package:youplay/store/actions/actions.organisations.dart';
import 'package:youplay/store/services/organisation.api.dart';
import 'package:youplay/store/state/app_state.dart';
import 'epics.generalitems.dart';

final organisationEpics = combineEpics<AppState>([
  TypedEpic<AppState, dynamic>(_getOrganisationEpic),
]);
//
Stream<dynamic> _getOrganisationEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return resetOnError(
      actions,
      actions
          .whereType<LoadOrganisationRequest>()
          .where((action) {
            print(' before load organisation ');
            return true;
          })
          .distinctUnique()
          .where((action) {
        print(' after load organisation ');
        return true;
      })
          .flatMap((LoadOrganisationRequest action) => OrgAPI.instance.getOrganisation(action.organisationId))
          .map((Organisation organisation) => LoadOrganisationSuccess(organisation: organisation)));
}
