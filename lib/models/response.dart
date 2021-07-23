import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/run.dart';

class ResponseList {
  List<Response> responses;
  int serverTime;
  String? resumptionToken;

  ResponseList({required this.responses, required this.serverTime, this.resumptionToken});

  ResponseList.fromJson(Map json)
      : responses = json['responses'] != null
            ? (json['responses'] as List<dynamic>)
                .map<Response>((map) => Response.fromJson(map))
                .toList(growable: false)
            : [],
        resumptionToken = json['resumptionToken'],
        serverTime =
            json['serverTime'] != null ? int.parse("${json['serverTime']}") : 0;
}

class Response {
  Run? run;
  GeneralItem? item;
  String? userId;
  String? value;
  String? text;
  double? lat;
  double? lng;
  int? runId;
  int? responseId;
  int? generalItemId;
  int timestamp = new DateTime.now().millisecondsSinceEpoch;
  int? length;

  Response(
      {this.run,
      required this.item,
      this.userId,
        this.runId,
        this.lat,
      this.lng,
      this.value,
      this.text,
      this.length
      });

  Response.fromJson(Map json)
      : timestamp =
            json['timestamp'] != null ? int.parse("${json['timestamp']}") : 0,
        responseId =
            json['responseId'] != null ? int.parse("${json['responseId']}") : 0,
        length = json['length'] != null ? int.parse("${json['length']}") : 0,
        generalItemId = json['generalItemId'] != null
            ? int.parse("${json['generalItemId']}")
            : 0,
        text = json['text'],
        userId = json['userId'],
        runId = json['runId'] != null ? int.parse("${json['runId']}") : 0,
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
    if (this.run != null && this.run!.runId != null)
      map["runId"] = this.run!.runId;
    if (this.timestamp != null) map["timestamp"] = this.timestamp;
    if (this.item != null && this.item!.itemId != null)
      map["generalItemId"] = this.item!.itemId;
    if (this.userId != null) map["userId"] = this.userId;
    if (this.value != null) map["responseValue"] = this.value;
    return map;
  }
}

class PictureResponse extends Response {
  String path;
  String? remotePath;

  PictureResponse(
      {required this.path,
       Run? run,
       GeneralItem? item,
       String? userId,
       double? lat,
       double? lng,
        int? length,
      text})
      : super(
            run: run,
            item: item,
            userId: userId,
            lat: lat,
            lng: lng,
            length: length,
            text: text);

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
  String? remotePath;

  AudioResponse(
      { int? length,
      required this.path,
      Run? run,
      GeneralItem? item,
      String? userId,
      double? lat,
      double? lng})
      : super(
            path: path,
            run: run,
            item: item,
            userId: userId,
            lat: lat,
            lng: lng,
            length: length);

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
  String? remotePath;


  VideoResponse(
      {
      required this.path,
      Run? run,
      GeneralItem? item,
      String? userId,
      double? lat,
      double? lng,
      int? length})
      : super(
            path: path,
            run: run,
            item: item,
            userId: userId,
            length: length,
            lat: lat,
            lng: lng);

  Map toJson() {
    Map map = super.toJson();
    if (this.remotePath != null) {
      map["responseValue"] = this.remotePath;
      map["length"] = this.length;
    }
    return map;
  }
}
