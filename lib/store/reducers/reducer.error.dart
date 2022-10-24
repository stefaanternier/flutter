import 'package:redux/redux.dart';
import 'package:youplay/store/actions/actions.error.dart';
import 'package:youplay/store/state/state.error.dart';


final errorReducer = combineReducers<ErrorState>([
  TypedReducer<ErrorState, ErrorOccurredAction>((ErrorState state, ErrorOccurredAction action) {
    print('reduce error occured ${action.exception}');
    return  state.copyWith(e: action.exception);
  }),
  TypedReducer<ErrorState, ErrorHandledAction>((ErrorState state, ErrorHandledAction action) => ErrorState()),
]);