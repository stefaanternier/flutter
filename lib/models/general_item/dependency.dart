
import 'dart:collection';

import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/run.dart';
import 'dart:math';

abstract class Dependency {
//  Dependency();
  Dependency();

  factory Dependency.fromJson(Map json) {
    if (json["type"] ==
        "org.celstec.arlearn2.beans.dependencies.TimeDependency") {
      return TimeDependency.fromJson(json);
    } else if (json["type"] ==
        "org.celstec.arlearn2.beans.dependencies.ActionDependency") {
      return ActionDependency.fromJson(json);
    } else if (json["type"] ==
        "org.celstec.arlearn2.beans.dependencies.ProximityDependency") {
      return ProximityDependency.fromJson(json);
    }else if (json["type"] ==
        "org.celstec.arlearn2.beans.dependencies.OrDependency") {
      return OrDependency.fromJson(json);
    }else if (json["type"] ==
        "org.celstec.arlearn2.beans.dependencies.AndDependency") {
      return AndDependency.fromJson(json);
    }
    else {
      return BooleanDependency();
    }
  }
  @override
  String toString() {
    return "I'm a dep";
  }

  int evaluate(HashMap<String, ARLearnAction> actions);

  List<LocationTrigger> locationTriggers(){
    return [];
  }
}

class BooleanDependency extends Dependency {
  BooleanDependency() : super();

  @override
  int evaluate(HashMap<String, ARLearnAction> actions) {
    return -1;
  }
}

class ActionDependency extends Dependency {
  int generalItemId;
  String action;
  int scope;

  ActionDependency.fromJson(Map json)
      : generalItemId = json["generalItemId"] != null
      ? int.parse("${json["generalItemId"]}")
      : null,
        action = json["action"],
        scope = json["scope"];

  @override
  String toString() {
    return "Action ${generalItemId} ${action} ${scope}";
  }

  @override
  int evaluate(HashMap<String, ARLearnAction> actions) {
    if (this.action == null || this.generalItemId == null) {
      //iterate allActions
      if (this.action !=null) {
        int result = -1;
        if (actions["${this.action}:${this.generalItemId}"] != null) {
          return actions["${this.action}:${this.generalItemId}"].timestamp;
        }
//        actions.forEach((string, action){
//          if (action.action == this.action) {
//            if (result == -1) {
//              result = action.timestamp;
//
//            } else {
//              result = min(result, action.timestamp);
//            }
//          }
//        });
        return result;
      }
    } else {
      ARLearnAction actionFromMap = actions["${this.action}:${generalItemId}"];
      if (actionFromMap == null) return -1;
      return actionFromMap.timestamp;
    }
    return -1;
  }
}

class TimeDependency extends Dependency {
  int timeDelta;
  Dependency offset;

  TimeDependency() : super();
  TimeDependency.fromJson(Map json)
      : timeDelta = int.parse("${json["timeDelta"]}"),
        offset = Dependency.fromJson(json["offset"]);

  @override
  String toString() {
    return "Time ${timeDelta} - child: ${this.offset}";
  }

  @override
  int evaluate(HashMap<String, ARLearnAction> actions) {
    int offsetValue = offset.evaluate(actions);
    return offsetValue == -1 ? offsetValue : offsetValue + this.timeDelta;
  }


  List<LocationTrigger> locationTriggers(){
    return offset.locationTriggers();
  }

}

class ProximityDependency extends Dependency {
  double lat;
  double lng;
  int radius;

  ProximityDependency() : super();
  ProximityDependency.fromJson(Map json)
      : lat = double.parse("${json["lat"]}"),
        lng = double.parse("${json["lng"]}"),
        radius = int.parse("${json["radius"]}");

  @override
  int evaluate(HashMap<String, ARLearnAction> actions) {
    ARLearnAction actionFromMap = actions["geo:${lat}:${lng}:${radius}"];
    if (actionFromMap == null) return -1;
    return actionFromMap.timestamp;
  }

  @override
  String toString() {
    return "Proximity lat ${lat} - lng ${lng} - r ${radius} - ";
  }

  List<LocationTrigger> locationTriggers(){
    return [LocationTrigger(lat:this.lat, lng:this.lng, radius: this.radius)];
  }
}

class OrDependency extends Dependency {

  List<Dependency> dependencies;
  OrDependency() : super();
  OrDependency.fromJson(Map json)
      : dependencies = (json["dependencies"] as List<dynamic>).map((map)=>Dependency.fromJson(map)).toList(growable: false)
  ;


  @override
  int evaluate(HashMap<String, ARLearnAction> actions) {
    int result = -1;
    for (var i = 0; i < dependencies.length; ++i) {
       int eval = dependencies[i].evaluate(actions);
       if (eval !=-1) {
         if (result == -1) {
           result = eval;
         } else {
           result = min(result, eval);
         }
       }
    }

    return result;
  }


  List<LocationTrigger> locationTriggers(){
    return dependencies.map((dep)=>dep.locationTriggers()).toList(growable: false).expand((x) => x).toList(growable: false);
  }
}


class AndDependency extends Dependency {

  List<Dependency> dependencies;
  AndDependency() : super();
  AndDependency.fromJson(Map json)
      : dependencies = (json["dependencies"] as List<dynamic>).map((map)=>Dependency.fromJson(map)).toList(growable: false)
  ;


  @override
  int evaluate(HashMap<String, ARLearnAction> actions) {
    int result = -1;
    for (var i = 0; i < dependencies.length; ++i) {
      int eval = dependencies[i].evaluate(actions);
      if (eval == -1) return -1;

          result = max(result, eval);


    }

    return result;
  }

  List<LocationTrigger> locationTriggers(){
    return dependencies.map((dep)=>dep.locationTriggers()).toList(growable: false).expand((x) => x).toList(growable: false);
  }
}
