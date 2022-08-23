import 'GenericApi.dart';

class GeneralItemsApi extends GenericApi {

  static Future<dynamic> visibleItems(int runId) async {
    final response = await GenericApi.get('api/generalItems/visible/runId/$runId');
    return response.body;
  }

}
