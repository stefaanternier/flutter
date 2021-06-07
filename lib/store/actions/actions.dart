
import 'dart:convert';

class GenericWebResponseAction {

  String resultAsString;
  dynamic resultAsJson;

  GenericWebResponseAction({this.resultAsString});

  decode() {
    this.resultAsJson = jsonDecode(this.resultAsString);
  }


  getResultsAsJson() {
    if (resultAsJson == null) {
      decode();
    }
    return resultAsJson;
  }

  bool isError() {
    if (resultAsJson == null) {
      decode();
    }
    return resultAsJson["error"] != null;
  }

}
