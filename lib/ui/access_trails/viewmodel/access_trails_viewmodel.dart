import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/access_trails/service/access_trails_service.dart';
import 'package:aranduapp/ui/access_trails/model/access_trails_request.dart';
import 'package:aranduapp/ui/access_trails/model/access_trails_model.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AccessTrailsViewmodel extends ChangeNotifier {
  late Command1<List<AccessTrailsModel>, String> getTrailsCommand;

  AccessTrailsViewmodel() {
    getTrailsCommand = Command1(getTrails);
  }

  Future<Result<List<AccessTrailsModel>>> getTrails(String JourneyId) async {
    List<AccessTrailsModel> res = (await GetIt.instance<AccessTrailsService>()
        .getTrails(AccessTrailsRequest(JourneyId: JourneyId))).cast<AccessTrailsModel>();

    return Result.value(res);
  }
}
