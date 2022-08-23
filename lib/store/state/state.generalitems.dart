import 'dart:collection';

import 'package:youplay/models/general_item.dart';

class GeneralItemsState {
  final Set<String> ids;
  final HashMap<String, GeneralItem> entities;

  const GeneralItemsState({required this.ids, required this.entities});

  static GeneralItemsState initState() => GeneralItemsState(ids: <String>{}, entities: HashMap());

  GeneralItemsState copyWithItems(Iterable<GeneralItem> newItems) {
    return GeneralItemsState(
      ids: ids..addAll((newItems).map((e) => e.id)),
      entities: HashMap<String, GeneralItem>.from(entities)..addEntries((newItems).map((e) => MapEntry(e.id, e))),
    );
  }

  GeneralItemsState copyWithItem(GeneralItem newItem) => GeneralItemsState(
    ids: ids..add(newItem.id),
    entities: HashMap<String, GeneralItem>.from(entities)..putIfAbsent(newItem.id, () => newItem),
  );

}
