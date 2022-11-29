import 'package:youplay/store/actions/actions.organisations.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:redux/redux.dart';

class Organisation {

  final String id;
  final String name;

  const Organisation({required this.id, required this.name});

  Organisation.fromJson(Map json)
      : id = json['id'],
        name = json['name'];

  dynamic toJson() {
    return {
      'id': this.id,
      'name': this.name
    };
  }

  static loadOne({required id, Store<AppState>? store}) {
    if (store == null) {
      return LoadOrganisationRequest(organisationId: id);
    }
    store.dispatch(LoadOrganisationRequest(organisationId: id));
  }
}