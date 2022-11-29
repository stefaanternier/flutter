class CollectionResponse<E> {
  final List<E> items;
  final String? resumptionToken;
  final int? from;
  final int? till;

  const CollectionResponse({
    required this.items,
    this.resumptionToken,
    this.from,
    this.till
  });

  CollectionResponse.fromJson(Map json, Function fromJsonModel, String? listName)
      : from= null,
        till= null,
        items = json[listName??'items'] != null
            ? (json[listName??'items'] as List<dynamic>)
            .map<E>((map) => fromJsonModel(map)).toList(growable: false)
            : [],
        resumptionToken = json['nextPageToken'];

  CollectionResponse<E> withFromTill(int? f, int? t) {
    return CollectionResponse(items: items, resumptionToken: this.resumptionToken, from: f, till: till);
  }
}
