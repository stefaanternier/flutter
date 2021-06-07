import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/run.dart';

class ResponseList {
  List<Response> responses;
  int serverTime;
  String resumptionToken;

  ResponseList({this.responses, this.serverTime});

  ResponseList.fromJson(Map json)
      : responses = json['responses'] != null
            ? (json['responses'] as List<dynamic>)
                .map<Response>((map) => Response.fromJson(map))
                .toList(growable: false)
            : [],
        resumptionToken= json['resumptionToken'],
        serverTime = json['serverTime'] != null ? int.parse("${json['serverTime']}") : 0;
}

class Response {
  Run run;
  GeneralItem item;
  String userId;
  String value;
  String text;
  double lat;
  double lng;
  int responseId;
  int generalItemId;
  int timestamp = new DateTime.now().millisecondsSinceEpoch;
  int length;

  Response({this.run, this.item, this.userId, this.lat, this.lng, this.value, this.text});

  Response.fromJson(Map json)
      : timestamp = json['timestamp'] != null ? int.parse("${json['timestamp']}") : 0,
        responseId = json['responseId'] != null ? int.parse("${json['responseId']}") : 0,
        length = json['length'] != null ? int.parse("${json['length']}") : 0,
        generalItemId = json['generalItemId'] != null ? int.parse("${json['generalItemId']}") : 0,
        text = json['text'],
        value = json['responseValue'];

//  "responseId": "5677675511283712",
//  "generalItemId": "5685349879644160",
//  "responseValue": "run/5695700750827520/c9drXOQmlve3ezt1W5cakBcIeG43/1591188845741.jpg",
//  "lastModificationDate": "1591188865065",
//  "revoked": false

  @override
  String toString() {
    return " ${this.timestamp}";
  }

  Map toJson() {
    Map map = new Map();
    if (this.run != null && this.run.runId != null) map["runId"] = this.run.runId;
    if (this.timestamp != null) map["timestamp"] = this.timestamp;
    if (this.item != null && this.item.itemId != null) map["generalItemId"] = this.item.itemId;
    if (this.userId != null) map["userId"] = this.userId;
    if (this.value != null) map["responseValue"] = this.value;
    return map;
  }
}

class PictureResponse extends Response {
  String path;
  String remotePath;
  String text;

  PictureResponse({this.path, Run run, GeneralItem item, String userId, double lat, double lng, this.text})
      : super(run: run, item: item, userId: userId, lat: lat, lng: lng);

  @override
  String toString() {
    return path + " ${this.timestamp} ${remotePath}";
  }

  Map toJson() {
    Map map = super.toJson();
    if (this.remotePath != null) {
      map["responseValue"] = this.remotePath;
      map["text"] = this.text;
    }
    return map;
  }
}

class AudioResponse extends PictureResponse {
  String path;
  String remotePath;
  int length;

  AudioResponse({this.length, this.path, Run run, GeneralItem item, String userId, double lat, double lng})
      : super(path: path, run: run, item: item, userId: userId, lat: lat, lng: lng);

  Map toJson() {
    Map map = super.toJson();
    if (this.remotePath != null) {
      map["responseValue"] = this.remotePath;
      map["length"] = this.length;
    }
    return map;
  }
}

class VideoResponse extends PictureResponse {
  String path;
  String remotePath;
  int length;

  VideoResponse({this.length, this.path, Run run, GeneralItem item, String userId, double lat, double lng})
      : super(path: path, run: run, item: item, userId: userId, lat: lat, lng: lng);

  Map toJson() {
    Map map = super.toJson();
    if (this.remotePath != null) {
      map["responseValue"] = this.remotePath;
      map["length"] = this.length;
    }
    return map;
  }
}
