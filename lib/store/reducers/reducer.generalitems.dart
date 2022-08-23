import 'package:redux/redux.dart';
import 'package:youplay/store/actions/actions.generalitems.dart';
import 'package:youplay/store/state/state.generalitems.dart';

final generalItemsReducer = combineReducers<GeneralItemsState>([
  TypedReducer<GeneralItemsState, LoadMessageListSuccess>((GeneralItemsState state, LoadMessageListSuccess action) => state.copyWithItems(action.itemsList.items)),
]);
