import 'package:aranduapp/core/network/base_api.dart';
import 'package:aranduapp/ui/journey/model/journey_request.dart';
import 'package:aranduapp/ui/journey/view/journey_view.dart';
import 'package:aranduapp/ui/journey/viewmodel/journey_viewmodel.dart';

class JourneyService {
  static Future<JourneyViewModel> (JourneyRequest journeyRequest) async {
    await BaseApi.getInstance(auth: true)
      .get(path: '/journeys', data: journeyRequest.toJson());
  }
}
