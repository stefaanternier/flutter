import 'package:redux/redux.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/state/app_state.dart';




class CombinationLockViewModel {
  bool correctAnswerGiven;

  CombinationLockViewModel({required this.correctAnswerGiven,
      });

  static CombinationLockViewModel fromStore(Store<AppState> store) {

    return new CombinationLockViewModel(
        correctAnswerGiven: correctAnswerGivenSelector(store.state),
    );
  }
}
