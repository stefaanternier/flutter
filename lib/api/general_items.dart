import 'GenericApi.dart';

class GeneralItemsApi extends GenericApi {

  static Future<dynamic> visibleItems(int runId) async {
    final response = await GenericApi.get('api/generalItems/visible/runId/$runId');
    return response.body;
  }

  static Future<dynamic> generalItems(int gameId) async {
    final response = await GenericApi.get('api/generalItems/gameId/${gameId}');
    return response.body;
  }

  static Future<dynamic> generalItemsWithCursor(int gameId, String? nullCursor) async {
    String cursor = nullCursor ?? '*';
    final response = await GenericApi.get('api/generalItems/gameId/$gameId/cursor/$cursor');
    return response.body;
  }
}
