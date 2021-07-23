class Run {
  int? runId;
  int gameId;
  String title;
  int lastModificationDate;
  int startTime;
  bool deleted;

  Run({
    required this.gameId,
    this.runId,
    this.title = "no run title",
    required this.lastModificationDate,
    this.startTime = 0,
    this.deleted = false
  });

  Run.fromJson(Map json)
      : gameId = int.parse("${json['gameId']}"),
        runId = int.parse("${json['runId']}"),
        lastModificationDate = json['lastModificationDate'] == null? 0:int.parse("${json['lastModificationDate']}"),
        startTime = int.parse("${json['startTime']}"),
        deleted= json['deleted'],
        title = json['title'];

  dynamic toJson() {
    return {
      'runId': this.runId,
      'gameId': this.gameId,
      'title': this.title,
      'lastModificationDate': this.lastModificationDate,
      'startTime': this.startTime,
      'deleted': this.deleted,
    };
  }
}

class ARLearnActionsList {
  List<ARLearnAction> responses;
  int serverTime;
  String? resumptionToken;

  ARLearnActionsList({required this.responses,required  this.serverTime,  this.resumptionToken});

  ARLearnActionsList.fromJson(Map json)
      : responses = json['actions'] != null
      ? (json['actions'] as List<dynamic>)
      .map<ARLearnAction>((map) => ARLearnAction.fromJson(map))
      .toList(growable: false)
      : [],
        resumptionToken= json['resumptionToken'],
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

  ARLearnAction({
     this.identifier,
    required this.runId,
    required this.action,
    this.generalItemId,
    this.account,
    this.generalItemType,
    required this.timestamp
  });

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

  ARLearnAction.fromJson(Map json) :
        identifier = json['identifier']!=null ? int.parse("${json['identifier']}"): null,
        runId = int.parse("${json['runId']}"),
        action= json['action'],
        generalItemId = json['generalItemId']!=null?int.parse("${json['generalItemId']}"):null,
        account= json['account'],
        timestamp = int.parse("${json['timestamp']}"),
        generalItemType = json['generalItemType'];

  String getKeyUniqueWithinRun() {
    String result = this.action+":";
    if (generalItemId!=null && generalItemId!=0) result += "${generalItemId}";
    return result;
  }

  @override
  String toString() {
    return "${identifier} ${action}";
  }
}


//
//class Response {
//  int id;
//  int generalItemId;
//  Map responseValue;
//  bool revoked;
//  int runId;
//  int timeStamp;
//  String account;
//
//  Response({
//    this.id,
//    this.generalItemId,
//    this.account,
//    this.runId,
//    this.responseValue,
//    this.revoked,
//    this.timeStamp
//});

//}
