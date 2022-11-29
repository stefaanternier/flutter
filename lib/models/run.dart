class Run {
  String get id => '$runId';
  int? runId;
  int gameId;
  String title;
  int lastModificationDate;
  int startTime;
  bool deleted;

  Run(
      {required this.gameId,
      this.runId,
      this.title = "no run title",
      required this.lastModificationDate,
      this.startTime = 0,
      this.deleted = false});

  Run.fromJson(Map json)
      : gameId = int.parse("${json['gameId']}"),
        runId = int.parse("${json['runId']}"),
        lastModificationDate = json['lastModificationDate'] == null ? 0 : int.parse("${json['lastModificationDate']}"),
        startTime = int.parse("${json['startTime']}"),
        deleted = json['deleted'] ?? false,
        title = json['title'];

  dynamic toJson() {
    return {
      'gameId': this.gameId,
      'runId': this.runId,
      'lastModificationDate': this.lastModificationDate,
      'startTime': this.startTime,
      'deleted': this.deleted,
      'title': this.title,
    };
  }
}

class RunAccess {
  final String timestamp;
  final String account;
  final String runId;
  final String gameId;
  final int accessRights;

  const RunAccess({
    required this.timestamp,
    required this.runId,
    required this.gameId,
    required this.account,
    required this.accessRights,
  });

  static fromJsonStatic(Map json) {
    return RunAccess.fromJson(json);
  }

  RunAccess.fromJson(Map json)
      : gameId = json['gameId'],
        runId = json['runId'],
        account = json['account'],
        timestamp = json['timestamp'],
        accessRights = int.parse("${json['accessRights']}");

  dynamic toJson() {
    return {
      'gameId': this.gameId,
      'runId': this.runId,
      'account': this.account,
      'timestamp': this.timestamp,
      'accessRight': this.accessRights,
    };
  }
}

class RunList {
  List<Run> runs;
  String? resumptionToken;

  RunList({required this.runs, this.resumptionToken});

  RunList.fromJson(Map json)
      : runs = json['runs'] != null
            ? (json['runs'] as List<dynamic>).map<Run>((map) => Run.fromJson(map)).toList(growable: false)
            : [],
        resumptionToken = json['nextPageToken'];
}

class ARLearnActionsList {
  List<ARLearnAction> responses;
  int serverTime;
  String? resumptionToken;

  ARLearnActionsList({required this.responses, required this.serverTime, this.resumptionToken});

  ARLearnActionsList.fromJson(Map json)
      : responses = json['actions'] != null
            ? (json['actions'] as List<dynamic>)
                .map<ARLearnAction>((map) => ARLearnAction.fromJson(map))
                .toList(growable: false)
            : [],
        resumptionToken = json['resumptionToken'],
        serverTime = json['serverTime'] != null ? int.parse("${json['serverTime']}") : 0;
}

class ARLearnAction {
  int? identifier;
  int runId;
  String action;
  int? generalItemId;
  String? account;
  int timestamp;
  String? generalItemType;

  String get key => "${action}:${generalItemId}";

  ARLearnAction(
      {this.identifier,
      required this.runId,
      required this.action,
      this.generalItemId,
      this.account,
      this.generalItemType,
      required this.timestamp});

  Map toJson() {
    Map map = new Map();
    if (this.identifier != null) map["identifier"] = this.identifier;
    if (this.runId != null) map["runId"] = this.runId;
    if (this.action != null) map["action"] = this.action;
    if (this.generalItemId != null) map["generalItemId"] = this.generalItemId;
    if (this.account != null) map["account"] = this.account;
    if (this.timestamp != null) map["timestamp"] = this.timestamp;
    if (this.generalItemType != null) map["generalItemType"] = this.generalItemType;
    return map;
  }

  ARLearnAction.fromJson(Map json)
      : identifier = json['identifier'] != null ? int.parse("${json['identifier']}") : null,
        runId = int.parse("${json['runId']}"),
        action = json['action'],
        generalItemId = json['generalItemId'] != null ? int.parse("${json['generalItemId']}") : null,
        account = json['account'],
        timestamp = int.parse("${json['timestamp']}"),
        generalItemType = json['generalItemType'];

  String getKeyUniqueWithinRun() {
    String result = this.action + ":";
    if (generalItemId != null && generalItemId != 0) result += "${generalItemId}";
    return result;
  }

  @override
  String toString() {
    return "${identifier} ${action}";
  }
}

class RunUser {
  final String identifier;
  final String runId;
  final String gameId;
  final bool deleted;

  const RunUser({
    required this.identifier,
    required this.runId,
    required this.gameId,
    required this.deleted,
  });

  static fromJsonStatic(Map json) {
    return RunUser.fromJson(json);
  }

  RunUser.fromJson(Map json)
      : gameId = json['gameId'],
        runId = json['runId'],
        deleted = json['deleted'],
        identifier = json['identifier'];

  dynamic toJson() {
    return {
      'gameId': this.gameId,
      'runId': this.runId,
      'deleted': this.deleted,
      'identifier': this.identifier,
    };
  }
}
