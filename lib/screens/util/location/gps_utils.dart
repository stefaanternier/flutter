import 'dart:math';

class GpsUtils {
  static const  int METERS = 1;
  static const int KILOMETERS = 2;

  static const int MILES = 3;
  static const int NAUTICAL = 4;

  static double distance(double lat1, double lon1, double lat2, double lon2,
      int unit) {
    // if (lat1 == null || lat2 == null) {
    //   return null;
    // }
    // if (lon1 == null || lon2 == null) {
    //   return null;
    // }
    double theta = lon1 - lon2;
    double dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2))
        + cos(deg2rad(lat1)) * cos(deg2rad(lat2))
            * cos(deg2rad(theta));
    dist = acos(dist);
    dist = rad2deg(dist);
    dist = dist * 60 * 1.1515;
    switch (unit) {
      case METERS:
        dist = dist * 1.609344 * 1000;
        break;
      case KILOMETERS:
        dist = dist * 1.609344;
        break;
      case NAUTICAL:
        dist = dist * 0.8684;
        break;
      default:
        break;
    }

    return (dist);
  }

  static double deg2rad(double deg) {
    return (deg * pi / 180.0);
  }

  static double rad2deg(double rad) {
    return (rad * 180.0 / pi);
  }
}